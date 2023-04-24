--������������ Force-Directed Graph.

SELECT @@SERVERNAME
-- ������: ageenkoas\SQLEXPRESS03
-- ���� ������: Cinema
--https://raw.githubusercontent.com/ageenkoasa/DB_Cinema/main/img/

USE Cinema;

--������� �������, �������� � ����� ������:

SELECT a.ActorID IdFirst
     , a.FullName AS First
     , CONCAT(N'Actor',a.ActorID) AS [First image name]
     , m.MovieID AS IdSecond
     , m.Title AS Second
     , CONCAT(N'Movie',m.MovieID) AS [Second image name]
FROM dbo.Actors AS a
   , dbo.ActedIn
   , dbo.Movies AS m
WHERE MATCH (a-(ActedIn)->m)


-- ������� ������, ��������������� �����������

SELECT d.DirectorID IdDirector
	 , d.FullName AS Director
     , N'Director' AS [Director image name]
     , m.MovieID AS IdMovie
     , m.Title AS Movie
     , CONCAT(N'Movie',m.MovieID) AS [Movie image name]
     , m.Rating
FROM dbo.Directors AS d
   , dbo.Recommends 
   , dbo.Movies AS mWHERE MATCH (d-(Recommends)->m)