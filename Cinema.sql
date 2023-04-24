USE master;
DROP DATABASE IF EXISTS Cinema;
CREATE DATABASE Cinema;
USE Cinema;

--таблицы узлов:
--Фильмы
--Режиссеры
--Актеры

CREATE TABLE Movies
(
    MovieID INT NOT NULL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ReleaseYear INT,
    Genre VARCHAR(255),
    Rating FLOAT
) AS NODE;

CREATE TABLE Directors
(
    DirectorID INT NOT NULL PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    Nationality VARCHAR(100)
) AS NODE;

CREATE TABLE Actors
(
    ActorID INT NOT NULL PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL,
    Nationality VARCHAR(100)
) AS NODE;


--таблицы ребер:
--Режиссировал
--Играет в
--Рекомендует
--Дружит с 

CREATE TABLE Directed AS EDGE; --(DirectorID INT, MovieID INT)
CREATE TABLE ActedIn(RoleAct VARCHAR(255)) AS EDGE; --(ActorID INT, MovieID INT)
CREATE TABLE Recommends AS EDGE; --(DirectorID INT, RecommendedMovieID INT)
CREATE TABLE FriendsWith AS EDGE; --(ActorID INT, ActorID INT)


--Заполнение узлов и ребер:
INSERT INTO Movies(MovieID, Title, ReleaseYear, Genre, Rating) 
VALUES (1, 'The Shawshank Redemption', 1994, 'Drama', 9.3),
       (2, 'The Godfather', 1972, 'Crime', 9.2),
       (3, 'The Godfather: Part II', 1974, 'Crime', 9.0),
       (4, 'The Dark Knight', 2008, 'Action', 9.0),
       (5, '12 Angry Men', 1957, 'Drama', 8.9),
       (6, 'Schindler''s List', 1993, 'Drama', 8.9),
       (7, 'The Lord of the Rings: The Return of the King', 2003, 'Adventure', 8.9),
       (8, 'Pulp Fiction', 1994, 'Crime', 8.9),
       (9, 'The Lord of the Rings: The Fellowship of the Ring', 2001, 'Adventure', 8.8),
       (10, 'Forrest Gump', 1994, 'Comedy', 8.8);

INSERT INTO Directors(DirectorID, FullName, Nationality)
VALUES (1, 'Frank Darabont', 'American'),
       (2, 'Francis Ford Coppola', 'American'),
       (3, 'Christopher Nolan', 'British'),
       (4, 'Sidney Lumet', 'American'),
       (5, 'Steven Spielberg', 'American'),
       (6, 'Peter Jackson', 'New Zealander'),
       (7, 'Quentin Tarantino', 'American'),
       (8, 'Robert Zemeckis', 'American');

INSERT INTO Actors(ActorID, FullName, Nationality)
VALUES (1, 'Tim Robbins', 'American'),
	   (2, 'Morgan Freeman', 'American'),
	   (3, 'Marlon Brando', 'American'),
	   (4, 'Al Pacino', 'American'),
	   (5, 'Robert De Niro', 'American'),
	   (6, 'Christian Bale', 'British'),
	   (7, 'Heath Ledger', 'Australian'),
	   (8, 'Jack Nicholson', 'American'),
	   (9, 'Henry Fonda', 'American'),
	   (10, 'Liam Neeson', 'Irish');

INSERT INTO Directed($from_id, $to_id)--(DirectorID, MovieID)
VALUES ((SELECT $node_id FROM Directors WHERE DirectorID = 1), (SELECT $node_id FROM Movies WHERE MovieID = 1)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 2), (SELECT $node_id FROM Movies WHERE MovieID = 2)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 2), (SELECT $node_id FROM Movies WHERE MovieID = 3)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 3), (SELECT $node_id FROM Movies WHERE MovieID = 4)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 4), (SELECT $node_id FROM Movies WHERE MovieID = 5)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 5), (SELECT $node_id FROM Movies WHERE MovieID = 6)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 6), (SELECT $node_id FROM Movies WHERE MovieID = 7)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 7), (SELECT $node_id FROM Movies WHERE MovieID = 8)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 6), (SELECT $node_id FROM Movies WHERE MovieID = 9)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 8), (SELECT $node_id FROM Movies WHERE MovieID = 10));

