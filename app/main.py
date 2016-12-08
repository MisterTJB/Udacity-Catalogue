from flask import Flask
from flask import render_template
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from model.catalogue import *



app = Flask(__name__)

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


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)


