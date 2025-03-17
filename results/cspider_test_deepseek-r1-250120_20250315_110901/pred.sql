SELECT COUNT(Singer_ID) FROM singer;
SELECT COUNT(Singer_ID) FROM singer;
SELECT Name, Country, Age FROM singer ORDER BY Age DESC;
SELECT Name, Country, Age FROM singer ORDER BY Age DESC;
SELECT AVG(Age) AS Average_Age, MIN(Age) AS Min_Age, MAX(Age) AS Max_Age FROM singer WHERE Country = 'France';
SELECT AVG(Age) AS AverageAge, MIN(Age) AS MinAge, MAX(Age) AS MaxAge FROM singer WHERE Country = 'France';
SELECT Song_Name, Song_release_year FROM singer WHERE Age = (SELECT MIN(Age) FROM singer);
SELECT Song_Name, Song_release_year FROM singer WHERE Age = (SELECT MIN(Age) FROM singer);
SELECT DISTINCT Country FROM singer WHERE Age > 20;
SELECT DISTINCT Country FROM singer WHERE Age > 20;
SELECT Country, COUNT(*) AS Singer_Count FROM singer GROUP BY Country;
SELECT Country, COUNT(*) AS NumberOfSingers FROM singer GROUP BY Country;
SELECT Song_Name FROM singer WHERE Age > (SELECT AVG(Age) FROM singer);
SELECT Song_Name FROM singer WHERE Age > (SELECT AVG(Age) FROM singer);
SELECT Location, Name FROM stadium WHERE Capacity BETWEEN 5000 AND 10000;
SELECT Location, Name FROM stadium WHERE Capacity BETWEEN 5000 AND 10000;
SELECT AVG(Capacity) AS AverageCapacity, MAX(Capacity) AS MaxCapacity FROM stadium;
SELECT AVG(Capacity) AS AverageCapacity, MAX(Capacity) AS MaxCapacity FROM stadium;
SELECT s.Name, s.Capacity FROM stadium s ORDER BY (s.Average * 1.0 / s.Capacity) DESC LIMIT 1;
SELECT stadium.Name, stadium.Capacity FROM stadium ORDER BY (stadium.Average / stadium.Capacity) DESC LIMIT 1;
SELECT COUNT(*) FROM concert WHERE Year IN ('2014', '2015');
SELECT COUNT(*) FROM concert WHERE Year IN ('2014', '2015');
SELECT s.Name, COUNT(c.concert_ID) AS NumberOfConcerts FROM stadium s LEFT JOIN concert c ON s.Stadium_ID = c.Stadium_ID GROUP BY s.Stadium_ID, s.Name;
SELECT s.Name, COUNT(c.concert_ID) AS Number_of_Concerts FROM stadium s LEFT JOIN concert c ON s.Stadium_ID = c.Stadium_ID GROUP BY s.Stadium_ID, s.Name;
SELECT s.Name, s.Capacity FROM stadium s JOIN ( SELECT CAST(Stadium_ID AS INTEGER) AS Stadium_ID, COUNT(*) AS concert_count FROM concert WHERE Year >= '2014' GROUP BY CAST(Stadium_ID AS INTEGER) ) AS sub ON s.Stadium_ID = sub.Stadium_ID WHERE sub.concert_count = ( SELECT MAX(concert_count) FROM ( SELECT CAST(Stadium_ID AS INTEGER) AS Stadium_ID, COUNT(*) AS concert_count FROM concert WHERE Year >= '2014' GROUP BY CAST(Stadium_ID AS INTEGER) ) AS max_sub );
SELECT stadium.Name, stadium.Capacity FROM stadium JOIN concert ON stadium.Stadium_ID = concert.Stadium_ID WHERE concert.Year > '2013' GROUP BY stadium.Stadium_ID ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Year FROM concert GROUP BY Year ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Year FROM concert GROUP BY Year HAVING COUNT(*) = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM concert GROUP BY Year) AS subquery);
SELECT s.Name FROM stadium s LEFT JOIN concert c ON s.Stadium_ID = CAST(c.Stadium_ID AS INTEGER) WHERE c.concert_ID IS NULL;
SELECT stadium.Name FROM stadium LEFT JOIN concert ON stadium.Stadium_ID = concert.Stadium_ID WHERE concert.concert_ID IS NULL;
SELECT DISTINCT s1.Country FROM singer s1 WHERE EXISTS ( SELECT 1 FROM singer s2 WHERE s2.Country = s1.Country AND s2.Age >= 40 ) AND EXISTS ( SELECT 1 FROM singer s3 WHERE s3.Country = s1.Country AND s3.Age < 30 );
SELECT Name FROM stadium WHERE Stadium_ID NOT IN (SELECT Stadium_ID FROM concert WHERE Year = '2014');
SELECT Name FROM stadium WHERE Stadium_ID NOT IN (SELECT Stadium_ID FROM concert WHERE Year = '2014');
SELECT c.concert_Name, c.Theme, COUNT(sic.Singer_ID) AS singer_count FROM concert c LEFT JOIN singer_in_concert sic ON c.concert_ID = sic.concert_ID GROUP BY c.concert_ID, c.concert_Name, c.Theme;
SELECT c.concert_Name, c.Theme, COUNT(sic.Singer_ID) AS Singer_Count FROM concert c LEFT JOIN singer_in_concert sic ON c.concert_ID = sic.concert_ID GROUP BY c.concert_ID;
SELECT singer.Name, COUNT(singer_in_concert.concert_ID) AS Concert_Count FROM singer LEFT JOIN singer_in_concert ON singer.Singer_ID = CAST(singer_in_concert.Singer_ID AS INTEGER) GROUP BY singer.Singer_ID, singer.Name;
SELECT singer.Name, COUNT(singer_in_concert.concert_ID) AS Concert_Count FROM singer LEFT JOIN singer_in_concert ON singer.Singer_ID = CAST(singer_in_concert.Singer_ID AS INTEGER) GROUP BY singer.Singer_ID, singer.Name;
SELECT DISTINCT s.Name FROM singer s JOIN singer_in_concert sic ON s.Singer_ID = sic.Singer_ID JOIN concert c ON sic.concert_ID = c.concert_ID WHERE c.Year = '2014';
SELECT DISTINCT s.Name FROM concert c JOIN singer_in_concert sic ON c.concert_ID = sic.concert_ID JOIN singer s ON sic.Singer_ID = CAST(s.Singer_ID AS TEXT) WHERE c.Year = '2014';
SELECT Singer.Name, Singer.Country FROM singer WHERE Singer.Song_Name LIKE '%你%';
SELECT Name, Country FROM singer WHERE Song_Name LIKE '%你%';
SELECT s.Name, s.Location FROM stadium s WHERE EXISTS (SELECT 1 FROM concert c1 WHERE c1.Stadium_ID = s.Stadium_ID AND c1.Year = '2014') AND EXISTS (SELECT 1 FROM concert c2 WHERE c2.Stadium_ID = s.Stadium_ID AND c2.Year = '2015');
SELECT s.Name, s.Location FROM stadium s WHERE EXISTS (SELECT 1 FROM concert c WHERE c.Stadium_ID = s.Stadium_ID AND c.Year = '2014') AND EXISTS (SELECT 1 FROM concert c WHERE c.Stadium_ID = s.Stadium_ID AND c.Year = '2015');
SELECT COUNT(*) FROM concert WHERE Stadium_ID IN (SELECT Stadium_ID FROM stadium WHERE Capacity = (SELECT MAX(Capacity) FROM stadium));
SELECT COUNT(*) FROM concert WHERE Stadium_ID IN (SELECT Stadium_ID FROM stadium WHERE Capacity = (SELECT MAX(Capacity) FROM stadium));
SELECT COUNT(*) FROM Pets WHERE weight > 10;
SELECT COUNT(*) FROM Pets WHERE weight > 10;
SELECT weight FROM Pets WHERE PetType = 'Dog' AND pet_age = (SELECT MIN(pet_age) FROM Pets WHERE PetType = 'Dog');

SELECT PetType, MAX(weight) AS MaxWeight FROM Pets GROUP BY PetType;
SELECT PetType, MAX(weight) AS MaxWeight FROM Pets GROUP BY PetType;
SELECT COUNT(*) FROM Student s JOIN Has_Pet hp ON s.StuID = hp.StuID WHERE s.Age > 20;
SELECT COUNT(*) AS TotalPets FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID WHERE Student.Age > 20;
SELECT COUNT(*) FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Student.Sex = 'Female' AND Pets.PetType = 'Dog';
SELECT COUNT(*) FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Student.Sex = 'Female' AND Pets.PetType = 'Dog';
SELECT PetType, COUNT(PetID) AS NumberOfPets FROM Pets GROUP BY PetType;
SELECT COUNT(DISTINCT PetType) AS NumPetTypes FROM Pets;
SELECT Student.Fname, Student.LName FROM Student WHERE EXISTS (SELECT 1 FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Has_Pet.StuID = Student.StuID AND Pets.PetType = 'Dog') AND EXISTS (SELECT 1 FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Has_Pet.StuID = Student.StuID AND Pets.PetType = 'Cat');
SELECT DISTINCT S.Fname, S.LName FROM Student S JOIN Has_Pet HP ON S.StuID = HP.StuID JOIN Pets P ON HP.PetID = P.PetID WHERE P.PetType IN ('Cat', 'Dog');
SELECT S.Fname, S.Lname FROM Student S WHERE EXISTS ( SELECT 1 FROM Has_Pet HP JOIN Pets P ON HP.PetID = P.PetID WHERE HP.StuID = S.StuID AND P.PetType = 'Cat' ) AND EXISTS ( SELECT 1 FROM Has_Pet HP JOIN Pets P ON HP.PetID = P.PetID WHERE HP.StuID = S.StuID AND P.PetType = 'Dog' );
SELECT DISTINCT s.Fname, s.LName FROM Student s WHERE EXISTS ( SELECT 1 FROM Has_Pet hp JOIN Pets p ON hp.PetID = p.PetID WHERE hp.StuID = s.StuID AND p.PetType = 'Cat' ) AND EXISTS ( SELECT 1 FROM Has_Pet hp JOIN Pets p ON hp.PetID = p.PetID WHERE hp.StuID = s.StuID AND p.PetType = 'Dog' );
SELECT Student.Major, Student.Age FROM Student WHERE Student.StuID NOT IN ( SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'Cat' );
SELECT Major, Age FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'Cat');
SELECT Student.StuID FROM Student WHERE Student.StuID NOT IN (SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'Cat');
SELECT Student.StuID FROM Student WHERE Student.StuID NOT IN (SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'Cat');
SELECT Student.LName, Student.Fname, Student.Age FROM Student WHERE Student.StuID IN ( SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'Dog' ) AND Student.StuID NOT IN ( SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'Cat' );
SELECT Student.Fname, Student.LName FROM Student WHERE Student.StuID IN (SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'Dog') AND Student.StuID NOT IN (SELECT Has_Pet.StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'Cat');
SELECT PetType, weight FROM Pets WHERE pet_age = (SELECT MIN(pet_age) FROM Pets);
SELECT PetType, weight FROM Pets WHERE pet_age = (SELECT MIN(pet_age) FROM Pets);
SELECT PetID, weight FROM Pets WHERE pet_age > 1;
SELECT PetID, weight FROM Pets WHERE pet_age > 1;
SELECT PetType, AVG(pet_age) AS AverageAge, MAX(pet_age) AS MaxAge FROM Pets GROUP BY PetType;
SELECT PetType, AVG(pet_age) AS AverageAge, MAX(pet_age) AS MaxAge FROM Pets GROUP BY PetType;
SELECT PetType, AVG(weight) AS AverageWeight FROM Pets GROUP BY PetType;
SELECT PetType, AVG(weight) AS AverageWeight FROM Pets GROUP BY PetType;
SELECT DISTINCT Student.Fname, Student.Lname, Student.Age FROM Student INNER JOIN Has_Pet ON Student.StuID = Has_Pet.StuID;
SELECT DISTINCT S.LName, S.Fname, S.Age FROM Student S INNER JOIN Has_Pet HP ON S.StuID = HP.StuID;
SELECT Student.StuID FROM Student INNER JOIN Has_Pet ON Student.StuID = Has_Pet.StuID WHERE Student.LName = 'Lin';
SELECT Student.StuID FROM Student WHERE LName = 'Lin' AND EXISTS (SELECT 1 FROM Has_Pet WHERE Has_Pet.StuID = Student.StuID);
SELECT Student.StuID, COUNT(Has_Pet.PetID) AS PetCount FROM Student INNER JOIN Has_Pet ON Student.StuID = Has_Pet.StuID GROUP BY Student.StuID HAVING COUNT(Has_Pet.PetID) > 0;
SELECT Student.StuID, COUNT(Has_Pet.PetID) AS PetCount FROM Student INNER JOIN Has_Pet ON Student.StuID = Has_Pet.StuID GROUP BY Student.StuID;
SELECT S.Fname, S.LName, S.Sex FROM Student S WHERE S.StuID IN (SELECT H.StuID FROM Has_Pet H GROUP BY H.StuID HAVING COUNT(*) > 1);
SELECT S.Fname, S.Sex FROM Student S JOIN Has_Pet HP ON S.StuID = HP.StuID GROUP BY S.StuID HAVING COUNT(HP.PetID) > 1;
SELECT S.LName FROM Student S INNER JOIN Has_Pet HP ON S.StuID = HP.StuID INNER JOIN Pets P ON HP.PetID = P.PetID WHERE P.PetType = 'Cat' AND P.pet_age = 3;
SELECT DISTINCT Student.LName FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'Cat' AND Pets.pet_age = 3;
SELECT AVG(Age) FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet);
SELECT AVG(Age) FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet);












































































































































































