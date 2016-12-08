CREATE TABLE categories
(
    id SERIAL PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    image_path TEXT
);

CREATE TABLE examples
(
    id SERIAL PRIMARY KEY NOT NULL,
    category_id INTEGER REFERENCES categories(id),
    name TEXT NOT NULL,
    detail TEXT,
    year_from INTEGER,
    year_to INTEGER,
    image_path TEXT,
    creator_email TEXT
);

