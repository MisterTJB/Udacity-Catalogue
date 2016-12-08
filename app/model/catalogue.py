from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()


class Category(Base):
    __tablename__ = 'categories'
    id = Column(Integer, primary_key=True)
    name = Column(String(80), nullable=False)
    image_path = Column(String(256))


class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    public_id = Column(String(256), nullable=False)


class Example(Base):
    __tablename__ = 'examples'
    id = Column(Integer, primary_key=True)
    category_id = Column(Integer, ForeignKey('categories.id'))
    category = relationship(Category)
    name = Column(String(16), nullable=False)
    detail = Column(String)
    year_from = Column(Integer)
    year_to = Column(Integer)
    image_path = Column(String(256))
    owner_id = Column(Integer, ForeignKey('users.id'))
    owner = relationship(User)