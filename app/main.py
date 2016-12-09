import os
import httplib2
import json
from oauth2client.client import flow_from_clientsecrets, FlowExchangeError
from flask import Flask, request, flash, redirect, url_for, send_from_directory
from flask import render_template
from flask import make_response
from flask import session as login_session
from werkzeug.utils import secure_filename
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from model.catalogue import *
from functools import wraps

# Configure file upload parameters and helpers
UPLOAD_FOLDER = 'uploads'
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])


def allowed_file(filename):
    """
    Determine whether a file has a valid extension

    :param filename: The name of a given file
    :return: True if the filename is allowed; False otherwise
    """
    return '.' in filename and \
           filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

# Load OAuth client id from secret.json
CLIENT_ID = json.loads(open('secret.json', 'r').read())['web']['client_id']

# Configure application
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.secret_key = 'some_secret'

# Establish a database engine and session factory
engine = create_engine("postgresql://127.0.0.1:5432/catalogue")
Base.metadata.bind = engine
Session = sessionmaker(bind=engine)


def authorship_required(f):
    """
    Decorator for views to ensure that mutations to an item can only
    be carried out by their author.

    If a user is the author, perform the mutation; otherwise, redirect
    to the enclosing category page for the item
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        session = Session()

        example_id = kwargs['example_id']
        current_user_email = login_session['email']
        results = session.query(Example).filter(
            Example.id == example_id, Example.creator_email == current_user_email).all()

        if len(results) == 0:
            return redirect(url_for('category', **kwargs))
        return f(*args, **kwargs)
    return decorated_function

def login_required(f):
    """
    Decorator for views to ensure that a user is authenticated.

    If a user is authenticated, continue with the request; otherwise
    redirect to the main page.
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not 'email' in login_session:
            return redirect(url_for('index'))
        return f(*args, **kwargs)
    return decorated_function


def category_must_exist(f):
    """
    Decorator for views rendering categories that ensures that
    the category actually exists

    If a category exists, continue with the request; otherwise,
    redirect to the main page
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        session = Session()
        matching_categories = session.query(Category).filter(
            Category.name == kwargs['category_name'].title()).all()

        if len(matching_categories) != 1:
            return redirect(url_for('index'))
        return f(*args, **kwargs)
    return decorated_function

def example_must_exist(f):
    """
    Decorator for views rendering examples that ensures that
    the example actually exists

    If a example exists, continue with the request; otherwise,
    redirect to the enclosing category
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        session = Session()
        matching_examples = session.query(Example).filter(
            Example.id == kwargs['example_id']).all()

        if len(matching_examples) != 1:
            return redirect(url_for('category', **{'category_name':
                                                       kwargs['category_name']}))
        return f(*args, **kwargs)
    return decorated_function


@app.route('/gconnect', methods=['POST'])
def gconnect():
    """
    Exchange an authorisation code for an access token and retrieve
    a user's Google email address.
    """

    # Obtain authorization code from request
    code = request.data

    try:
        # Upgrade the authorization code into a credentials object
        oauth_flow = flow_from_clientsecrets('secret.json', scope='')
        oauth_flow.redirect_uri = 'postmessage'
        credentials = oauth_flow.step2_exchange(code)
    except FlowExchangeError:
        response = make_response(
            json.dumps('Failed to upgrade the authorization code.'), 401)
        response.headers['Content-Type'] = 'application/json'
        return response

    # Check that the access token is valid.
    access_token = credentials.access_token
    url = ('https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=%s'
           % access_token)
    h = httplib2.Http()
    result = json.loads(h.request(url, 'GET')[1])

    # If there was an error in the access token info, abort.
    if result.get('error') is not None:
        response = make_response(json.dumps(result.get('error')), 500)
        response.headers['Content-Type'] = 'application/json'
        return response

    # Verify that the access token is used for the intended user.
    gplus_id = credentials.id_token['sub']
    if result['user_id'] != gplus_id:
        response = make_response(
            json.dumps("Token's user ID doesn't match given user ID."), 401)
        response.headers['Content-Type'] = 'application/json'
        return response

    # Verify that the access token is valid for this app.
    if result['issued_to'] != CLIENT_ID:
        response = make_response(
            json.dumps("Token's client ID does not match app's."), 401)
        print "Token's client ID does not match app's."
        response.headers['Content-Type'] = 'application/json'
        return response

    stored_access_token = login_session.get('access_token')
    stored_gplus_id = login_session.get('gplus_id')
    if stored_access_token is not None and gplus_id == stored_gplus_id:
        response = make_response(
            json.dumps('Current user is already connected.'),
            200)
        response.headers['Content-Type'] = 'application/json'
        return response

    # Store the access token in the session for later use.
    login_session['access_token'] = credentials.access_token
    login_session['gplus_id'] = gplus_id
    login_session['email'] = result['email']

    # Authentication was successful
    response = make_response(
            json.dumps('Successful sign in'),
            200)

    return response


@app.route('/gdisconnect')
@login_required
def gdisconnect():
    """
    End an authenticated session

    Revokes the Google access token and invalidates the session
    """

    # Revoke the access token
    access_token = login_session['access_token']
    if access_token is None:
        print 'Access Token is None'
        response = make_response(json.dumps('Current user not connected.'), 401)
        response.headers['Content-Type'] = 'application/json'
        return response
    url = 'https://accounts.google.com/o/oauth2/revoke?token=%s' % \
          login_session['access_token']
    h = httplib2.Http()
    result = h.request(url, 'GET')[0]

    # Invalidate the session
    if result['status'] == '200':
        del login_session['access_token']
        del login_session['email']
        response = make_response(json.dumps('Successfully disconnected.'), 200)
        response.headers['Content-Type'] = 'application/json'
        return response

    else:
        response = make_response(
            json.dumps('Failed to revoke token for given user.', 400))
        response.headers['Content-Type'] = 'application/json'
        return response