SELECT COUNT(Employee_ID) FROM employee;
SELECT COUNT(*) AS Total_Employees FROM employee;
SELECT Name FROM employee ORDER BY Age ASC;
SELECT Name FROM employee ORDER BY Age ASC;
SELECT City, COUNT(Employee_ID) AS Employee_Count FROM employee GROUP BY City;
SELECT City, COUNT(Employee_ID) AS Employee_Count FROM employee GROUP BY City;
SELECT City FROM employee WHERE Age < 30 GROUP BY City HAVING COUNT(Employee_ID) > 1;
SELECT City FROM employee WHERE Age < 30 GROUP BY City HAVING COUNT(Employee_ID) > 1;
SELECT Location, COUNT(*) AS Number_of_Shops FROM shop GROUP BY Location;
SELECT Location, COUNT(*) AS Number_of_Shops FROM shop GROUP BY Location;
SELECT Manager_name, District FROM shop WHERE Number_products = (SELECT MAX(Number_products) FROM shop);
SELECT Manager_name, District FROM shop WHERE Number_products = (SELECT MAX(Number_products) FROM shop);
SELECT MIN(Number_products) AS MinProducts, MAX(Number_products) AS MaxProducts FROM shop;
SELECT MIN(Number_products) AS MinProducts, MAX(Number_products) AS MaxProducts FROM shop;
SELECT Name, Location, District FROM shop ORDER BY Number_products DESC;
SELECT Name, Location, District FROM shop ORDER BY Number_products DESC;
SELECT Name FROM Shop WHERE Number_products > (SELECT AVG(Number_products) FROM Shop);
SELECT Name FROM shop WHERE Number_products > (SELECT AVG(Number_products) FROM shop);
SELECT e.Name FROM employee e JOIN (SELECT CAST(Employee_ID AS INTEGER) AS Employee_ID, COUNT(*) AS cnt FROM evaluation GROUP BY CAST(Employee_ID AS INTEGER)) AS t ON e.Employee_ID = t.Employee_ID WHERE t.cnt = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM evaluation GROUP BY CAST(Employee_ID AS INTEGER)) AS sub);
SELECT e.Name FROM employee e JOIN ( SELECT Employee_ID, COUNT(*) AS award_count FROM evaluation GROUP BY Employee_ID ORDER BY award_count DESC LIMIT 1 ) AS top_employee ON e.Employee_ID = CAST(top_employee.Employee_ID AS INTEGER);
SELECT employee.Name FROM employee JOIN evaluation ON employee.Employee_ID = evaluation.Employee_ID WHERE evaluation.Bonus = (SELECT MAX(Bonus) FROM evaluation);
SELECT e.Name FROM employee e JOIN evaluation ev ON e.Employee_ID = CAST(ev.Employee_ID AS INTEGER) WHERE ev.Bonus = (SELECT MAX(Bonus) FROM evaluation);
SELECT Name FROM employee WHERE Employee_ID NOT IN (SELECT CAST(Employee_ID AS INTEGER) FROM evaluation);
SELECT Name FROM employee WHERE Employee_ID NOT IN (SELECT Employee_ID FROM evaluation);
SELECT s.Name FROM shop s JOIN ( SELECT Shop_ID, COUNT(*) AS employee_count FROM hiring GROUP BY Shop_ID ORDER BY employee_count DESC LIMIT 1 ) AS max_shop ON s.Shop_ID = max_shop.Shop_ID;
SELECT s.Name FROM shop s JOIN hiring h ON s.Shop_ID = h.Shop_ID GROUP BY s.Shop_ID ORDER BY COUNT(*) DESC LIMIT 1;
SELECT s.Name FROM shop s WHERE s.Shop_ID NOT IN (SELECT DISTINCT h.Shop_ID FROM hiring h);
SELECT Shop.Name FROM Shop LEFT JOIN Hiring ON Shop.Shop_ID = Hiring.Shop_ID WHERE Hiring.Shop_ID IS NULL;
SELECT s.Name AS ShopName, COUNT(h.Employee_ID) AS EmployeeCount FROM shop s LEFT JOIN hiring h ON s.Shop_ID = h.Shop_ID GROUP BY s.Shop_ID, s.Name;
SELECT shop.Name AS Shop_Name, COUNT(hiring.Employee_ID) AS Employee_Count FROM shop LEFT JOIN hiring ON shop.Shop_ID = hiring.Shop_ID GROUP BY shop.Shop_ID;
SELECT SUM(Bonus) AS Total_Bonus FROM evaluation;
SELECT SUM(Bonus) FROM evaluation;
SELECT * FROM hiring;
SELECT * FROM Hiring;
SELECT District FROM shop GROUP BY District HAVING COUNT(CASE WHEN Number_products < 3000 THEN 1 END) > 0 AND COUNT(CASE WHEN Number_products > 10000 THEN 1 END) > 0;
SELECT District FROM shop GROUP BY District HAVING SUM(CASE WHEN Number_products < 3000 THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN Number_products > 1000 THEN 1 ELSE 0 END) > 0;
SELECT COUNT(DISTINCT Location) FROM shop;
SELECT COUNT(DISTINCT Location) FROM shop;
SELECT COUNT(*) FROM Documents;
SELECT COUNT(*) FROM Documents;
SELECT Document_ID, Document_Name, Document_Description FROM Documents;
SELECT Document_ID, Document_Name, Document_Description FROM Documents;
SELECT Document_Name, Template_ID FROM Documents WHERE Document_Description LIKE '%w%';
SELECT Document_Name, Template_ID FROM Documents WHERE Document_Description LIKE '%w%';
SELECT Document_ID, Template_ID, Document_Description FROM Documents WHERE Document_Name = 'Luo Chao''s Resume';
SELECT Document_ID, Template_ID, Document_Description FROM Documents WHERE Document_Name = 'Luo Chao''s Resume';
SELECT COUNT(DISTINCT Template_ID) FROM Documents;
SELECT COUNT(DISTINCT Template_ID) FROM Documents;
SELECT COUNT(*) FROM Documents INNER JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code = 'PPT';
SELECT COUNT(*) FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code = 'PPT';
SELECT Template_ID, COUNT(Document_ID) AS Usage_Count FROM Documents GROUP BY Template_ID;
SELECT Template_ID, COUNT(*) AS Usage_Count FROM Documents GROUP BY Template_ID;

