SELECT COUNT(*) FROM singer;
SELECT COUNT(*) FROM singer;
SELECT Name, Country, Age FROM singer ORDER BY Age DESC;
SELECT Name, Country, Age FROM singer ORDER BY Age DESC;
SELECT AVG(Age) AS Average_Age, MIN(Age) AS Min_Age, MAX(Age) AS Max_Age FROM singer WHERE Country = 'France';