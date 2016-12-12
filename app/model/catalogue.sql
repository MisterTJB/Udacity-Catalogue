--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    name text NOT NULL,
    image_path text
);


ALTER TABLE public.categories OWNER TO vagrant;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO vagrant;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: examples; Type: TABLE; Schema: public; Owner: vagrant; Tablespace: 
--

CREATE TABLE examples (
    id integer NOT NULL,
    category_id integer,
    name text NOT NULL,
    detail text,
    year integer,
    image_path text,
    creator_email text
);


ALTER TABLE public.examples OWNER TO vagrant;

--
-- Name: examples_id_seq; Type: SEQUENCE; Schema: public; Owner: vagrant
--

CREATE SEQUENCE examples_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.examples_id_seq OWNER TO vagrant;

--
-- Name: examples_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vagrant
--

ALTER SEQUENCE examples_id_seq OWNED BY examples.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY examples ALTER COLUMN id SET DEFAULT nextval('examples_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY categories (id, name, image_path) FROM stdin;
1	Art	img/art.png
2	Architecture	img/architecture.png
3	Furniture	img/furniture.png
4	Design	img/design.png
5	Typography	img/typography.png
6	Exhibitions	img/exhibitions.png
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('categories_id_seq', 6, true);


--
-- Data for Name: examples; Type: TABLE DATA; Schema: public; Owner: vagrant
--

COPY examples (id, category_id, name, detail, year, image_path, creator_email) FROM stdin;
1	1	Tableau I	Mondrian was a member of the Dutch De Stijl movement from its inception in 1917. By the early 1920s, in line with De Stijl practice, he restricted his compositions to predominantly off-white grounds divided by black horizontal and vertical lines that often framed subsidiary blocks of individual primary colors. Tableau I (1922), a representative example of this period, demonstrates the artist's rejection of mimesis, which he considered a reprehensibly deceptive imitation of reality.\r\n\r\nIn 1918 Mondrian created his first "losangique" paintings, such as the later Composition No. 1: Lozenge with Four Lines (1930), by tilting a square canvas 45 degrees. Most of these diamond-shaped works were created in 1925 and 1926 following his break with the De Stijl group over Theo van Doesburg's introduction of the diagonal. Mondrian felt that in so doing van Doesburg had betrayed the movement's fundamental principles, thus forfeiting the static immutability achieved through stable verticals and horizontals. Mondrian asserted, however, that his own rotated canvases maintained the desired equilibrium of the grid, while the 45-degree turn allowed for longer lines. \r\n\r\n**featured**Tableau I (1922)... demonstrates the artist's rejection of mimesis, which he considered a reprehensibly deceptive imitation of reality.\r\n\r\nArt historian Rosalind Krauss identifies the grid as "a structure that has remained emblematic of the modernist ambition." She notes that of these paintings by Mondrian, whose work has become synonymous with the grid, two signal opposing generative tendencies. Composition No. 1: Lozenge with Four Lines, in which the lines intersect just beyond the picture plane (suggesting that the work is taken from a larger whole), exemplifies a centrifugal disposition of the grid; Tableau I, whose lines stop short of the picture's edges (implying that it is a self-contained unit), evinces a centripetal tendency.	1921	1481579815.490263_Tableau_I_by_Piet_Mondriaan.jpg	tim.bathgate@gmail.com
2	1	On White II	Kandinsky’s On White II expresses an intelligent combination of the two main colors in the painting: black and white.\r\n\r\nKandinsky used color to represent more than just shapes and figures in his paintings. In this painting the many dimensions of the color white is used to represent the many possibilities and opportunities available in life. The color black, on the other hand, represents non-existence and death.\r\n\r\nKandinsky expressed the color black as the silence of death, and in this painting, the black cuts through the white background with a riotous effect, shattering the peace of the colorful combination of colors, or as it were, opportunities in life.	1923	1481580041.890491_Vassily_Kandinsky_1923_-_On_White_II.jpg	tim.bathgate@gmail.com
3	1	Broadway Boogie Woogie	Broadway Boogie Woogie is a painting by Piet Mondrian completed in 1943, shortly after he moved to New York in 1940.\r\n\r\nCompared to his earlier work, the canvas is divided into a much larger number of squares. Although he spent most of his career creating abstract work, this painting is inspired by clear real-world examples: the city grid of Manhattan, and the Broadway boogie woogie music to which Mondrian loved to dance.\r\n\r\nThe painting was bought by the Brazilian sculptor Maria Martins for the price of $800 at the Valentine Gallery in New York City, after Martins and Mondrian both exhibited there in 1943. Martins later donated the painting to the Museum of Modern Art in New York City.	1943	1481580112.755997_Piet_Mondrian_1942_-_Broadway_Boogie_Woogie.jpg	tim.bathgate@gmail.com
4	1	American Gothic	American Gothic is a painting by Grant Wood in the collection of the Art Institute of Chicago. Painted in 1930, it depicts a farmer standing beside a woman that has been interpreted to be either his wife or his daughter.\r\n\r\n**featured**Wood's inspiration came from what is now known as the American Gothic House, and his decision to paint the house along with "the kind of people I fancied should live in that house."\r\n\r\nThe figures were modeled by Wood's sister, Nan Wood Graham, and Wood and Graham's dentist, Dr. Byron McKeeby. The woman is dressed in a colonial print apron evoking 19th-century Americana, and the man is holding a pitchfork. The plants on the porch of the house are mother-in-law's tongue and beefsteak begonia, which are the same plants as in Wood's 1929 portrait of his mother, Woman with Plants.\r\n\r\nIt is one of the most familiar images in 20th-century American art, and has been widely parodied in American popular culture.	1930	1481580213.510705_Grant_Wood_-_American_Gothic_-_Google_Art_Project.jpg	tim.bathgate@gmail.com
5	2	Villa Savoye	Villa Savoye is a modernist villa in Poissy, on the outskirts of Paris, France. It was designed by Swiss architects Le Corbusier and his cousin, Pierre Jeanneret, and built between 1928 and 1931 using reinforced concrete.\r\n\r\n**featured**A manifesto of Le Corbusier's "five points" of new architecture, the villa is representative of the bases of modern architecture, and is one of the most easily recognizable and renowned examples of the International style.\r\n\r\nThe house was originally built as a country retreat on behest of the Savoye family. After being purchased by the neighbouring school it passed on to be property of the French state in 1958, and after surviving several plans of demolition, it was designated as an official French historical monument in 1965 (a rare occurrence, as Le Corbusier was still living at the time).\r\n\r\nIn July 2016, the house and several other works by Le Corbusier were inscribed as UNESCO World Heritage Sites.	1928	1481580359.144980_VillaSavoye.jpg	tim.bathgate@gmail.com
6	2	Unité d'habitation	The Unité d'habitation is the name of a modernist residential housing design principle developed by Le Corbusier, with the collaboration of painter-architect Nadir Afonso. The concept formed the basis of several housing developments designed by him throughout Europe with this name. The most famous of these developments is located in south Marseille.	1947	1481580641.065635_640px-Corbusierhaus_Berlin_B.jpg	tim.bathgate@gmail.com
7	2	Stahl House	The Stahl House (also known as Case Study House #22) is a modernist-styled house designed by architect Pierre Koenig in the Hollywood Hills section of Los Angeles, California. Photographic and anecdotal evidence suggests that the architect's client, Buck Stahl, may have provided an inspiration for the overall structure.	1959	1481580761.153257_640px-Case_Study_House_No._22.jpg	tim.bathgate@gmail.com
8	2	Eames House	Unusual for such an avant-garde design, the Eames Case Study No. 8 house was a thoroughly lived-in, usable, and well-loved home. Many icons of the modern movement are depicted as stark, barren spaces devoid of human use, but photographs and motion pictures of the Eames house reveal a richly decorated, almost cluttered space full of thousands of books, art objects, artifacts, and charming knick-knacks as well as dozens of projects in various states of completion. The Eames' gracious live-work lifestyle continues to be an influential model.\r\n\r\n**featured**The idea of a Case Study house was to hypothesize a modern household, elaborate its functional requirements, have an esteemed architect develop a design that met those requirements using modern materials and construction processes, and then to actually build the home.\r\n\r\nThe design of the house was proposed by Charles and Ray as part of the famous Case Study House program for John Entenza's Arts & Architecture magazine... The houses were documented before, during and after construction for publication in Arts & Architecture. The Eames' proposal for the Case Study House No. 8 reflected their own household and their own needs; a young married couple wanting a place to live, work and entertain in one undemanding setting in harmony with the site.	1949	1481580839.367494_Eames_house_entry.jpg	tim.bathgate@gmail.com
9	1	Just What Is It That Makes Today's Homes So Different, So Appealing	Just what is it that makes today's homes so different, so appealing? was created in 1956 for the catalogue of the exhibition This Is Tomorrow in London, England in which it was reproduced in black and white. In addition, the piece was used in posters for the exhibit. Hamilton and his friends John McHale and John Voelcker had collaborated to create the room that became the best-known part of the exhibition.\r\n\r\nHamilton subsequently created several works in which he reworked the subject and composition of the pop art collage, including a 1992 version featuring the female bodybuilder Bernie Price.\r\n\r\nAccording to a 2007 article by the art historian John-Paul Stonard, the collage consists of images taken mainly from American magazines. The principal template was an image of a modern sitting-room in an advertisement in Ladies Home Journal for Armstrong Floors, which describes the "modern fashion in floors". The title is also taken from copy in the advert, which states "Just what is it that makes today's homes so different, so appealing? Open planning of course — and a bold use of color." The body builder is Irvin "Zabo" Koszewski, winner of Mr L.A. in 1954. The photograph is taken from Tomorrow's Man magazine, September 1954. The artist Jo Baer, who posed for erotic magazines in her youth, has stated that she is the burlesque woman on the sofa, but the magazine from which the picture is taken has not been identified. The staircase is taken from an advertisement for Hoover's new model "Constellation", and it was sourced from the same issue of Ladies Home Journal, June 1955, as the Armstrong Floors ad. The picture of the cover of Young Romance was from an advertisement for the magazine included in its sister-publication Young Love (no 15, 1950). The TV is a Stromberg-Carlson, taken from a 1955 advert. Hamilton asserted that the rug was a blow-up from a photograph depicting a crowd on the Whitley Bay beach. The image of planet Earth at the top was cut from Life Magazine (Sept 1955). The original reference image for the collage from Life Magazine supplied to Hamilton is in the John McHale archives at Yale University. It was one of the first images to be laid down in the collage. The Victorian man in the portrait has not been identified. The periodical on the chair is a copy of The Journal of Commerce, founded by telegraph pioneer Samuel F. B. Morse. The tape recorder is a British-made Boosey & Hawkes "Reporter", but the source of the image has not been identified. The view through the window is a widely reproduced photograph of the exterior of a cinema in 1927 showing the premiere of the early "talkie" film, The Jazz Singer starring Al Jolson; the actual original source of the image has not yet been found.	1956	1481581213.227081_Hamilton-appealing2.jpg	tim.bathgate@gmail.com
10	6	This Is Tomorrow	This is Tomorrow was a seminal collaborative art exhibition that opened at the Whitechapel Art Gallery on August 9, 1956 and featured 12 exhibits within the show that featured collaborations between a variety of architects, painters, sculptors, and other artists. While each using their own style, they built pieces that represented their version of contemporary art. The result of the twelve groups was the attempt to evoke a variety of external environment through theories that were inspired by communications guru Marshall McLuhan, as well as symbols of pop culture. This is Tomorrow was nearly two years in the making, after architect and art critic Theo Crosby came up with the idea of mounting a large scale collaborative show at Whitechapel Gallery. By 1955 the participants were roughly divided into two camps; Constructivist, and the Independent Group, known for their meetings at the Institute of Contemporary Arts (ICA) in London with some overlap between the two groups. The 12 exhibits were each produced separately and were independent of each other. After This is Tomorrow opened nearly a thousand people a day saw the exhibit. The catalogue for the exhibit, designed by Independent member and graphic designer Edward Wright cost five shillings, a high price for 1956, sold out and had to be reprinted. This is Tomorrow is considered to be the forerunner of the British Pop Art movement.	1956	1481581291.432181_Image-3__large.jpg	tim.bathgate@gmail.com
11	3	Wassily Chair	The Wassily Chair, also known as the Model B3 chair, was designed by Marcel Breuer in 1925-1926 while he was the head of the cabinet-making workshop at the Bauhaus, in Dessau, Germany. Despite popular belief, the chair was not designed for the non-objective painter Wassily Kandinsky, who was concurrently on the Bauhaus faculty. However, Kandinsky had admired the completed design, and Breuer fabricated a duplicate for Kandinsky's personal quarters.\r\n\r\nThe chair became known as "Wassily" decades later, when it was re-released by an Italian manufacturer named Gavina who had learned of the anecdotal Kandinsky connection in the course of his research on the chair's origins.	1925	1481581425.142730_work_244.jpg	tim.bathgate@gmail.com
12	3	Panton Chair	The idea of designing a stackable plastic chair was first expressed by the German architect and designer Ludwig Mies van der Rohe before the Second World War. From the early 1950s, Panton too had dreamt of making a stackable, cantilevered plastic chair all in one piece. It is said he had been inspired in particular by a neatly stacked pile of plastic buckets. In 1956, he designed the S Chair which can be considered a forerunner of the Panton Chair. He saw it as an item of furniture in which the back, seat and legs were made of the same material and in one continuous piece. It was first produced in 1965.\r\n\r\n**featured**Panton was a contributor to the development of sleek new styles reflecting the "Space Age" of the 1960s which became known as Pop Art. The Panton Chair in particular was seen as being sleek and curvaceous. When it was unveiled in the Danish design journal Mobilia in 1967, it caused a sensation.\r\n\r\nPanton made a series of sketches and design drawings for the Panton Chair in the 1950s. In 1960, he created his first model, a plaster-cast, in collaboration with Dansk Akrylteknik. In the mid-1960s, he met Willi Fehlbaum from the furniture manufacturer Vitra who, unlike many other producers, was fascinated with the drawings of his legless chair in plastic rather than wood, the favoured material of the times. Working closely with Fehlbaum, Panton produced a cold-pressed model using polyester strengthened with fibreglass. For the first time, an entire chair had been designed in one piece, without any legs. It became known as a free-swinger. The first rather heavy model, which required substantial finishing work, was subsequently improved and adapted to industrial production using thermoplastic polystyrene which led to a marked reduction in cost. In 1968, Vitra initiated serial production of the final version which was sold by the Herman Miller Furniture Company. The material used was Baydur, a high-resilience polyurethane foam produced by Bayer in Leverkusen, Germany. It was varnished in seven colors.	1960	1481581539.032716_Panton_Stuhl.jpg	tim.bathgate@gmail.com
13	5	Helvetica	Helvetica is a widely used sans-serif typeface developed in 1957 by Swiss typeface designer Max Miedinger with input from Eduard Hoffmann.\r\n\r\nIt is a neo-grotesque or realist design, one influenced by the famous 19th century typeface Akzidenz-Grotesk and other German and Swiss designs. Its use became a hallmark of the International Typographic Style that emerged from the work of Swiss designers in the 1950s and 60s, becoming one of the most popular typefaces of the 20th century. Over the years, a wide range of variants have been released in different weights, widths and sizes, as well as matching designs for a range of non-Latin alphabets. Notable features of Helvetica as originally designed include the termination of all strokes on horizontal or vertical lines and unusually tight letter spacing, which give it a dense, compact appearance.	1957	1481581617.743438_HelveticaSpecimenCH.svg.png	tim.bathgate@gmail.com
14	5	Futura	Futura is a geometric sans-serif typeface designed in 1927 by Paul Renner. It was designed as a contribution on the New Frankfurt-project. It is based on geometric shapes that became representative of visual elements of the Bauhaus design style of 1919–33. It was commissioned as a typeface by the Bauer Type Foundry, in reaction to Ludwig & Mayer's seminal Erbar of 1922.\r\n\r\nFutura has an appearance of efficiency and forwardness. Although Renner was not associated with the Bauhaus, he shared many of its idioms and believed that a modern typeface should express modern models, rather than be a revival of a previous design. Renner's design rejected the approach of previous sans-serif designs (now often called grotesques), which were based on the models of signpainting, condensed lettering and nineteenth-century serif typefaces, in favour of simple geometric forms: near-perfect circles, triangles and squares. It is based on strokes of near-even weight, which are low in contrast. The lowercase has tall ascenders, which rise above the cap line, and uses a single-story 'a' and 'g', previously more common in handwriting than in printed text. The uppercase characters present proportions similar to those of classical Roman capitals.	1927	1481581670.628083_Futura_Specimen.svg.png	tim.bathgate@gmail.com
15	4	Poster for the Bauhaus Exhibition in Weimar	TODO: I should really write something more substantial about Joost Schmidt's "Poster for the Bauhaus Exhibition in Weimar" :)	1923	1481581853.304778_Obj.Id_74621_web_hoch.jpg	tim.bathgate@gmail.com
\.


--
-- Name: examples_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vagrant
--

SELECT pg_catalog.setval('examples_id_seq', 15, true);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: examples_pkey; Type: CONSTRAINT; Schema: public; Owner: vagrant; Tablespace: 
--

ALTER TABLE ONLY examples
    ADD CONSTRAINT examples_pkey PRIMARY KEY (id);


--
-- Name: examples_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: vagrant
--

ALTER TABLE ONLY examples
    ADD CONSTRAINT examples_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

