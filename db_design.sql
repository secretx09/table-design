DROP TABLE movies;
DROP TABLE actors;
DROP TABLE genres;

CREATE TABLE movies(
    movie_id SERIAL PRIMARY KEY, 
    movie_title VARCHAR(100), 
    movie_rating INT, 
    genres INT[], 
    actors INT[]
);

CREATE TABLE actors(
    actor_id SERIAL PRIMARY KEY, 
    first_name VARCHAR(100), 
    last_name VARCHAR(100)
);

CREATE TABLE genres(
    genre_id SERIAL PRIMARY KEY, 
    genre_name VARCHAR(100)
);

INSERT INTO movies (movie_title, movie_rating, genres, actors) VALUES
('Central Intelligence', 3.5, '{1,2}', '{1,2}'), 
('Jumanji: The Next Level', 3.5, '{1,2}', '{1,2,3}'), 
('Dear Santa', 3, '{2,3}', '{3}');

INSERT INTO actors (first_name, last_name) VALUES
('Dwayne', 'Johnson'), 
('Kevin', 'Hart'), 
('Jack', 'Black');

INSERT INTO genres (genre_name) VALUES
('Action'), 
('Comedy'), 
('Holiday');

SELECT 
    movies.movie_id, 
    movies.movie_title, 
    movies.movie_rating, 
    
    (SELECT STRING_AGG(genres.genre_name, ', ') FROM genres WHERE genres.genre_id = ANY(movies.genres)) AS genres, 
    (SELECT STRING_AGG(actors.first_name || ' ' || actors.last_name, ', ') FROM actors WHERE actors.actor_id = ANY(movies.actors)) AS actors
FROM movies;
