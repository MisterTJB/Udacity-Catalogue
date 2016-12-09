INSERT INTO categories (name, image_path) VALUES
  ('Art', 'img/art.png'),
  ('Architecture', 'img/architecture.png'),
  ('Furniture', 'img/furniture.png'),
  ('Design', 'img/design.png'),
  ('Typography', 'img/typography.png'),
  ('People', 'img/people.png');

INSERT INTO examples (category_id,
                      name,
                      detail,
                      year,
                      image_path,
                      creator_email) VALUES

  (1, 'On White II', 'Some detail', 1923,
   'on-white-ii-1923.jpeg', 'emma.kovacs@gmail.com'),
    (1, 'The Dance I', 'Some detail', 1909,
   'on-white-ii-1923.jpeg', 'tim.bathgate@gmail.com'),
    (1, 'Composition II in Red, Blue, and Yellow', 'Some detail', NULL,
   'Newman-Whos_Afraid_of_Red,_Yellow_and_Blue.jpg', 'tim.bathgate@gmail.com'),
    (1, 'Number 3', 'Some detail', NULL,
   'on-white-ii-1923.jpeg', 'tim.bathgate@gmail.com'),
    (1, 'No. 61 (Rust and Blue)', 'Some detail', 1953,
   'on-white-ii-1923.jpeg', 'tim.bathgate@gmail.com');