SELECT Template_ID, Template_Type_Code FROM (SELECT t.Template_ID, t.Template_Type_Code, COUNT(d.Document_ID) AS usage_count, RANK() OVER (ORDER BY COUNT(d.Document_ID) DESC) AS rank FROM Templates t JOIN Documents d ON t.Template_ID = d.Template_ID GROUP BY t.Template_ID, t.Template_Type_Code) AS ranked WHERE rank = 1;
SELECT t.Template_ID FROM Templates t JOIN Documents d ON t.Template_ID = d.Template_ID GROUP BY t.Template_ID HAVING COUNT(d.Document_ID) > 1;
SELECT Template_ID FROM Documents GROUP BY Template_ID HAVING COUNT(Document_ID) > 1;
SELECT Templates.Template_ID FROM Templates LEFT JOIN Documents ON Templates.Template_ID = Documents.Template_ID WHERE Documents.Document_ID IS NULL;
SELECT t.Template_ID FROM Templates t LEFT JOIN Documents d ON t.Template_ID = d.Template_ID WHERE d.Document_ID IS NULL;
SELECT COUNT(*) FROM Templates;
SELECT COUNT(*) FROM Templates;
SELECT Template_ID, Version_Number, Template_Type_Code FROM Templates;
SELECT Template_ID, Version_Number, Template_Type_Code FROM Templates;
SELECT Template_Type_Code FROM Ref_Template_Types;
SELECT Template_Type_Code FROM Ref_Template_Types;
SELECT Template_ID FROM Templates WHERE Template_Type_Code IN ('PP', 'PPT');
SELECT Template_ID FROM Templates WHERE Template_Type_Code IN ('PP', 'PPT');
SELECT COUNT(*) FROM Templates WHERE Template_Type_Code = 'Resume';
SELECT COUNT(*) FROM Templates t JOIN Ref_Template_Types rtt ON t.Template_Type_Code = rtt.Template_Type_Code WHERE rtt.Template_Type_Description = 'Resume';
SELECT Version_Number, Template_Type_Code FROM Templates WHERE Version_Number > 5;
SELECT Version_Number, Template_Type_Code FROM Templates WHERE Version_Number > 5;
SELECT Ref_Template_Types.Template_Type_Code, COUNT(Templates.Template_ID) AS NumberOfTemplates FROM Ref_Template_Types LEFT JOIN Templates ON Ref_Template_Types.Template_Type_Code = Templates.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code;
SELECT Ref_Template_Types.Template_Type_Code, COUNT(Templates.Template_ID) AS Template_Count FROM Ref_Template_Types LEFT JOIN Templates ON Ref_Template_Types.Template_Type_Code = Templates.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code;
SELECT Template_Type_Code FROM Templates GROUP BY Template_Type_Code ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Template_Type_Code FROM Templates WHERE Template_ID = (SELECT Template_ID FROM Documents GROUP BY Template_ID ORDER BY COUNT(*) DESC LIMIT 1);
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types LEFT JOIN Templates ON Ref_Template_Types.Template_Type_Code = Templates.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code HAVING COUNT(Templates.Template_ID) < 3;
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types LEFT JOIN Templates ON Ref_Template_Types.Template_Type_Code = Templates.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code HAVING COUNT(Templates.Template_ID) < 3;
SELECT Version_Number, Template_Type_Code FROM Templates WHERE Version_Number = (SELECT MIN(Version_Number) FROM Templates);
SELECT Version_Number, Template_Type_Code FROM Templates WHERE Version_Number = (SELECT MIN(Version_Number) FROM Templates);
SELECT Templates.Template_Type_Code FROM Templates JOIN Documents ON Templates.Template_ID = Documents.Template_ID WHERE Documents.Document_Name = 'Database';
SELECT t.Template_Type_Code FROM Templates t JOIN Documents d ON t.Template_ID = d.Template_ID WHERE d.Document_Name = 'Database';
SELECT Document_Name FROM Documents INNER JOIN Templates ON Documents.Template_ID = Templates.Template_ID WHERE Templates.Template_Type_Code = 'BK';
SELECT d.Document_Name FROM Documents d JOIN Templates t ON d.Template_ID = t.Template_ID WHERE t.Template_Type_Code = 'BK';
SELECT R.Template_Type_Code, COUNT(D.Document_ID) AS Document_Count FROM Ref_Template_Types R LEFT JOIN Templates T ON R.Template_Type_Code = T.Template_Type_Code LEFT JOIN Documents D ON T.Template_ID = D.Template_ID GROUP BY R.Template_Type_Code;
SELECT R.Template_Type_Code, COUNT(DISTINCT D.Document_ID) AS Document_Count FROM Ref_Template_Types R LEFT JOIN Templates T ON R.Template_Type_Code = T.Template_Type_Code LEFT JOIN Documents D ON T.Template_ID = D.Template_ID GROUP BY R.Template_Type_Code;
SELECT Ref_Template_Types.Template_Type_Code FROM Ref_Template_Types JOIN Templates ON Ref_Template_Types.Template_Type_Code = Templates.Template_Type_Code JOIN Documents ON Templates.Template_ID = Documents.Template_ID GROUP BY Ref_Template_Types.Template_Type_Code ORDER BY COUNT(Documents.Document_ID) DESC LIMIT 1;
SELECT t.Template_Type_Code FROM Documents d JOIN Templates t ON d.Template_ID = t.Template_ID GROUP BY t.Template_Type_Code ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Code NOT IN (SELECT DISTINCT T.Template_Type_Code FROM Templates T JOIN Documents D ON T.Template_ID = D.Template_ID);
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Code NOT IN (SELECT DISTINCT T.Template_Type_Code FROM Templates T INNER JOIN Documents D ON T.Template_ID = D.Template_ID);
SELECT Template_Type_Code, Template_Type_Description FROM Ref_Template_Types;
SELECT Template_Type_Code, Template_Type_Description FROM Ref_Template_Types;
SELECT Template_Type_Description FROM Ref_Template_Types WHERE Template_Type_Code = 'AD';
SELECT Template_Type_Description FROM Ref_Template_Types WHERE Template_Type_Code = 'Advertisement';
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'Book';
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'Book';
SELECT DISTINCT Ref_Template_Types.Template_Type_Description FROM Ref_Template_Types INNER JOIN Templates ON Ref_Template_Types.Template_Type_Code = Templates.Template_Type_Code INNER JOIN Documents ON Templates.Template_ID = Documents.Template_ID;
SELECT DISTINCT R.Template_Type_Description FROM Documents D JOIN Templates T ON D.Template_ID = T.Template_ID JOIN Ref_Template_Types R ON T.Template_Type_Code = R.Template_Type_Code;
SELECT t.Template_ID FROM Templates t JOIN Ref_Template_Types r ON t.Template_Type_Code = r.Template_Type_Code WHERE r.Template_Type_Description = 'Presentation';
SELECT t.Template_ID FROM Templates t JOIN Ref_Template_Types r ON t.Template_Type_Code = r.Template_Type_Code WHERE r.Template_Type_Description = 'Demo';
SELECT COUNT(*) FROM Paragraphs;
SELECT COUNT(*) FROM Paragraphs;
SELECT COUNT(p.Paragraph_ID) FROM Documents d LEFT JOIN Paragraphs p ON d.Document_ID = p.Document_ID WHERE d.Document_Name = 'Summer Tour';
SELECT COUNT(*) FROM Paragraphs WHERE Document_ID IN (SELECT Document_ID FROM Documents WHERE Document_Name = 'Summer Tour');
SELECT * FROM Paragraphs WHERE Paragraph_Text LIKE '%Korean%';
SELECT * FROM Paragraphs WHERE Paragraph_Text LIKE '%Korean%';
SELECT p.Paragraph_ID, p.Paragraph_Text FROM Paragraphs p JOIN Documents d ON p.Document_ID = d.Document_ID WHERE d.Document_Name = 'Welcome To New York';
SELECT p.Paragraph_ID, p.Paragraph_Text FROM Paragraphs p JOIN Documents d ON p.Document_ID = d.Document_ID WHERE d.Document_Name = 'Welcome To New York';
SELECT p.Paragraph_Text FROM Paragraphs p INNER JOIN Documents d ON p.Document_ID = d.Document_ID WHERE d.Document_Name = 'Customer Review';
SELECT p.Paragraph_Text FROM Documents d INNER JOIN Paragraphs p ON d.Document_ID = p.Document_ID WHERE d.Document_Name = 'Customer Review';
SELECT Documents.Document_ID, COUNT(Paragraphs.Paragraph_ID) AS Paragraph_Count FROM Documents LEFT JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID ORDER BY Documents.Document_ID;
SELECT Documents.Document_ID, COUNT(Paragraphs.Paragraph_ID) AS Paragraph_Count FROM Documents LEFT JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID ORDER BY Documents.Document_ID;
SELECT d.Document_ID, d.Document_Name, COUNT(p.Paragraph_ID) AS Paragraph_Count FROM Documents d LEFT JOIN Paragraphs p ON d.Document_ID = p.Document_ID GROUP BY d.Document_ID, d.Document_Name;
SELECT d.Document_ID, d.Document_Name, COUNT(p.Paragraph_ID) AS Paragraph_Count FROM Documents d LEFT JOIN Paragraphs p ON d.Document_ID = p.Document_ID GROUP BY d.Document_ID, d.Document_Name;
SELECT d.Document_ID FROM Documents d JOIN Paragraphs p ON d.Document_ID = p.Document_ID GROUP BY d.Document_ID HAVING COUNT(p.Paragraph_ID) >= 2;
SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(Paragraph_ID) >= 2;
SELECT Documents.Document_ID, Documents.Document_Name FROM Documents WHERE Documents.Document_ID IN ( SELECT Paragraphs.Document_ID FROM Paragraphs GROUP BY Paragraphs.Document_ID HAVING COUNT(*) = ( SELECT MAX(paragraph_count) FROM ( SELECT COUNT(*) AS paragraph_count FROM Paragraphs GROUP BY Document_ID ) AS counts ) );
SELECT d.Document_ID, d.Document_Name FROM Documents d JOIN ( SELECT Document_ID, COUNT(*) AS ParagraphCount FROM Paragraphs GROUP BY Document_ID ) pc ON d.Document_ID = pc.Document_ID WHERE pc.ParagraphCount = ( SELECT MAX(ParagraphCount) FROM ( SELECT COUNT(*) AS ParagraphCount FROM Paragraphs GROUP BY Document_ID ) AS max_counts );
SELECT Document_ID FROM Documents LEFT JOIN Paragraphs USING (Document_ID) GROUP BY Document_ID HAVING COUNT(Paragraph_ID) = (SELECT MIN(cnt) FROM (SELECT COUNT(Paragraph_ID) AS cnt FROM Documents LEFT JOIN Paragraphs USING (Document_ID) GROUP BY Document_ID));
SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(*) = (SELECT MIN(cnt) FROM (SELECT COUNT(*) AS cnt FROM Paragraphs GROUP BY Document_ID) AS counts);
SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(Paragraph_ID) IN (1, 2);
SELECT Documents.Document_ID FROM Documents INNER JOIN ( SELECT Document_ID, COUNT(*) AS Paragraph_Count FROM Paragraphs GROUP BY Document_ID HAVING Paragraph_Count BETWEEN 1 AND 2 ) AS ParagraphGroups ON Documents.Document_ID = ParagraphGroups.Document_ID;
SELECT Document_ID FROM Paragraphs WHERE Paragraph_Text LIKE '%Brazil%' INTERSECT SELECT Document_ID FROM Paragraphs WHERE Paragraph_Text LIKE '%Ireland%';
SELECT DISTINCT p.Document_ID FROM Paragraphs p WHERE p.Paragraph_Text LIKE '%Brazil%' AND p.Paragraph_Text LIKE '%Ireland%';
SELECT COUNT(*) FROM teacher;
SELECT COUNT(Teacher_ID) FROM teacher;
SELECT Name FROM teacher ORDER BY Age ASC;
SELECT Name FROM teacher ORDER BY Age ASC;
SELECT Name, Age, Hometown FROM teacher;
SELECT Name, Age, Hometown FROM teacher;
SELECT Name FROM teacher WHERE Hometown != 'Xiaoganggan City District';
SELECT Name FROM teacher WHERE Hometown != 'Xiaoganggan District';
SELECT Name FROM teacher WHERE Age IN ('32', '33');
SELECT Name FROM teacher WHERE Age IN ('32', '33');
SELECT Hometown FROM teacher WHERE CAST(Age AS INTEGER) = (SELECT MIN(CAST(Age AS INTEGER)) FROM teacher);
SELECT Hometown FROM teacher WHERE CAST(Age AS INTEGER) = (SELECT MIN(CAST(Age AS INTEGER)) FROM teacher);
SELECT Hometown, COUNT(Teacher_ID) AS Teacher_Count FROM teacher GROUP BY Hometown;
SELECT Hometown, COUNT(Teacher_ID) AS Teacher_Count FROM teacher GROUP BY Hometown;
SELECT Hometown FROM teacher GROUP BY Hometown HAVING COUNT(*) = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM teacher GROUP BY Hometown) AS subquery);
SELECT Hometown FROM teacher GROUP BY Hometown ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Hometown FROM teacher GROUP BY Hometown HAVING COUNT(Teacher_ID) >= 2;
SELECT Hometown FROM teacher GROUP BY Hometown HAVING COUNT(Teacher_ID) >= 2;
SELECT t.Name, c.Course FROM teacher t JOIN course_arrange ca ON t.Teacher_ID = ca.Teacher_ID JOIN course c ON ca.Course_ID = c.Course_ID;
SELECT t.Name, c.Course FROM teacher t JOIN course_arrange ca ON t.Teacher_ID = ca.Teacher_ID JOIN course c ON ca.Course_ID = c.Course_ID;
SELECT teacher.Name, course.Course FROM teacher INNER JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID INNER JOIN course ON course_arrange.Course_ID = course.Course_ID ORDER BY teacher.Name ASC;
SELECT teacher.Name, course.Course FROM teacher INNER JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID INNER JOIN course ON course_arrange.Course_ID = course.Course_ID ORDER BY teacher.Name ASC;
SELECT t.Name FROM course c JOIN course_arrange ca ON c.Course_ID = ca.Course_ID JOIN teacher t ON ca.Teacher_ID = t.Teacher_ID WHERE c.Course = 'Math';
SELECT t.Name FROM teacher t JOIN course_arrange ca ON t.Teacher_ID = ca.Teacher_ID JOIN course c ON ca.Course_ID = c.Course_ID WHERE c.Course = 'Math';
SELECT t.Name, COUNT(ca.Course_ID) AS Course_Count FROM teacher t JOIN course_arrange ca ON t.Teacher_ID = ca.Teacher_ID GROUP BY t.Teacher_ID, t.Name;
SELECT t.Name, COUNT(ca.Course_ID) AS Course_Count FROM teacher AS t JOIN course_arrange AS ca ON t.Teacher_ID = ca.Teacher_ID GROUP BY t.Teacher_ID, t.Name;
SELECT t.Name FROM teacher t JOIN course_arrange ca ON t.Teacher_ID = ca.Teacher_ID GROUP BY ca.Teacher_ID HAVING COUNT(DISTINCT ca.Course_ID) >= 2;
SELECT t.Name FROM teacher t JOIN course_arrange ca ON t.Teacher_ID = ca.Teacher_ID GROUP BY t.Teacher_ID HAVING COUNT(DISTINCT ca.Course_ID) >= 2;
SELECT t.Name FROM teacher t LEFT JOIN course_arrange ca ON t.Teacher_ID = ca.Teacher_ID WHERE ca.Teacher_ID IS NULL;
SELECT t.Name FROM teacher t LEFT JOIN course_arrange ca ON t.Teacher_ID = ca.Teacher_ID WHERE ca.Teacher_ID IS NULL;
SELECT COUNT(*) FROM visitor WHERE Age < 30;
SELECT Name FROM visitor WHERE Level_of_membership > 4 ORDER BY Level_of_membership DESC;
SELECT AVG(Age) FROM visitor WHERE Level_of_membership <= 4;
SELECT Name, Level_of_membership FROM visitor WHERE Level_of_membership > 4 ORDER BY Age DESC;
SELECT Museum_ID, Name FROM museum WHERE Num_of_Staff = (SELECT MAX(Num_of_Staff) FROM museum);
SELECT AVG(Num_of_Staff) FROM museum WHERE Open_Year < '2009';
SELECT Open_Year, Num_of_Staff FROM museum WHERE Name = 'National Art Gallery';
SELECT Name FROM museum WHERE Num_of_Staff > (SELECT MIN(Num_of_Staff) FROM museum WHERE Open_Year > '2010');
SELECT ID, Name, Age FROM visitor WHERE ID IN (SELECT CAST(visitor_ID AS INTEGER) FROM visit GROUP BY visitor_ID HAVING COUNT(*) > 1);
SELECT v.ID, v.Name, v.Level_of_membership FROM visitor v WHERE v.ID = ( SELECT CAST(visitor_ID AS INTEGER) FROM visit GROUP BY visitor_ID ORDER BY SUM(Total_spent) DESC LIMIT 1 );
SELECT m.Museum_ID, m.Name FROM museum m JOIN (SELECT Museum_ID, COUNT(*) AS visit_count FROM visit GROUP BY Museum_ID ORDER BY visit_count DESC LIMIT 1) AS sub ON m.Museum_ID = sub.Museum_ID;
SELECT Name FROM museum WHERE Museum_ID NOT IN (SELECT Museum_ID FROM visit);
SELECT v.Name, v.Age FROM visitor v JOIN visit vt ON v.ID = vt.visitor_ID WHERE vt.Num_of_Ticket = (SELECT MAX(Num_of_Ticket) FROM visit);
SELECT AVG(Num_of_Ticket) AS Avg_Tickets, MAX(Num_of_Ticket) AS Max_Tickets FROM visit;
SELECT SUM(visit.Total_spent) FROM visit JOIN visitor ON visit.visitor_ID = visitor.ID WHERE visitor.Level_of_membership = 1;
SELECT v.Name FROM visitor v WHERE EXISTS ( SELECT 1 FROM visit vt JOIN museum m ON vt.Museum_ID = m.Museum_ID WHERE CAST(vt.visitor_ID AS INTEGER) = v.ID AND m.Open_Year < '2009' ) AND EXISTS ( SELECT 1 FROM visit vt JOIN museum m ON vt.Museum_ID = m.Museum_ID WHERE CAST(vt.visitor_ID AS INTEGER) = v.ID AND m.Open_Year > '2011' );
SELECT COUNT(*) FROM visitor WHERE ID NOT IN (SELECT CAST(visitor_ID AS INTEGER) FROM visit WHERE Museum_ID IN (SELECT Museum_ID FROM museum WHERE Open_Year = '2010'));
SELECT COUNT(*) FROM museum WHERE Open_Year < '2008' OR Open_Year > '2013';






























