INSERT INTO ActedIn($from_id, $to_id, RoleAct)--(ActorID, MovieID, RoleAct)
VALUES 
	((SELECT $node_id FROM Actors WHERE ActorID = 1), (SELECT $node_id FROM Movies WHERE MovieID = 1), 'Andy Dufresne'),
	((SELECT $node_id FROM Actors WHERE ActorID = 2), (SELECT $node_id FROM Movies WHERE MovieID = 1), 'Ellis Boyd "Red" Redding'),
	((SELECT $node_id FROM Actors WHERE ActorID = 3), (SELECT $node_id FROM Movies WHERE MovieID = 2), 'Vito Corleone'),
	((SELECT $node_id FROM Actors WHERE ActorID = 4), (SELECT $node_id FROM Movies WHERE MovieID = 2), 'Michael Corleone'),
	((SELECT $node_id FROM Actors WHERE ActorID = 4), (SELECT $node_id FROM Movies WHERE MovieID = 3), 'Michael Corleone'),
	((SELECT $node_id FROM Actors WHERE ActorID = 6), (SELECT $node_id FROM Movies WHERE MovieID = 4), 'Batman/Bruce Wayne'),
	((SELECT $node_id FROM Actors WHERE ActorID = 7), (SELECT $node_id FROM Movies WHERE MovieID = 4), 'The Joker'),
	((SELECT $node_id FROM Actors WHERE ActorID = 9), (SELECT $node_id FROM Movies WHERE MovieID = 5), 'Juror 8'),
	((SELECT $node_id FROM Actors WHERE ActorID = 10), (SELECT $node_id FROM Movies WHERE MovieID = 6), 'Oskar Schindler'),
	((SELECT $node_id FROM Actors WHERE ActorID = 6), (SELECT $node_id FROM Movies WHERE MovieID = 7), 'Frodo Baggins'),
	((SELECT $node_id FROM Actors WHERE ActorID = 8), (SELECT $node_id FROM Movies WHERE MovieID = 7), 'Aragorn'),
	((SELECT $node_id FROM Actors WHERE ActorID = 6), (SELECT $node_id FROM Movies WHERE MovieID = 9), 'Frodo Baggins'),
	((SELECT $node_id FROM Actors WHERE ActorID = 8), (SELECT $node_id FROM Movies WHERE MovieID = 10), 'Forrest Gump');

INSERT INTO Recommends($from_id, $to_id)--(DirectorID, RecommendedMovieID)
VALUES ((SELECT $node_id FROM Directors WHERE DirectorID = 1), (SELECT $node_id FROM Movies WHERE MovieID = 6)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 2), (SELECT $node_id FROM Movies WHERE MovieID = 3)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 3), (SELECT $node_id FROM Movies WHERE MovieID = 1)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 4), (SELECT $node_id FROM Movies WHERE MovieID = 2)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 5), (SELECT $node_id FROM Movies WHERE MovieID = 1)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 6), (SELECT $node_id FROM Movies WHERE MovieID = 1)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 8), (SELECT $node_id FROM Movies WHERE MovieID = 2)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 3), (SELECT $node_id FROM Movies WHERE MovieID = 6)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 7), (SELECT $node_id FROM Movies WHERE MovieID = 9)),
	   ((SELECT $node_id FROM Directors WHERE DirectorID = 3), (SELECT $node_id FROM Movies WHERE MovieID = 10));

INSERT INTO FriendsWith($from_id, $to_id)--(ActorID, ActorID)
VALUES  ((SELECT $node_id FROM Actors WHERE ActorID = 1), (SELECT $node_id FROM Actors WHERE ActorID = 2)),
	    ((SELECT $node_id FROM Actors WHERE ActorID = 2), (SELECT $node_id FROM Actors WHERE ActorID = 3)),
	    ((SELECT $node_id FROM Actors WHERE ActorID = 3), (SELECT $node_id FROM Actors WHERE ActorID = 5)),
		((SELECT $node_id FROM Actors WHERE ActorID = 4), (SELECT $node_id FROM Actors WHERE ActorID = 2)),
		((SELECT $node_id FROM Actors WHERE ActorID = 4), (SELECT $node_id FROM Actors WHERE ActorID = 3)),
		((SELECT $node_id FROM Actors WHERE ActorID = 6), (SELECT $node_id FROM Actors WHERE ActorID = 4)),
		((SELECT $node_id FROM Actors WHERE ActorID = 7), (SELECT $node_id FROM Actors WHERE ActorID = 4)),
		((SELECT $node_id FROM Actors WHERE ActorID = 9), (SELECT $node_id FROM Actors WHERE ActorID = 5)),
		((SELECT $node_id FROM Actors WHERE ActorID = 10), (SELECT $node_id FROM Actors WHERE ActorID = 6)),
		((SELECT $node_id FROM Actors WHERE ActorID = 5), (SELECT $node_id FROM Actors WHERE ActorID = 7)),
		((SELECT $node_id FROM Actors WHERE ActorID = 8), (SELECT $node_id FROM Actors WHERE ActorID = 7)),
		((SELECT $node_id FROM Actors WHERE ActorID = 6), (SELECT $node_id FROM Actors WHERE ActorID = 9)),
		((SELECT $node_id FROM Actors WHERE ActorID = 8), (SELECT $node_id FROM Actors WHERE ActorID = 10));

