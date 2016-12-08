CREATE TABLE categories
(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(16) NOT NULL,
    image_path VARCHAR(256)
);

CREATE TABLE users
(
    id SERIAL PRIMARY KEY NOT NULL,
    public_id VARCHAR(256) NOT NULL
);

CREATE TABLE examples
(
    id SERIAL PRIMARY KEY NOT NULL,
    category_id INTEGER REFERENCES categories(id),
    name VARCHAR(256) NOT NULL,
    detail TEXT,
    year_from INTEGER,
    year_to INTEGER,
    image_path VARCHAR(256),
    owner_id INTEGER REFERENCES users(id)
);