SELECT COUNT(*) FROM ship WHERE disposition_of_ship = 'Captured';
SELECT name, tonnage FROM ship ORDER BY name DESC;
SELECT name, date, result FROM battle;
SELECT MAX(killed) AS max_deaths, MIN(killed) AS min_deaths FROM death;
SELECT COALESCE(SUM(d.injured), 0) * 1.0 / COUNT(DISTINCT b.id) AS average_injured_per_battle FROM battle b LEFT JOIN ship s ON b.id = s.lost_in_battle LEFT JOIN death d ON s.id = d.caused_by_ship_id;
SELECT death.* FROM death JOIN ship ON death.caused_by_ship_id = ship.id WHERE ship.tonnage = 'T';
SELECT name, result FROM battle WHERE Bulgarian_Commander != 'Boris';
SELECT DISTINCT b.id, b.name FROM battle b JOIN ship s ON b.id = s.lost_in_battle WHERE s.ship_type = 'Sailing Ship';
SELECT Battle.id, Battle.name FROM Battle JOIN Ship ON Battle.id = Ship.lost_in_battle JOIN Death ON Ship.id = Death.caused_by_ship_id GROUP BY Battle.id, Battle.name HAVING SUM(Death.killed) > 10;
SELECT ship.id, ship.name FROM ship JOIN death ON ship.id = death.caused_by_ship_id GROUP BY ship.id, ship.name ORDER BY SUM(death.killed + death.injured) DESC LIMIT 1;
SELECT name FROM battle WHERE Bulgarian_commander = 'Kaloyan' AND Latin_commander = 'Baldwin I';
SELECT COUNT(DISTINCT result) FROM battle;
SELECT COUNT(*) FROM battle WHERE id NOT IN (SELECT lost_in_battle FROM ship WHERE tonnage = '225');
SELECT Battle.name, Battle.date FROM Battle WHERE Battle.id IN (SELECT lost_in_battle FROM Ship WHERE Ship.name IN ('Expedition', 'Long March'));
SELECT b.name, b.result, b.bulgarian_commander FROM battle b WHERE b.id NOT IN ( SELECT s.lost_in_battle FROM ship s WHERE s.location = 'English Channel' );
SELECT note FROM death WHERE note LIKE '%East%';
SELECT Address FROM TableName LIMIT 2 OFFSET 0;
SELECT AddressLine1, AddressLine2 FROM Address;
SELECT COUNT(*) FROM Courses;
SELECT COUNT(*) FROM COURSES;
SELECT Description FROM Courses WHERE CourseName = 'Mathematics';
SELECT Description FROM COURSE WHERE Department = 'Mathematics';
SELECT PostalCode FROM City WHERE CityName = 'Dalian';
SELECT Postcode FROM City WHERE CityName = 'Dalian';
SELECT College.CollegeName, College.CollegeID FROM College JOIN Student ON College.CollegeID = Student.CollegeID JOIN DegreeAwarded ON Student.StudentID = DegreeAwarded.StudentID GROUP BY College.CollegeID, College.CollegeName ORDER BY COUNT(DegreeAwarded.AwardID) DESC LIMIT 1;
SELECT CollegeName FROM College WHERE CollegeID = (SELECT CollegeID FROM Degree GROUP BY CollegeID ORDER BY COUNT(*) DESC LIMIT 1);
SELECT COUNT(*) FROM Colleges WHERE CanGrantDegree = 1;
SELECT COUNT(DISTINCT D.College) FROM DEGREES AS DG JOIN DEPARTMENTS AS D ON DG.DepartmentID = D.DepartmentID;
SELECT COUNT(DISTINCT DegreeName) FROM Education;
SELECT COUNT(DISTINCT DegreeName) AS NumberOfDegrees FROM degrees;
SELECT DegreesOffered FROM Schools WHERE SchoolName = 'Engineering';
SELECT NumberOfDegrees FROM Schools WHERE SchoolName = 'Engineering';
SELECT Name, Description FROM Chapters;
SELECT Name, Description FROM Chapter;
SELECT Courses.CourseID, Courses.CourseName FROM Courses LEFT JOIN Chapters ON Courses.CourseID = Chapters.CourseID GROUP BY Courses.CourseID, Courses.CourseName HAVING COUNT(Chapters.ChapterID) <= 2;
SELECT CourseID, CourseName FROM Courses WHERE Chapters < 2;
SELECT ChapterName FROM Chapters ORDER BY ChapterName DESC;
SELECT Name FROM Chapters ORDER BY Name DESC;
SELECT Semesters.SemesterID, Semesters.SemesterName FROM Semesters JOIN Students ON Semesters.SemesterID = Students.SemesterID GROUP BY Semesters.SemesterID, Semesters.SemesterName ORDER BY COUNT(Students.StudentID) DESC LIMIT 1;
SELECT SemesterID, CASE WHEN Name = '春季学期' THEN 'Spring Semester' WHEN Name = '秋季学期' THEN 'Fall Semester' WHEN Name = '夏季学期' THEN 'Summer Semester' WHEN Name = '冬季学期' THEN 'Winter Semester' ELSE Name END AS Name FROM ( SELECT s.SemesterID, s.Name, COUNT(*) AS TotalStudents FROM Semester s JOIN Section sec USING (SemesterID) JOIN Enrollment e USING (SectionID) GROUP BY s.SemesterID, s.Name ) AS counts WHERE TotalStudents = ( SELECT MAX(TotalStudents) FROM ( SELECT COUNT(*) AS TotalStudents FROM Section sec JOIN Enrollment e USING (SectionID) GROUP BY sec.SemesterID ) AS max_counts );
SELECT Description FROM School WHERE Name LIKE '%Computer%';
SELECT Description FROM Department WHERE Name LIKE '%Computer%';
SELECT FirstName, MiddleName, LastName, StudentID FROM Students WHERE StudentID IN ( SELECT StudentID FROM StudentProgram GROUP BY StudentID, Term HAVING COUNT(DISTINCT ProgramID) >= 2 );
SELECT FirstName, MiddleName, LastName, StudentID FROM Students WHERE StudentID IN (SELECT StudentID FROM StudentDegrees GROUP BY StudentID, Semester HAVING COUNT(DISTINCT ProgramID) >= 2);
SELECT FirstName, MiddleName, LastName FROM students WHERE DegreeProgram = 'Bachelor';
SELECT Students.FirstName, Students.MiddleName, Students.LastName FROM Applications INNER JOIN Degrees ON Applications.DegreeID = Degrees.DegreeID INNER JOIN Students ON Applications.StudentID = Students.StudentID WHERE Degrees.DegreeLevel = 'Bachelor';
SELECT p.ProjectName, COUNT(e.StudentID) AS StudentCount FROM Enrollments e JOIN Projects p ON e.ProjectID = p.ProjectID GROUP BY p.ProjectID ORDER BY StudentCount DESC LIMIT 1;
SELECT DegreeName FROM DegreeSummary ORDER BY ApplicantCount DESC LIMIT 1;
SELECT Projects.ID, Projects.Abstract FROM Projects JOIN (SELECT ProjectID, COUNT(*) AS NumStudents FROM Registrations GROUP BY ProjectID) AS Counts ON Projects.ID = Counts.ProjectID WHERE NumStudents = (SELECT MAX(NumStudents) FROM (SELECT COUNT(*) AS NumStudents FROM Registrations GROUP BY ProjectID) AS MaxCount);
SELECT DegreePrograms.ProgramID, DegreePrograms.DegreeSummary FROM DegreePrograms JOIN ( SELECT Applications.ProgramID, COUNT(*) AS ApplicationCount FROM Applications GROUP BY Applications.ProgramID ORDER BY ApplicationCount DESC LIMIT 1 ) AS MaxApplications ON DegreePrograms.ProgramID = MaxApplications.ProgramID;
SELECT s.StudentID AS id, s.FirstName, s.MiddleName, s.LastName, COUNT(e.ProjectID) AS ParticipationCount, s.StudentID FROM Students s JOIN Enrollments e ON s.StudentID = e.StudentID GROUP BY s.StudentID, s.FirstName, s.MiddleName, s.LastName HAVING COUNT(e.ProjectID) = ( SELECT MAX(Counts) FROM ( SELECT COUNT(ProjectID) AS Counts FROM Enrollments GROUP BY StudentID ) AS SubQuery ) ORDER BY ParticipationCount DESC;

