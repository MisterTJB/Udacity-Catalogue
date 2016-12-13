from sqlalchemy import Column, ForeignKey, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()


class Category(Base):
    __tablename__ = 'categories'
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    image_path = Column(String)

    @property
    def serialize(self):
        """Return object data in easily serializeable format"""
        return {
            'id': self.id,
            'name': self.name,
            'image_path': "static/" + self.image_path
        }


class Example(Base):
    __tablename__ = 'examples'
    id = Column(Integer, primary_key=True)
    category_id = Column(Integer, ForeignKey('categories.id'))
    category = relationship(Category)
    name = Column(String, nullable=False)
    detail = Column(String)
    year = Column(Integer)
    image_path = Column(String)
    creator_email = Column(String)

    @property
    def serialize(self):
        """Return object data in easily serializeable format"""
        return {
            'id': self.id,
            'name': self.name,
            'detail': self.detail,
            'year': self.year,
            'image_path': "uploads/" + self.image_path,
            'creator_email': self.creator_email
        }
