CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(16) NOT NULL,
  image_path VARCHAR(256)
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  public_id VARCHAR(256) NOT NULL
);

CREATE TABLE instances (
  id SERIAL PRIMARY KEY,
  category_id INTEGER REFERENCES categories,
  name VARCHAR(16) NOT NULL,
  detail TEXT,
  year_from INTEGER,
  year_to INTEGER,
  image_path VARCHAR(256),
  owner_id INTEGER REFERENCES users
);



INSERT INTO categories (name, image_path) VALUES
  ('Blaj', 'static/img/blah.png'),
  ('Blalksgf', 'static/img/blah.png'),
  ('Blasdgdsj', 'static/img/blah.png'),
  ('Blasdgdsj', 'static/img/blah.png');

INSERT INTO users (public_id) VALUES
  ('me@me.com'),
  ('them@me.com');

INSERT INTO products (category_id, name, detail, year_to, year_from, image_path, owner_id) VALUES
  (1, 'product 1a', 'dlksg ;ldgj sdg;ljsgd lsdgsdg sdg', 1990, 2000, 'static/img/products/dkgsdg.png', 1),
  (1, 'product 1b', 'dlksg ;ldgjdgsdg sdg', 1800, null, 'static/img/products/dkgsdg.png', 2),
  (2, 'product 2a', 'dlksg ;ldgj sdg; lsdgsdg sdg', 'static/img/products/dkgsdg.png', 1),
  (2, 'product 2a', 'dlksg ;ldgj sdg;ljsgd lsdgsdg sdg', 'static/img/products/dkgsdg.png', 2),
  (3, 'product 3a', 'dlksg ;ldgj sdlsdgsdg sdg', 'static/img/products/dkgsdg.png', 1),
  (3, 'product 3b', 'dlksg ;ldgj sdg;ljsgd lsdgsdg sdg', 'static/img/products/dkgsdg.png', 2),
  (4, 'product 4a', 'dlksg ;ldgj sdg;ljsgd lsdgsdg sdg', 'static/img/products/dkgsdg.png', 1),
  (4, 'product 4b', 'dlksg ;ldgj sdg;ljsgd lsdgsdg sdg', 'static/img/products/dkgsdg.png', 2);