SELECT Semester.SemesterName FROM Semester LEFT JOIN Admission ON Semester.SemesterID = Admission.SemesterID WHERE Admission.SemesterID IS NULL;
SELECT S.SemesterName FROM Semesters S LEFT JOIN Enrollments E ON S.SemesterID = E.SemesterID WHERE E.EnrollmentID IS NULL;
SELECT DISTINCT C.CourseName FROM Courses C INNER JOIN Enrollments E ON C.CourseID = E.CourseID;
SELECT DISTINCT CourseName FROM Courses WHERE CourseID IN (SELECT CourseID FROM Registrations);
SELECT CourseName FROM Course WHERE CourseID = (SELECT CourseID FROM Enrollment GROUP BY CourseID ORDER BY COUNT(*) DESC LIMIT 1);
SELECT CourseName FROM Courses WHERE NumberOfRegistrants = (SELECT MAX(NumberOfRegistrants) FROM Courses);
SELECT LastName FROM Students WHERE State = 'Hubei' AND StudentID NOT IN (SELECT StudentID FROM Student_Degrees);
SELECT LastName FROM Students WHERE City = 'Hubei' AND StudentID NOT IN (SELECT StudentID FROM StudentDegrees);
SELECT Transcripts.TranscriptID, Transcripts.Date FROM Transcripts JOIN Grades ON Transcripts.TranscriptID = Grades.TranscriptID GROUP BY Transcripts.TranscriptID, Transcripts.Date HAVING COUNT(DISTINCT Grades.CourseID) >= 2;
SELECT TranscriptID, Date FROM Transcripts GROUP BY TranscriptID, Date HAVING COUNT(DISTINCT CourseID) >= 2;
SELECT PhoneNumber FROM Person WHERE FirstName = 'Zhong' AND LastName = 'Rui';
SELECT PhoneNumber FROM Students WHERE Name = 'Zhong Rui';
SELECT FirstName, MiddleName, LastName FROM Students ORDER BY RegistrationDate ASC LIMIT 1;
SELECT FirstName, MiddleName, LastName FROM Students ORDER BY RegistrationDate ASC LIMIT 1;
SELECT FirstName, MiddleName, LastName FROM Students WHERE GraduationDate = (SELECT MIN(GraduationDate) FROM Students);
SELECT FirstName, MiddleName, LastName FROM Students WHERE GraduationDate = (SELECT MIN(GraduationDate) FROM Students);
SELECT FirstName, LastName FROM Users WHERE CurrentAddress <> PermanentAddress;
SELECT Name FROM Students WHERE PermanentAddress != CurrentAddress;
SELECT a.AddressID, a.AddressLine1, a.AddressLine2 FROM Addresses a JOIN ( SELECT AddressID, COUNT(*) AS StudentCount FROM Students GROUP BY AddressID ORDER BY StudentCount DESC LIMIT 1 ) AS max_students ON a.AddressID = max_students.AddressID;
SELECT AddressID FROM Students GROUP BY AddressID ORDER BY COUNT(*) DESC LIMIT 2;
SELECT FROM_DAYS(AVG(TO_DAYS(PrintDate))) AS AveragePrintDate FROM Transcripts;
SELECT FROM_DAYS(AVG(TO_DAYS(Date))) AS AverageDate FROM Transcript;
SELECT TranscriptDate, Details FROM Transcripts ORDER BY TranscriptDate ASC LIMIT 1;
SELECT * FROM Transcript WHERE ReleaseDate = (SELECT MIN(ReleaseDate) FROM Transcript);
SELECT COUNT(*) FROM Transcripts WHERE PublishDate IS NOT NULL;
SELECT COUNT(*) FROM Transcripts;
SELECT MAX(PublishDate) AS LastPublishDate FROM Transcripts;
SELECT MAX(ReleaseDate) FROM Transcript;
SELECT CourseRegistrationID, COUNT(*) AS Occurrences FROM Transcripts GROUP BY CourseRegistrationID HAVING COUNT(*) = (SELECT MAX(Count) FROM (SELECT COUNT(*) AS Count FROM Transcripts GROUP BY CourseRegistrationID) AS SubQuery);
SELECT COUNT(*) AS MaxOccurrences, CourseRegisterNumber FROM Transcript GROUP BY CourseRegisterNumber ORDER BY MaxOccurrences DESC LIMIT 1;
SELECT r.ReportID, r.Date FROM Report r JOIN ( SELECT ReportID, COUNT(*) AS GradeCount FROM Grade GROUP BY ReportID ) gc ON r.ReportID = gc.ReportID WHERE gc.GradeCount = ( SELECT MIN(GradeCount) FROM ( SELECT COUNT(*) AS GradeCount FROM Grade GROUP BY ReportID ) AS subquery );
SELECT Transcript.ID, Transcript.Date FROM Transcript JOIN (SELECT TranscriptID, COUNT(*) AS GradeCount FROM Grade GROUP BY TranscriptID) AS Temp ON Transcript.ID = Temp.TranscriptID WHERE Temp.GradeCount = (SELECT MIN(GradeCount) FROM (SELECT COUNT(*) AS GradeCount FROM Grade GROUP BY TranscriptID));
SELECT DISTINCT a.Semester FROM Students a JOIN Students b ON a.Semester = b.Semester WHERE a.StudentType = 'Master' AND b.StudentType = 'Bachelor';
SELECT SemesterID FROM Enrollment WHERE StudentType IN ('Master', 'Bachelor') GROUP BY SemesterID HAVING COUNT(DISTINCT StudentType) = 2;
SELECT COUNT(DISTINCT Address) FROM Students;
SELECT DISTINCT Address FROM Students;
SELECT * FROM Students ORDER BY Name DESC;
SELECT * FROM Students ORDER BY Name DESC;
SELECT Description FROM Chapters WHERE ChapterNumber = 3;
SELECT Description FROM Chapters WHERE ChapterID = 3;
SELECT Name FROM Students WHERE Permanent_Residence_Country = 'Haiti' OR Mobile_Phone = '09700166582';
SELECT Name FROM Students WHERE PermanentResidence = 'Haiti' OR PhoneNumber = '09700166582';
SELECT Title FROM Cartoon ORDER BY Title ASC;
SELECT Title FROM Cartoon ORDER BY Title ASC;
SELECT Title FROM Cartoon WHERE Directed_by = 'Huang Weiming';
SELECT Title FROM Cartoon WHERE Directed_by = 'Wei Ming Huang';
SELECT COUNT(*) FROM Cartoon WHERE Written_by = 'Li Hui';
SELECT COUNT(*) FROM Cartoon WHERE Directed_by = 'Li Hui';
SELECT Title, Directed_by FROM Cartoon;
SELECT Title, Directed_by FROM Cartoon ORDER BY Original_air_date;
SELECT Title FROM Cartoon WHERE Directed_by = 'Huang Weiming' OR Directed_by = 'Jiang Wen';
SELECT Title FROM Cartoon WHERE Directed_by = 'Huang Weiming' OR Directed_by = 'Jiang Wen';
SELECT Country, COUNT(*) AS num_channels FROM TV_Channel GROUP BY Country HAVING COUNT(*) = (SELECT MAX(channel_count) FROM (SELECT COUNT(*) AS channel_count FROM TV_Channel GROUP BY Country)) ORDER BY num_channels DESC;
SELECT Country, COUNT(*) AS channel_count FROM TV_Channel GROUP BY Country HAVING COUNT(*) = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM TV_Channel GROUP BY Country) AS temp) ORDER BY channel_count DESC;
SELECT COUNT(DISTINCT series_name) AS series_count, COUNT(DISTINCT Content) AS content_count FROM TV_Channel;
SELECT COUNT(DISTINCT series_name) AS Distinct_Series_Count, COUNT(DISTINCT Content) AS Distinct_Content_Count FROM TV_Channel;
SELECT Content FROM TV_Channel WHERE series_name = 'Lurking';
SELECT Content FROM TV_Channel WHERE series_name = 'Undercover';
SELECT Package_Option FROM TV_Channel WHERE series_name = 'Lurking';
SELECT DISTINCT Package_Option FROM TV_Channel WHERE series_name = 'Qian Fu';
SELECT COUNT(*) FROM TV_Channel WHERE Language = 'English';
SELECT COUNT(*) FROM TV_Channel WHERE Language = 'English';
WITH RECURSIVE Split(channel_id, lang, rest) AS (
    SELECT id, '', Language || ',' FROM TV_Channel
    UNION ALL
    SELECT 
        channel_id, 
        TRIM(SUBSTR(rest, 0, INSTR(rest, ','))), 
        SUBSTR(rest, INSTR(rest, ',') + 1) 
    FROM Split WHERE rest != ''
), LanguageCounts AS (
    SELECT channel_id, COUNT(DISTINCT lang) AS lang_count 
    FROM Split WHERE lang != '' 
    GROUP BY channel_id
), MinCount AS (
    SELECT MIN(lang_count) AS min_count FROM LanguageCounts
), EligibleChannels AS (
    SELECT channel_id 
    FROM LanguageCounts 
    WHERE lang_count = (SELECT min_count FROM MinCount)
), EligibleLangs AS (
    SELECT DISTINCT lang 
    FROM Split 
    WHERE channel_id IN (SELECT channel_id FROM EligibleChannels) AND lang != ''
) SELECT GROUP_CONCAT(lang) AS Languages, (SELECT COUNT(DISTINCT channel_id) FROM EligibleChannels) AS NumberOfChannels FROM EligibleLangs;
SELECT Language, COUNT(*) AS num_channels FROM TV_Channel GROUP BY Language HAVING COUNT(*) = (SELECT MIN(count) FROM (SELECT COUNT(*) AS count FROM TV_Channel GROUP BY Language) AS counts);
SELECT Language, COUNT(id) AS Channel_Count FROM TV_Channel GROUP BY Language;
SELECT Language, COUNT(id) AS Channel_Count FROM TV_Channel GROUP BY Language;
SELECT TV_Channel.series_name FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Title = 'Black Cat Sheriff';
SELECT series_name FROM TV_series WHERE Channel = (SELECT Channel FROM Cartoon WHERE Title = 'Black Cat Sheriff');
SELECT c.Title FROM Cartoon c JOIN TV_Channel t ON c.Channel = t.id WHERE t.series_name = 'Lurking';
SELECT Cartoon.Title FROM Cartoon WHERE Cartoon.Channel IN (SELECT TV_Channel.id FROM TV_Channel WHERE TV_Channel.series_name = 'Undercover');
SELECT * FROM TV_series ORDER BY CAST(Rating AS REAL) DESC;
SELECT * FROM TV_series ORDER BY CAST(Rating AS REAL) DESC;
SELECT Episode, Rating FROM TV_series ORDER BY CAST(Rating AS REAL) DESC LIMIT 3;
SELECT Episode, Rating FROM TV_series ORDER BY CAST(Rating AS REAL) DESC LIMIT 3;
SELECT MIN(Share) AS Min_Share, MAX(Share) AS Max_Share FROM TV_series;
SELECT MAX(Share) AS Max_Share, MIN(Share) AS Min_Share FROM TV_series;
SELECT TV_series.Air_Date FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_Channel.series_name = 'Da Zhai Men';
SELECT Air_Date FROM TV_series WHERE Episode = 'The Grand Mansion Gate';
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Lifetime Of Love';
SELECT TV_series.Weekly_Rank FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_Channel.series_name = 'Da Zhai Men';
SELECT TV_Channel.series_name FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_series.Episode = 'Da Zhai Men';
SELECT TV_Channel.series_name FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_series.Episode = 'The Grand Mansion Gate';
SELECT Episode FROM TV_series WHERE Channel IN (SELECT id FROM TV_Channel WHERE series_name = 'Lurking');
SELECT TV_series.Episode FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_Channel.series_name = 'Latent';
SELECT Directed_by, COUNT(*) AS Number_of_Works FROM Cartoon GROUP BY Directed_by;
SELECT Directed_by, COUNT(*) AS Number_of_Cartoons FROM Cartoon GROUP BY Directed_by;
SELECT Production_code, Channel FROM Cartoon WHERE Original_air_date = (SELECT MAX(Original_air_date) FROM Cartoon);
SELECT Production_code, Channel FROM Cartoon ORDER BY Original_air_date DESC LIMIT 1;
SELECT TV_Channel.Package_Option, TV_Channel.series_name FROM TV_Channel WHERE TV_Channel.Hight_definition_TV = 'Yes';
SELECT TV_Channel.Package_Option, TV_Channel.series_name FROM TV_Channel WHERE TV_Channel.Hight_definition_TV = 'Yes';
SELECT DISTINCT TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Written_by = 'Bai Ying';
SELECT DISTINCT TV_Channel.Country FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE Cartoon.Written_by = 'Bai Ying';
SELECT DISTINCT Country FROM TV_Channel WHERE Country NOT IN (SELECT TV_Channel.Country FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE Cartoon.Written_by = 'Bai Ying');
SELECT DISTINCT t.Country FROM TV_Channel t WHERE t.Country NOT IN ( SELECT DISTINCT c_tv.Country FROM Cartoon c JOIN TV_Channel c_tv ON c.Channel = c_tv.id WHERE c.Written_by = 'Bai Ying' );
SELECT DISTINCT TV_Channel.series_name, TV_Channel.Country FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE Cartoon.Directed_by LIKE '%Huang Weiming%' AND Cartoon.Directed_by LIKE '%Yang Jie%';
SELECT DISTINCT TV_Channel.series_name, TV_Channel.Country FROM TV_Channel JOIN Cartoon ON TV_Channel.id = Cartoon.Channel WHERE Cartoon.Directed_by IN ('Huang Weiming', 'Yang Jie');
SELECT Pixel_aspect_ratio_PAR, Country FROM TV_Channel WHERE Language <> 'English';
SELECT TV_Channel.Country, TV_Channel.Pixel_aspect_ratio_PAR FROM TV_Channel WHERE TV_Channel.Language != 'English';
SELECT TV_Channel.id FROM TV_Channel WHERE TV_Channel.Country IN ( SELECT Country FROM TV_Channel GROUP BY Country HAVING COUNT(id) > 2 );
SELECT TV_Channel.id FROM TV_Channel WHERE TV_Channel.id IN ( SELECT Channel FROM ( SELECT Channel FROM TV_series UNION ALL SELECT Channel FROM Cartoon ) GROUP BY Channel HAVING COUNT(*) > 2 );
SELECT TV_Channel.id FROM TV_Channel WHERE TV_Channel.id NOT IN ( SELECT DISTINCT Cartoon.Channel FROM Cartoon WHERE Cartoon.Directed_by = 'Weiming Huang' );
SELECT id FROM TV_Channel WHERE id NOT IN (SELECT Channel FROM Cartoon WHERE Directed_by = 'Huang Weiming');
SELECT TV_Channel.Package_Option FROM TV_Channel WHERE TV_Channel.id NOT IN ( SELECT Cartoon.Channel FROM Cartoon WHERE Cartoon.Directed_by = 'Huang Weiming' );
SELECT Package_Option FROM TV_Channel WHERE id NOT IN (SELECT Channel FROM Cartoon WHERE Directed_by = 'Huang Weiming');
SELECT COUNT(*) FROM poker_player;
SELECT COUNT(*) FROM poker_player;
SELECT p.Name, pp.Earnings FROM poker_player pp JOIN people p ON pp.People_ID = p.People_ID ORDER BY pp.Earnings DESC;
SELECT people.Name, poker_player.Earnings FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings DESC;
SELECT poker_player.Final_Table_Made, poker_player.Best_Finish, people.Name FROM poker_player INNER JOIN people ON poker_player.People_ID = people.People_ID;
SELECT p.Name, pp.Final_Table_Made, pp.Best_Finish FROM poker_player pp JOIN people p ON pp.People_ID = p.People_ID;
SELECT AVG(Earnings) FROM poker_player;
SELECT AVG(Earnings) AS AverageEarnings FROM poker_player;
SELECT Money_Rank FROM poker_player WHERE Earnings = (SELECT MAX(Earnings) FROM poker_player);
SELECT Money_Rank FROM poker_player WHERE Earnings = (SELECT MAX(Earnings) FROM poker_player);
SELECT MAX(Final_Table_Made) FROM poker_player WHERE Earnings < 200000;
SELECT Final_Table_Made FROM poker_player WHERE Earnings < 200000;
SELECT Name FROM people JOIN poker_player ON people.People_ID = poker_player.People_ID;
SELECT DISTINCT p.Name FROM people p JOIN poker_player pp ON p.People_ID = pp.People_ID;
SELECT p.Name FROM poker_player pp INNER JOIN people p ON pp.People_ID = p.People_ID WHERE pp.Earnings > 300000;
SELECT p.Name FROM poker_player pp JOIN people p ON pp.People_ID = p.People_ID WHERE pp.Earnings > 300000;
SELECT p.Name FROM people AS p JOIN poker_player AS pp ON p.People_ID = pp.People_ID ORDER BY pp.Final_Table_Made ASC;
SELECT p.Name FROM people p JOIN poker_player pp ON p.People_ID = pp.People_ID ORDER BY pp.Final_Table_Made ASC;
SELECT p.Birth_Date FROM poker_player pp JOIN people p ON pp.People_ID = p.People_ID WHERE pp.Earnings = (SELECT MIN(Earnings) FROM poker_player) LIMIT 1;
SELECT p.Birth_Date FROM people p JOIN poker_player pp ON p.People_ID = pp.People_ID WHERE pp.Earnings = (SELECT MIN(Earnings) FROM poker_player);
SELECT poker_player.Money_Rank FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE people.Height = (SELECT MAX(Height) FROM people) LIMIT 1;
SELECT pp.Money_Rank FROM poker_player pp JOIN people p ON pp.People_ID = p.People_ID WHERE p.Height = (SELECT MAX(Height) FROM people) LIMIT 1;
SELECT AVG(poker_player.Earnings) FROM poker_player INNER JOIN people ON poker_player.People_ID = people.People_ID WHERE people.Height > 200;
SELECT AVG(poker_player.Earnings) FROM poker_player INNER JOIN people ON poker_player.People_ID = people.People_ID WHERE people.Height > 200;
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings DESC;
SELECT p.Name FROM people p JOIN poker_player pp ON p.People_ID = pp.People_ID ORDER BY pp.Earnings DESC;
SELECT p.Nationality, COUNT(*) AS Number_of_People FROM poker_player pp JOIN people p ON pp.People_ID = p.People_ID GROUP BY p.Nationality;
SELECT Nationality, COUNT(*) AS Number_of_People FROM people GROUP BY Nationality;
SELECT Nationality FROM people GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) = (SELECT MAX(count) FROM (SELECT COUNT(*) AS count FROM people GROUP BY Nationality) AS subquery);
SELECT p.Nationality FROM poker_player pp JOIN people p ON pp.People_ID = p.People_ID GROUP BY p.Nationality HAVING COUNT(DISTINCT p.People_ID) >= 2;
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2;
SELECT Name, Birth_Date FROM people ORDER BY Name;
SELECT Name, Birth_Date FROM people ORDER BY Name ASC;
SELECT Name FROM people WHERE Nationality != 'Russia';
SELECT Name FROM people WHERE Nationality != 'Russia';
SELECT Name FROM people WHERE People_ID NOT IN (SELECT People_ID FROM poker_player);
SELECT p.Name FROM people p LEFT JOIN poker_player pp ON p.People_ID = pp.People_ID WHERE pp.People_ID IS NULL;
SELECT COUNT(DISTINCT Nationality) FROM people;
SELECT COUNT(DISTINCT Nationality) FROM people;







































































































































