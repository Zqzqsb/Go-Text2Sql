SELECT COUNT(*) FROM singer;
SELECT COUNT(*) FROM singer;
SELECT Name, Country, Age FROM singer ORDER BY Age DESC;
SELECT Name, Country, Age FROM singer ORDER BY Age DESC;
SELECT AVG(Age) AS 平均年龄, MIN(Age) AS 最小年龄, MAX(Age) AS 最大年龄 FROM singer WHERE Country = 'France';