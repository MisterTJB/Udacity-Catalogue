INSERT INTO categories (name, image_path) VALUES
  ('Art', 'static/img/art.png'),
  ('Architecture', 'static/img/architecture.png'),
  ('Furniture', 'static/img/furniture.png'),
  ('Design', 'static/img/design.png'),
  ('Typography', 'static/img/typography.png'),
  ('People', 'static/img/people.png');

INSERT INTO users (public_id)  VALUES
  ('tim.bathgate@gmail.com'),
  ('emma.kovacs@gmail.com'),
  ('someone@gmail.com');

INSERT INTO examples (category_id,
                      name,
                      detail,
                      year_from,
                      year_to,
                      image_path,
                      owner_id) VALUES

  (1, 'On White II', 'Some detail', 1923, NULL,
   'uploads/on-white-ii-1923.jpeg', 1),
    (1, 'The Dance I', 'Some detail', 1909, NULL,
   'uploads/on-white-ii-1923.jpeg', 1),
    (1, 'Composition II in Red, Blue, and Yellow', 'Some detail', 1930, NULL,
   'uploads/Newman-Whos_Afraid_of_Red,_Yellow_and_Blue.jpg', 2),
    (1, 'Number 3', 'Some detail', 1950, NULL,
   'uploads/on-white-ii-1923.jpeg', 2),
    (1, 'No. 61 (Rust and Blue)', 'Some detail', 1953, NULL,
   'uploads/on-white-ii-1923.jpeg', 3);