SELECT COUNT(*) FROM conductor;
SELECT COUNT(*) FROM conductor;
SELECT Name FROM conductor ORDER BY Year_of_Work ASC;
SELECT Name FROM conductor ORDER BY Age;
SELECT Name FROM conductor WHERE Nationality != 'United States';
SELECT Name FROM conductor WHERE Nationality != 'United States';
SELECT DISTINCT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC;
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC;
SELECT AVG(Attendance) FROM show;
SELECT AVG(Attendance) FROM show;
SELECT Type FROM performance WHERE Type != 'Final Live' AND CAST(Share AS REAL) = (SELECT MAX(CAST(Share AS REAL)) FROM performance WHERE Type != 'Final Live') UNION SELECT Type FROM performance WHERE Type != 'Final Live' AND CAST(Share AS REAL) = (SELECT MIN(CAST(Share AS REAL)) FROM performance WHERE Type != 'Final Live');
SELECT MAX(CAST(Share AS REAL)) AS Max_Share, MIN(CAST(Share AS REAL)) AS Min_Share FROM performance WHERE Type != 'Final Live';
SELECT COUNT(DISTINCT Nationality) FROM conductor;
SELECT COUNT(DISTINCT Nationality) FROM conductor;
SELECT Name FROM conductor ORDER BY Year_of_Work DESC;
SELECT Name FROM conductor ORDER BY Year_of_Work DESC;
SELECT Name FROM conductor WHERE Year_of_Work = (SELECT MAX(Year_of_Work) FROM conductor);
SELECT Name FROM conductor WHERE Year_of_Work = (SELECT MAX(Year_of_Work) FROM conductor);
SELECT c.Name, o.Orchestra FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID;
SELECT conductor.Name, orchestra.Orchestra FROM conductor JOIN orchestra ON conductor.Conductor_ID = orchestra.Conductor_ID;
SELECT c.Name FROM conductor c WHERE c.Conductor_ID IN (SELECT o.Conductor_ID FROM orchestra o GROUP BY o.Conductor_ID HAVING COUNT(DISTINCT o.Orchestra_ID) > 1);
SELECT c.Name FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID GROUP BY c.Conductor_ID HAVING COUNT(DISTINCT o.Orchestra_ID) > 1;
SELECT c.Name FROM conductor c JOIN ( SELECT Conductor_ID, COUNT(*) AS orchestra_count FROM orchestra GROUP BY Conductor_ID ) oc ON c.Conductor_ID = oc.Conductor_ID WHERE oc.orchestra_count = ( SELECT MAX(orchestra_count) FROM ( SELECT COUNT(*) AS orchestra_count FROM orchestra GROUP BY Conductor_ID ) AS max_count );
SELECT c.Name FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID GROUP BY c.Conductor_ID ORDER BY COUNT(DISTINCT o.Orchestra_ID) DESC LIMIT 1;
SELECT DISTINCT c.Name FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID WHERE o.Year_of_Founded > 2008;
SELECT DISTINCT conductor.Name FROM conductor JOIN orchestra ON conductor.Conductor_ID = orchestra.Conductor_ID WHERE orchestra.Year_of_Founded > 2008;
SELECT Record_Company, COUNT(Orchestra_ID) AS Number_of_Orchestras FROM orchestra GROUP BY Record_Company;
SELECT Record_Company, COUNT(Orchestra_ID) AS Managed_Orchestras FROM orchestra GROUP BY Record_Company;
SELECT "Major_Record_Format", COUNT(*) AS Count FROM orchestra GROUP BY "Major_Record_Format" ORDER BY Count ASC;
SELECT Major_Record_Format, COUNT(*) AS Frequency FROM orchestra GROUP BY Major_Record_Format ORDER BY Frequency DESC;
SELECT Record_Company FROM orchestra GROUP BY Record_Company HAVING COUNT(*) = ( SELECT MAX(count_company) FROM ( SELECT COUNT(*) AS count_company FROM orchestra GROUP BY Record_Company ) AS counts );
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC LIMIT 1;
SELECT o.Orchestra FROM orchestra o LEFT JOIN performance p ON o.Orchestra_ID = p.Orchestra_ID WHERE p.Orchestra_ID IS NULL;
SELECT o.Orchestra FROM orchestra o LEFT JOIN performance p ON o.Orchestra_ID = p.Orchestra_ID WHERE p.Orchestra_ID IS NULL;
SELECT Record_Company FROM orchestra WHERE Record_Company IS NOT NULL GROUP BY Record_Company HAVING SUM(Year_of_Founded < 2003) > 0 AND SUM(Year_of_Founded >= 2003) > 0;
SELECT DISTINCT o1.Record_Company FROM orchestra o1 WHERE o1.Year_of_Founded < 2003 AND EXISTS ( SELECT 1 FROM orchestra o2 WHERE o2.Record_Company = o1.Record_Company AND o2.Year_of_Founded >= 2003 );
SELECT COUNT(*) FROM orchestra WHERE Major_Record_Format IN ('CD', 'DVD');
SELECT COUNT(*) FROM orchestra WHERE Major_Record_Format IN ('CD', 'DVD');
SELECT o.Year_of_Founded FROM orchestra o JOIN performance p ON o.Orchestra_ID = p.Orchestra_ID GROUP BY o.Orchestra_ID HAVING COUNT(p.Performance_ID) > 1;
SELECT Year_of_Founded FROM orchestra WHERE Orchestra_ID IN (SELECT Orchestra_ID FROM performance GROUP BY Orchestra_ID HAVING COUNT(*) > 1);
SELECT COUNT(*) FROM Highschooler;
SELECT COUNT(*) FROM Highschooler;
SELECT name, grade FROM Highschooler;
SELECT name, grade FROM Highschooler;
SELECT grade FROM Highschooler;
SELECT name, grade FROM Highschooler;
SELECT grade FROM Highschooler WHERE name = 'Xiaojun';
SELECT grade FROM Highschooler WHERE name = 'Xiaojun';
SELECT name FROM Highschooler WHERE grade = 10;
SELECT Name FROM Highschooler WHERE Grade = 10;
SELECT ID FROM Highschooler WHERE name = 'Xiaojun';
SELECT ID FROM Highschooler WHERE name = 'Xiaojun';
SELECT COUNT(*) FROM Highschooler WHERE grade IN (9, 10);
SELECT COUNT(*) FROM Highschooler WHERE grade IN (9, 10);
SELECT grade, COUNT(*) AS student_count FROM Highschooler GROUP BY grade;
SELECT grade, COUNT(*) AS count FROM Highschooler GROUP BY grade;
SELECT grade FROM Highschooler GROUP BY grade ORDER BY COUNT(*) DESC LIMIT 1;
SELECT grade FROM Highschooler GROUP BY grade HAVING COUNT(*) = (SELECT MAX(count) FROM (SELECT COUNT(*) AS count FROM Highschooler GROUP BY grade));
SELECT grade FROM Highschooler GROUP BY grade HAVING COUNT(ID) >= 4;
SELECT grade FROM Highschooler GROUP BY grade HAVING COUNT(*) >= 4;
SELECT student_id, COUNT(friend_id) AS friend_count FROM Friend GROUP BY student_id;
SELECT Highschooler.ID, COUNT(Friend.friend_id) AS FriendCount FROM Highschooler LEFT JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Highschooler.ID;
SELECT Highschooler.name, COUNT(Friend.friend_id) AS friend_count FROM Highschooler LEFT JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Highschooler.ID, Highschooler.name;
SELECT Highschooler.name, COUNT(Friend.friend_id) AS friend_count FROM Highschooler LEFT JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Highschooler.ID, Highschooler.name;
SELECT H.name FROM Highschooler H JOIN (SELECT student_id, COUNT(*) AS cnt FROM Friend GROUP BY student_id) AS FriendCount ON H.ID = FriendCount.student_id WHERE FriendCount.cnt = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM Friend GROUP BY student_id) AS MaxCount);
SELECT H.name FROM Highschooler H JOIN (SELECT student_id, COUNT(*) AS cnt FROM Friend GROUP BY student_id) FC ON H.ID = FC.student_id WHERE FC.cnt = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM Friend GROUP BY student_id) AS MaxCount);
SELECT H.name FROM Highschooler H WHERE H.ID IN (SELECT student_id FROM Friend GROUP BY student_id HAVING COUNT(*) >= 3);
SELECT H.name FROM Highschooler H JOIN Friend F ON H.ID = F.student_id GROUP BY H.ID HAVING COUNT(F.friend_id) >= 3;
SELECT H2.name FROM Highschooler H1 JOIN Friend F ON H1.ID = F.student_id JOIN Highschooler H2 ON F.friend_id = H2.ID WHERE H1.name = 'Xiaojun';
SELECT H2.name FROM Highschooler H1 JOIN Friend F ON H1.ID = F.student_id JOIN Highschooler H2 ON F.friend_id = H2.ID WHERE H1.name = 'Xiaojun';
SELECT COUNT(*) FROM Friend WHERE student_id = (SELECT ID FROM Highschooler WHERE name = 'Xiaojun');
SELECT COUNT(*) FROM Friend WHERE student_id = (SELECT ID FROM Highschooler WHERE name = 'Xiaojun');
SELECT ID FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend UNION SELECT friend_id FROM Friend);
SELECT ID FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend UNION SELECT friend_id FROM Friend);
SELECT H.name FROM Highschooler H WHERE H.ID NOT IN ( SELECT student_id FROM Friend UNION SELECT friend_id FROM Friend );
SELECT Name FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend);
SELECT DISTINCT student_id FROM Friend INTERSECT SELECT liked_id FROM Likes;
SELECT DISTINCT F.student_id FROM Friend F WHERE EXISTS ( SELECT 1 FROM Likes L WHERE L.liked_id = F.student_id );
SELECT H.name FROM Highschooler H WHERE EXISTS (SELECT 1 FROM Friend F WHERE F.student_id = H.ID) AND EXISTS (SELECT 1 FROM Likes L WHERE L.liked_id = H.ID);
SELECT H.name FROM Highschooler H WHERE EXISTS (SELECT 1 FROM Friend F WHERE F.student_id = H.ID) AND EXISTS (SELECT 1 FROM Likes L WHERE L.liked_id = H.ID);

