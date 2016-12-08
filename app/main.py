import os
from flask import Flask, request, flash, redirect, url_for, send_from_directory
from flask import render_template
from werkzeug.utils import secure_filename
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from model.catalogue import *

UPLOAD_FOLDER = 'uploads'
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.secret_key = 'some_secret'

engine = create_engine("postgresql://127.0.0.1:5432/catalogue")
Base.metadata.bind = engine
Session = sessionmaker(bind=engine)


@app.route('/')
def index():
    session = Session()
    categories = session.query(Category).all()
    return render_template('index.html', categories=categories)

@app.route('/<category_name>/')
def category(category_name):
    session = Session()
    category_members = session.query(Example).\
        join(Example.category, aliased=True).filter_by(name=category_name.title()).all()
    return render_template('category.html',
                           category=category_name,
                           examples=category_members)

@app.route('/<category_name>/<int:example_id>')
def example(category_name, example_id):
    session = Session()
    example = session.query(Example).filter(Example.id == example_id).one()
    return render_template('example.html',
                           category=category_name,
                           example=example)

@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'],
                               filename)

@app.route('/<category_name>/new', methods=['GET', 'POST'])
def new(category_name):

    if request.method == 'GET':
        return render_template('create-edit.html',
                               category=category_name,
                               example=example)

    else:

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
            print file.filename
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
            print "FILE ALL GOOD"
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(filepath)

            print url_for('uploaded_file',
                                    filename=filename)

            name = request.form['name']
            detail = request.form['content']

            new_example = Example(name=name,
                                  detail=detail,
                                  image_path=filepath,
                                  category_id=1,
                                  owner_id=1)

            session = Session()
            session.add(new_example)
            session.commit()

            return redirect(
                url_for('category',
                        **{'category_name': category_name}))
        else:
            flash('Invalid file')
            return redirect(request.url)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)