ALTER TABLE Directed 
ADD CONSTRAINT EC_Directed CONNECTION (Directors TO Movies);

ALTER TABLE ActedIn 
ADD CONSTRAINT EC_ActedIn CONNECTION (Actors TO Movies);

ALTER TABLE Recommends 
ADD CONSTRAINT EC_Recommends CONNECTION (Directors TO Movies);

ALTER TABLE FriendsWith 
ADD CONSTRAINT EC_FriendsWith CONNECTION (Actors TO Actors);
GO


--Примеры запросов:
--1. Получить все фильмы, режиссером которых является Francis Ford Coppola:
SELECT DISTINCT m.Title AS [Фильмы, режиссером которых является Francis Ford Coppola]
FROM Movies AS m
   , Directors AS d
   , Directed
WHERE MATCH (d-(Directed)->m) 
	  AND d.FullName = 'Francis Ford Coppola';

--2. Получить всех актеров, игравших в фильме "The Dark Knight":
SELECT DISTINCT a.FullName AS [Актеры, игравшие в фильме The Dark Knight]
              , ActedIn.RoleAct AS [Роль]
			  , a.Nationality AS [Национальность] 
FROM Movies AS m
   , Actors AS a
   , ActedIn
WHERE MATCH(a-(ActedIn)->m) 
	  AND m.Title = 'The Dark Knight';

--3. Получить все фильмы, в которых играл Christian Bale:
SELECT m.Title AS [Фильмы, в которых играл Christian Bale]
	 , ActedIn.RoleAct AS [Роль]
FROM Movies AS m
   , Actors AS a
   , ActedIn
WHERE MATCH(a-(ActedIn)->m) 
      AND a.FullName = 'Christian Bale';

--4. Получить все фильмы, рекомендованные режиссером Christopher Nolan:
SELECT r.Title AS [Фильмы, рекомендованные режиссером Christopher Nolan]
FROM Directors AS d
   , Movies AS r
   , Recommends
WHERE MATCH (d-(Recommends)->r) 
	  AND d.FullName = 'Christopher Nolan';

--5. Получить всех режиссеров, рекомендующих фильм "The Shawshank Redemption":
SELECT d.FullName AS [Режиссеры, рекомендующие фильм The Shawshank Redemption]
FROM Directors AS d
    , Movies AS m
    , Recommends
WHERE MATCH (m<-(Recommends)-d) 
	  AND m.Title = 'The Shawshank Redemption';

--6. Найти всех актеров, которые играли в фильмах, в которых участвовал Morgan Freeman(коллег)
SELECT DISTINCT a2.FullName AS [Коллеги актера Morgan Freeman]
FROM Actors AS a1
   , ActedIn AS AI1
   , ActedIn AS AI2
   , Movies AS m
   , Actors AS a2
WHERE MATCH (a1-(AI1)->m<-(AI2)-a2) 
	  AND a1.FullName = 'Morgan Freeman' 
	  AND a2.FullName <> a1.FullName;

--7. Поиск фильмов, в которых снимался актер Jack Nicholson
SELECT STRING_AGG(m.Title, '->') WITHIN GROUP (GRAPH PATH) AS [Фильмы, в которых снимался Jack Nicholson]
FROM Actors  AS a
     , Movies FOR PATH AS m
	 , ActedIn FOR PATH 
WHERE MATCH(SHORTEST_PATH(a(-(ActedIn)->m)+)) 
      AND a.FullName = 'Jack Nicholson';

--8. Найти всех актеров, которые дружат с актерами, с которыми дружит Tim Robbins, пройдя не более 3 шагов:
SELECT a1.FullName AS [Актер]
     , STRING_AGG(a2.FullName, '->') WITHIN GROUP (GRAPH PATH) AS [Друзья друзей]
FROM Actors AS a1
   , FriendsWith FOR PATH
   , Actors FOR PATH AS a2
WHERE MATCH(SHORTEST_PATH(a1(-(FriendsWith)->a2){1,3}))
	  AND a1.FullName = 'Tim Robbins'