SELECT Highschooler.ID, COUNT(Likes.liked_id) AS like_count FROM Highschooler LEFT JOIN Likes ON Highschooler.ID = Likes.liked_id GROUP BY Highschooler.ID;
SELECT Highschooler.Name, COUNT(Likes.Liked_ID) AS Like_Count FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.Student_ID GROUP BY Highschooler.ID, Highschooler.Name;
SELECT Highschooler.name, COUNT(Likes.liked_id) AS like_count FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.student_id GROUP BY Highschooler.ID;
SELECT H.name FROM Highschooler H JOIN (SELECT liked_id, COUNT(*) AS cnt FROM Likes GROUP BY liked_id) AS counts ON H.ID = counts.liked_id WHERE counts.cnt = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM Likes GROUP BY liked_id));
SELECT h.name FROM Highschooler h JOIN (SELECT liked_id, COUNT(*) AS cnt FROM Likes GROUP BY liked_id) AS counts ON h.ID = counts.liked_id WHERE counts.cnt = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM Likes GROUP BY liked_id) AS max_counts);
SELECT H.name FROM Highschooler H JOIN Likes L ON H.ID = L.student_id GROUP BY H.ID HAVING COUNT(*) >= 2;
SELECT H.name FROM Highschooler H WHERE H.ID IN ( SELECT L.student_id FROM Likes L GROUP BY L.student_id HAVING COUNT(*) >= 2 );
SELECT H.name FROM Highschooler H WHERE H.grade > 5 AND H.ID IN ( SELECT F.student_id FROM Friend F GROUP BY F.student_id HAVING COUNT(F.friend_id) >= 2 );
SELECT H.name FROM Highschooler H WHERE H.grade > 5 AND H.ID IN (SELECT F.student_id FROM Friend F GROUP BY F.student_id HAVING COUNT(*) >= 2);
SELECT COUNT(*) FROM Likes WHERE liked_id = (SELECT ID FROM Highschooler WHERE name = 'Xiaojun');
SELECT COUNT(*) FROM Likes WHERE student_id = (SELECT ID FROM Highschooler WHERE name = 'Xiaojun');
SELECT AVG(H.grade) FROM Highschooler H WHERE H.ID IN (SELECT F.student_id FROM Friend F);
SELECT AVG(grade) FROM Highschooler WHERE EXISTS (SELECT 1 FROM Friend WHERE student_id = Highschooler.ID);
SELECT MIN(grade) FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend UNION SELECT friend_id FROM Friend);
SELECT name FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend UNION SELECT friend_id FROM Friend) AND grade = (SELECT MIN(grade) FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend UNION SELECT friend_id FROM Friend));
SELECT State FROM Hosts INTERSECT SELECT State FROM Experts;
SELECT State FROM Owners INTERSECT SELECT State FROM Experts;
SELECT AVG(Age) FROM Animals WHERE Species = 'Dog' AND Treated = 1;
SELECT AVG(Age) FROM Dogs WHERE Treated = 1;
SELECT ExpertID, LastName, MobilePhone FROM Experts WHERE State = 'Indiana' OR ExpertID IN (SELECT ExpertID FROM ExpertTreatments GROUP BY ExpertID HAVING COUNT(*) > 2);
SELECT E.ExpertID, E.LastName, E.Phone FROM Experts E JOIN Treatments T ON E.ExpertID = T.ExpertID WHERE E.State = 'Indiana' GROUP BY E.ExpertID, E.LastName, E.Phone HAVING COUNT(T.TreatmentID) > 2;
SELECT D.DogName FROM Dogs D LEFT JOIN Treatments T ON D.DogID = T.DogID GROUP BY D.DogID HAVING COALESCE(SUM(T.Cost), 0) <= 1000;
SELECT Dogs.Name FROM Dogs JOIN Treatments ON Dogs.DogID = Treatments.DogID GROUP BY Dogs.DogID HAVING SUM(Treatments.Cost) > 1000;
SELECT Combined.Name FROM (SELECT Name FROM Expert UNION SELECT Name FROM Master) AS Combined WHERE Combined.Name NOT IN (SELECT Name FROM Dog);
SELECT Name FROM Professionals UNION SELECT Name FROM Owners EXCEPT SELECT DogName FROM Dogs;
SELECT Professionals.ProfessionalID, Professionals.Role, Professionals.Email FROM Professionals WHERE Professionals.ProfessionalID NOT IN ( SELECT DISTINCT Treatments.ProfessionalID FROM Treatments JOIN Pets ON Treatments.PetID = Pets.PetID JOIN Pet_Types ON Pets.PetTypeID = Pet_Types.PetTypeID WHERE Pet_Types.PetTypeName = 'Dog' );
SELECT E.ExpertID, E.Role, E.Email FROM Experts E WHERE NOT EXISTS ( SELECT 1 FROM Treatments T WHERE T.ExpertID = E.ExpertID AND T.AnimalType = 'Dog' );
SELECT o.OwnerID, o.FirstName, o.LastName FROM Owners o JOIN (SELECT OwnerID, COUNT(*) AS DogCount FROM Dogs GROUP BY OwnerID ORDER BY DogCount DESC LIMIT 1) AS top_owner ON o.OwnerID = top_owner.OwnerID;
SELECT OwnerID, FirstName, LastName FROM Owners WHERE OwnerID IN (SELECT OwnerID FROM Dogs GROUP BY OwnerID HAVING COUNT(*) = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM Dogs GROUP BY OwnerID) AS sub));
SELECT p.ProfessionalID, p.Role, p.Name FROM Professionals p JOIN Treatments t ON p.ProfessionalID = t.ProfessionalID GROUP BY p.ProfessionalID, p.Role, p.Name HAVING COUNT(t.TreatmentID) >= 2;
SELECT E.ExpertID, E.Role, E.Name FROM Experts E JOIN Treatments T ON E.ExpertID = T.ExpertID GROUP BY E.ExpertID, E.Role, E.Name HAVING COUNT(T.TreatmentID) >= 2;
SELECT Breed FROM Dogs GROUP BY Breed ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Breed FROM Dogs JOIN FeedingRecords ON Dogs.DogID = FeedingRecords.DogID GROUP BY Breed ORDER BY SUM(Amount) DESC LIMIT 1;
SELECT Owner.OwnerID, Owner.LastName FROM Owner JOIN Dog ON Owner.OwnerID = Dog.OwnerID JOIN Treatment ON Dog.DogID = Treatment.DogID GROUP BY Owner.OwnerID ORDER BY SUM(Treatment.Cost) DESC LIMIT 1;
SELECT O.OwnerID, O.LastName FROM Owners O JOIN Pets P ON O.OwnerID = P.OwnerID WHERE P.Species = 'Dog' GROUP BY O.OwnerID, O.LastName ORDER BY SUM(P.TreatmentCost) DESC LIMIT 1;
SELECT Description FROM Treatment GROUP BY Type ORDER BY SUM(Cost) ASC LIMIT 1;
SELECT TreatmentType FROM Treatments GROUP BY TreatmentType ORDER BY SUM(Cost) ASC LIMIT 1;
SELECT OwnerID, ZipCode FROM Owners WHERE OwnerID IN ( SELECT d.OwnerID FROM Dogs d JOIN Payments p ON d.DogID = p.DogID GROUP BY d.OwnerID ORDER BY SUM(p.Amount) DESC LIMIT 1 );
SELECT Owner.ID, Owner.ZipCode FROM Owner JOIN (SELECT OwnerID, SUM(Amount) AS Total FROM Expense GROUP BY OwnerID) AS Totals ON Owner.ID = Totals.OwnerID WHERE Totals.Total = (SELECT MAX(Total) FROM (SELECT SUM(Amount) AS Total FROM Expense GROUP BY OwnerID) AS SubQuery);
SELECT E.ExpertID, E.MobileNumber FROM Experts E JOIN ExpertTreatments ET ON E.ExpertID = ET.ExpertID GROUP BY E.ExpertID, E.MobileNumber HAVING COUNT(*) >= 2;
SELECT p.ProfessionalID, p.Phone FROM Professionals p JOIN Treatments t ON p.ProfessionalID = t.ProfessionalID GROUP BY p.ProfessionalID, p.Phone HAVING COUNT(DISTINCT t.TreatmentType) >= 2;
SELECT FirstName, LastName FROM Experts WHERE TreatmentCost < (SELECT AVG(TreatmentCost) FROM Experts);
SELECT FirstName, LastName FROM Experts WHERE TreatmentCost < (SELECT AVG(TreatmentCost) FROM Experts);
SELECT T.Date, P.Name FROM Treatment T JOIN Professional P ON T.ProfessionalID = P.ProfessionalID;
SELECT Treatment.Date, Professional.FirstName, Professional.LastName FROM Treatment INNER JOIN Professional ON Treatment.ProfessionalID = Professional.ProfessionalID;
SELECT T.Cost, TT.Description FROM Treatments T INNER JOIN TreatmentTypes TT ON T.TreatmentTypeID = TT.TreatmentTypeID;
SELECT Treatments.Cost, TreatmentTypes.Description FROM Treatments JOIN TreatmentTypes ON Treatments.TreatmentTypeID = TreatmentTypes.TreatmentTypeID;
SELECT o.FirstName, o.LastName, d.Size FROM Owners o JOIN OwnersDogs od ON o.OwnerID = od.OwnerID JOIN Dogs d ON od.DogID = d.DogID;
SELECT Owners.Name, Owners.Surname, Dogs.Size FROM Owners JOIN Dogs ON Owners.ID = Dogs.OwnerID;
SELECT Owners.Name, Dogs.Name FROM Owners JOIN Dogs ON Owners.OwnerID = Dogs.OwnerID;
SELECT Owners.Name, Dogs.Name FROM Owners JOIN Dogs ON Owners.OwnerID = Dogs.OwnerID;
SELECT D.Name, T.TreatmentDate FROM Dogs D JOIN Breeds B ON D.BreedID = B.BreedID JOIN Treatments T ON D.DogID = T.DogID WHERE B.Rarity = (SELECT MAX(Rarity) FROM Breeds);
SELECT D.Name, T.TreatmentDate FROM Dogs D JOIN Breeds B ON D.BreedID = B.BreedID LEFT JOIN Treatments T ON D.DogID = T.DogID WHERE B.PopularityRank = (SELECT MAX(PopularityRank) FROM Breeds);
SELECT Person.Name AS OwnerName, Dog.Name AS DogName FROM Person INNER JOIN PersonDog ON Person.PersonID = PersonDog.PersonID INNER JOIN Dog ON PersonDog.DogID = Dog.DogID WHERE Person.City = 'Shanxi';
SELECT Owner.Name, Dog.Name FROM Owner JOIN Dog ON Owner.OwnerID = Dog.OwnerID WHERE Owner.City = 'Shanxi';
SELECT AdmissionDate, DischargeDate FROM Hospitalizations WHERE DogID IN (SELECT DogID FROM Treatments);
SELECT DISTINCT H.AdmissionDate, H.DischargeDate FROM Hospitalizations H JOIN Treatments T ON H.HospitalizationID = T.HospitalizationID;
SELECT Owners.LastName FROM Owners INNER JOIN Dogs ON Owners.OwnerID = Dogs.OwnerID WHERE Dogs.Age = (SELECT MIN(Age) FROM Dogs);
SELECT O.LastName FROM Owners O JOIN Pets P ON O.OwnerID = P.OwnerID WHERE P.Species = 'Dog' AND P.Age = (SELECT MIN(Age) FROM Pets WHERE Species = 'Dog');
SELECT Email FROM Experts WHERE Country = 'Taiwan' OR (Country = 'China' AND Address LIKE '%Fujian%');
SELECT Email FROM Experts WHERE Province IN ('Taiwan', 'Fujian');
SELECT AdmissionDate, DischargeDate FROM HospitalRecords WHERE PetType = 'Dog';
SELECT Admission.AdmissionDate, Admission.DischargeDate FROM Animal JOIN Admission ON Animal.AnimalID = Admission.AnimalID WHERE Animal.Species = 'Dog';
SELECT COUNT(DISTINCT Animals.AnimalID) FROM Animals JOIN MedicalRecords ON Animals.AnimalID = MedicalRecords.AnimalID WHERE Animals.Species = 'Dog';
SELECT COUNT(*) FROM Animals WHERE Species = 'Dog' AND Treated = 1;
SELECT COUNT(DISTINCT ExpertID) FROM Treatments WHERE AnimalType = 'Dog';
SELECT COUNT(DISTINCT ProfessionalID) FROM TreatmentRecords WHERE PetTypeID IN (SELECT PetTypeID FROM PetType WHERE TypeName = 'Dog');
SELECT Role, Street, City, State FROM Experts WHERE City LIKE '%West%';
SELECT Role, Street, City, State FROM Experts WHERE City LIKE '%West%';
SELECT FirstName, LastName, Email FROM Owners WHERE State LIKE '%North%';
SELECT LastName, FirstName, Email FROM Owners WHERE State LIKE '%North%';
SELECT COUNT(*) FROM Dogs WHERE Age < (SELECT AVG(Age) FROM Dogs);
SELECT COUNT(*) FROM Dog WHERE Age < (SELECT AVG(Age) FROM Dog);
SELECT Cost FROM Treatment ORDER BY TreatmentDate DESC LIMIT 1;
SELECT Cost FROM Treatment ORDER BY TreatmentDate DESC LIMIT 1;
SELECT COUNT(*) FROM Dogs WHERE DogID NOT IN (SELECT DISTINCT DogID FROM Treatments);
SELECT COUNT(*) FROM Animals WHERE Species = 'Dog' AND TreatmentStatus = 'Treated';
SELECT COUNT(*) FROM Owners LEFT JOIN Dogs ON Owners.OwnerID = Dogs.OwnerID WHERE Dogs.OwnerID IS NULL;
SELECT O.OwnerID, O.Name FROM Owners O WHERE NOT EXISTS ( SELECT 1 FROM Ownerships Os WHERE Os.OwnerID = O.OwnerID AND Os.DateEnd IS NULL );
SELECT COUNT(*) FROM Experts WHERE ExpertID NOT IN (SELECT ExpertID FROM Treatments WHERE AnimalTypeID = (SELECT AnimalTypeID FROM AnimalTypes WHERE AnimalName = 'Dog'));
SELECT COUNT(*) FROM Experts WHERE ExpertID NOT IN (SELECT ExpertID FROM Treatments WHERE AnimalTypeID = (SELECT AnimalTypeID FROM AnimalTypes WHERE AnimalTypeName = 'Dog'));
SELECT Name, Age, Weight FROM Dogs WHERE Abandoned = 1;
SELECT Name, Age, Weight FROM Animals WHERE Species = 'Dog' AND IsAbandoned = 1;
SELECT AVG(Age) FROM Animals WHERE Species = 'Dog';
SELECT AVG(Age) FROM Pets WHERE Species = 'Dog';
SELECT MAX(Age) AS OldestAge FROM Dogs;
SELECT MAX(Age) AS OldestAge FROM Dogs;
SELECT FeeType, Amount FROM Fees;
SELECT Type, SUM(Amount) AS TotalAmount FROM Expenses GROUP BY Type;
SELECT MAX(Amount) FROM Charges;
SELECT MAX(Amount) AS MaxAmount FROM ChargeTypes;
SELECT Email, MobileNumber, HomePhone FROM Experts;
SELECT Email, MobileNumber, HomePhone FROM Experts;
SELECT DISTINCT Breed, Size FROM Pets;
SELECT DISTINCT Breed, Size FROM Dogs;
SELECT Experts.Name, Treatments.Description FROM Experts INNER JOIN Treatments ON Experts.ExpertID = Treatments.ExpertID;
SELECT Experts.Name, Treatments.Description FROM Experts INNER JOIN Treatments ON Experts.ExpertID = Treatments.ExpertID;
SELECT COUNT(*) FROM singer;
SELECT COUNT(*) FROM singer;
SELECT Name FROM singer ORDER BY Net_Worth_Millions ASC;
SELECT Name FROM singer ORDER BY Net_Worth_Millions ASC;
SELECT Birth_Year, Citizenship FROM singer;
SELECT Birth_Year, Citizenship FROM singer;
SELECT Name FROM singer WHERE Citizenship != 'Paris';
SELECT Name FROM singer WHERE Citizenship != 'France';
SELECT Name FROM singer WHERE Birth_Year IN (1948, 1949);
SELECT Name FROM singer WHERE Birth_Year = 1948 OR Birth_Year = 1949;
SELECT Name FROM singer WHERE Net_Worth_Millions = (SELECT MAX(Net_Worth_Millions) FROM singer);
SELECT Name FROM singer WHERE Net_Worth_Millions = (SELECT MAX(Net_Worth_Millions) FROM singer);
SELECT Citizenship, COUNT(*) AS Number_Of_Singers FROM singer GROUP BY Citizenship;
SELECT Citizenship, COUNT(*) AS Singer_Count FROM singer GROUP BY Citizenship;
SELECT Citizenship FROM singer GROUP BY Citizenship ORDER BY COUNT(*) DESC LIMIT 1;
SELECT Citizenship FROM singer GROUP BY Citizenship HAVING COUNT(*) = (SELECT MAX(cnt) FROM (SELECT COUNT(*) AS cnt FROM singer GROUP BY Citizenship) AS sub);
SELECT Citizenship, MAX(Net_Worth_Millions) AS Max_Net_Worth FROM singer GROUP BY Citizenship;
SELECT Citizenship, MAX(Net_Worth_Millions) AS Max_Net_Worth FROM singer GROUP BY Citizenship;
SELECT song.Title, singer.Name FROM song JOIN singer ON song.Singer_ID = singer.Singer_ID;
SELECT song.Title, singer.Name FROM song JOIN singer ON song.Singer_ID = singer.Singer_ID;
SELECT DISTINCT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID WHERE song.Sales > 300000;
SELECT DISTINCT s.Name FROM singer s JOIN song sg ON s.Singer_ID = sg.Singer_ID WHERE sg.Sales > 300000;
SELECT s.Name FROM singer s JOIN song sg ON s.Singer_ID = sg.Singer_ID GROUP BY s.Singer_ID HAVING COUNT(sg.Song_ID) > 1;
SELECT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Singer_ID HAVING COUNT(song.Song_ID) > 1;
SELECT singer.Name, SUM(song.Sales) AS Total_Sales FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Singer_ID;
SELECT singer.Name, SUM(song.Sales) AS Total_Sales FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Name;
SELECT Name FROM singer WHERE Singer_ID NOT IN (SELECT Singer_ID FROM song);
SELECT Name FROM singer LEFT JOIN song ON singer.Singer_ID = song.Singer_ID WHERE song.Singer_ID IS NULL;
SELECT Singer.Citizenship FROM (SELECT DISTINCT Citizenship FROM singer WHERE Birth_Year < 1945) AS Pre1945 INNER JOIN (SELECT DISTINCT Citizenship FROM singer WHERE Birth_Year > 1955) AS Post1955 ON Pre1945.Citizenship = Post1955.Citizenship;
SELECT Citizenship FROM singer WHERE Birth_Year < 1945 INTERSECT SELECT Citizenship FROM singer WHERE Birth_Year > 1955;
SELECT COUNT(*) AS TotalAvailableFeatures FROM Features WHERE Available = 1;
SELECT FeatureTypes.Name FROM Airlines JOIN AirlineFeatures ON Airlines.ID = AirlineFeatures.AirlineID JOIN FeatureTypes ON AirlineFeatures.FeatureTypeID = FeatureTypes.ID WHERE Airlines.Name = 'Spring Airlines';
SELECT TypeDescription FROM Attributes WHERE Code = 'CODE';
SELECT PropertyName FROM Properties WHERE (Type = 'House' OR Type = 'Apartment') AND Rooms > 1;