INSERT INTO categories (name, image_path) VALUES
  ('Art', 'static/img/art.png'),
  ('Architecture', 'static/img/architecture.png'),
  ('Furniture', 'static/img/furniture.png'),
  ('Design', 'static/img/design.png'),
  ('Typography', 'static/img/typography.png'),
  ('People', 'static/img/people.png');

INSERT INTO examples (category_id,
                      name,
                      detail,
                      year,
                      image_path,
                      creator_email) VALUES

  (1, 'On White II', 'Some detail', 1923,
   'uploads/on-white-ii-1923.jpeg', 'emma.kovacs@gmail.com'),
    (1, 'The Dance I', 'Some detail', 1909,
   'uploads/on-white-ii-1923.jpeg', 'tim.bathgate@gmail.com'),
    (1, 'Composition II in Red, Blue, and Yellow', 'Some detail', NULL,
   'uploads/Newman-Whos_Afraid_of_Red,_Yellow_and_Blue.jpg', 'tim.bathgate@gmail.com'),
    (1, 'Number 3', 'Some detail', NULL,
   'uploads/on-white-ii-1923.jpeg', 'tim.bathgate@gmail.com'),
    (1, 'No. 61 (Rust and Blue)', 'Some detail', 1953,
   'uploads/on-white-ii-1923.jpeg', 'tim.bathgate@gmail.com');