@app.route('/')
def index():
    """
    Handler for the main page, listing available categories
    """
    session = Session()
    categories = session.query(Category).all()
    return render_template('index.html', categories=categories)


@app.route('/<category_name>/')
@category_must_exist
def category(category_name):
    """
    Handler for category pages

    Renders a list of Examples within a category, or redirects to the main
    page if no such category exists
    """
    session = Session()
    category_members = session.query(Example).\
        join(Example.category, aliased=True).filter_by(name=category_name.title()).all()
    return render_template('category.html',
                           category=category_name,
                           examples=category_members)

@app.route('/<category_name>/<int:example_id>/')
@example_must_exist
def example(category_name, example_id):
    """
    Handler for an Example page

    Renders an Example, or redirects to the enclosing category if
    an Example does not exist with the passed in example_id
    """
    session = Session()
    example_row = session.query(Example).filter(Example.id == example_id).one()
    return render_template('example.html',
                           category=category_name,
                           example_id=example_id,
                           example=example_row)


@app.route('/uploads/<filename>')
def uploaded_file(filename):
    """
    Handler for the uploaded files directory.

    Returns a file from the uploads directory
    """
    return send_from_directory(app.config['UPLOAD_FOLDER'],
                               filename)


@app.route('/<category_name>/new', methods=['GET', 'POST'])
@category_must_exist
@login_required
def new(category_name):
    """
    Handler for creating new Examples

    Handles GET requests, which render a form for creating new Examples,
    and POST requests, which handle the completed form.
    """

    if request.method == 'GET':
        return render_template('create-edit.html',
                               category=category_name,
                               form_data=None)

    if request.method == 'POST':

        validation_errors = []

        name = request.form['name']
        detail = request.form['content']
        year = request.form['year']

        year_int = None
        if year.isdigit():
            year_int = int(year)

        if len(name) == 0:
            validation_errors.append('A title is required')

        # Validate submitted file
        file = request.files['image']
        if file.filename == '':
            validation_errors.append('An image is required')
        if not allowed_file(file.filename) and file.filename != '':
            validation_errors.append(file.filename + ' is not a valid filename')

        # If there are any validation errors, rerender the page with errors
        if len(validation_errors) > 0:
            for error in validation_errors:
                flash(error)
            return render_template('create-edit.html',
                               category=category_name,
                               form_data={
                                   'name': name,
                                   'detail': detail,
                                   'year': year
                               })

        # Upload the file
        from time import time
        filename = secure_filename("%f_%s" % (time(), file.filename))
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)

        # Insert the new Example in the database
        session = Session()
        new_example = Example(name=name,
                              detail=detail,
                              year=year_int,
                              image_path=filename,
                              category_id=session.query(Category).filter(
                                  Category.name==category_name.title()).one().id,
                              creator_email=login_session['email'])

        session.add(new_example)
        session.commit()

        return redirect(
            url_for('category',
                    **{'category_name': category_name}))


@app.route('/<category_name>/<int:example_id>/delete')
@category_must_exist
@example_must_exist
@login_required
@authorship_required
def delete(category_name, example_id):
    """
    Handler for deleting Examples

    Deletes an Example from the database, and its image file from the
    uploads directory.

    In order for a Delete to be executed, the Example must exist in the
    specified category; additionally, the initiator must be signed in as
    the user that created the Example.

    If these constraints are not satisfied, the user is redirected to a
    sensible page depending on the constraint that fails (c.f. decorator
    functions)

    A successful delete redirects the user to the enclosing category
    """
    session = Session()
    to_remove = session.query(Example).filter(Example.id == example_id)
    example_to_remove = to_remove.one()
    to_remove.delete()
    session.commit()
    os.remove(example_to_remove.image_path)

    return redirect(
        url_for('category',
                **{'category_name': category_name}))


@app.route('/<category_name>/<int:example_id>/edit', methods=['GET', 'POST'])
@category_must_exist
@example_must_exist
@login_required
@authorship_required
def edit(category_name, example_id):
    session = Session()
    to_edit = session.query(Example).filter(Example.id == example_id)
    example_to_edit = to_edit.one()

    if request.method == "GET":

        return render_template('create-edit.html',
                               category=category_name,
                               example_id=example_id,
                               example=example_to_edit,
                               form_data=example_to_edit)

    else:

        name = request.form['name']
        detail = request.form['content']
        year_from = request.form['year_from']

        def allowed_file(filename):
            return '.' in filename and \
                   filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS

        if 'image' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['image']
        # if user does not select file, browser also
        # submit a empty part without filename
        if file.filename == '':
            to_edit.update({'name': name,
                            'detail': detail})
            session.commit()
            return redirect(
                url_for('example',
                        **{'category_name': category_name,
                           'example_id': example_id}))
        elif file and allowed_file(file.filename):
            print "FILE ALL GOOD"
            os.remove(example_to_edit.image_path)
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(filepath)


            to_edit.update({'name': name,
                            'detail': detail,
                            'year_from': year_from,
                            'image_path': filepath})

            session.commit()


            return redirect(
                url_for('example',
                        **{'category_name': category_name,
                           'example_id': example_id}))
        else:
            flash('Invalid file')
            return redirect(request.url)



if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)


