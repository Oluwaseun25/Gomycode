-- 1) Create Wine Table
CREATE TABLE Wine (
    NumW INT PRIMARY KEY,
    Category VARCHAR(255),
    Year INT,
    Degree DECIMAL(4, 2)
);


-- Create Producer Table
CREATE TABLE Producer (
    NumP INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Region VARCHAR(50)
);

-- Create Harvest_Quantity Table
CREATE TABLE Harvest_Quantity (
    NumW INT,
    NumP INT,
    Quantity INT,
    Harvest DATE,
    PRIMARY KEY (NumW, NumP),
    FOREIGN KEY (NumW) REFERENCES Wine(NumW),
    FOREIGN KEY (NumP) REFERENCES Producer(NumP)
);

--------------------------------------------2)---------------------------
---------- Insert Records into Wine Table
INSERT INTO Wine (NumW, Category, Year, Degree) VALUES
    (1, 'Red', 2018, 14.5),
    (2, 'White', 2020, 12.0),
    (3, 'Rosé', 2019, 13.2),
    (4, 'Sparkling', 2017, 12.0),
    (5, 'Red', 2019, 13.9),
    (6, 'White', 2016, 12.0),
    (7, 'Red', 2021, 14.2),
    (8, 'Rosé', 2022, 13.5),
    (9, 'Sparkling', 2015, 11.5),
    (10, 'Red', 2017, 13.7),
    (11, 'White', 2019, 12.0),
    (12, 'Red', 2016, 14.0),
    (13, 'Rosé', 2020, 13.0),
    (14, 'Sparkling', 2018, 12.2),
    (15, 'Red', 2015, 14.8),
    (16, 'White', 2018, 12.3),
    (17, 'Red', 2023, 13.9),
    (18, 'Rosé', 2017, 13.3),
    (19, 'Sparkling', 2019, 11.0),
    (20, 'Red', 2014, 12.0);


	------ Insert Records into Producer Table
	INSERT INTO Producer (NumP, FirstName, LastName, Region) VALUES
    (21, 'John', 'Doe', 'Napa Valley'),
    (22, 'Maria', 'Rodriguez', 'Bordeaux'),
    (23, 'Robert', 'Smith', 'Tuscany'),
    (24, 'Emily', 'Johnson', 'Barossa Valley'),
    (25, 'Carlos', 'Fernandez', 'Rioja'),
    (26, 'Sophia', 'Lee', 'Sousse'),
    (27, 'Ahmed', 'Al-Farsi', 'Bekaa Valley'),
    (28, 'Olivia', 'Brown', 'Sonoma Coast'),
    (29, 'Hiroshi', 'Tanaka', 'Yarra Valley'),
    (30, 'Isabella', 'Rossi', 'Sousse'),
    (31, 'Andre', 'Dubois', 'Loire Valley'),
    (32, 'Elena', 'Gonzalez', 'Mendoza'),
    (33, 'Pierre', 'Lefevre', 'Sousse');



	-- Insert Records into Harvest_Quantity Table
INSERT INTO Harvest_Quantity (NumW, NumP, Quantity, Harvest) VALUES
    (1, 21, 500, '2023-05-10'),
    (2, 22, 300, '2023-06-15'),
    (3, 23, 450, '2023-04-20'),
    (4, 24, 600, '2023-03-12'),
    (5, 25, 350, '2023-07-05'),
    (6, 26, 420, '2023-08-20'),
    (7, 27, 550, '2023-09-05'),
    (8, 28, 380, '2023-10-12'),
    (9, 29, 300, '2023-11-18'),
    (10, 30, 480, '2023-12-02'),
    (11, 31, 400, '2023-02-08'),
    (12, 32, 250, '2023-01-15'),
    (13, 33, 700, '2023-02-28'),
    (14, 24, 320, '2023-03-20'),
    (15, 21, 450, '2023-04-10'),
    (16, 26, 370, '2023-05-25'),
    (17, 27, 520, '2023-06-30'),
    (18, 22, 300, '2023-07-15'),
    (19, 21, 480, '2023-08-05'),
    (20, 30, 420, '2023-09-18');


-----4) Give the list the producers.

select * from Producer
-------------------------------OR-----------------------------------------------
select Nump, CONCAT(FirstName,' ', LastName) as Producers_Name from Producer

-------5) Give the list of producers sorted by name. 

SELECT NumP, CONCAT(FirstName, ' ', LastName) AS Producers_Name FROM Producer
order by Producers_Name 

--------6) Give the list the producers of Sousse.

SELECT NumP, CONCAT(FirstName, ' ', LastName) AS Producers_Name FROM Producer
where Region = 'Sousse'

----------- 7) Calculate the total quantity of wine produced having the number 12.

select w.Degree, sum(Hq.Quantity) as Total_Wine_Quantity from Wine as W
join  Harvest_Quantity as Hq
on W.NumW = Hq.NumW
where Degree = 12
group by Degree


---------- 8) Calculate the quantity of wine produced by category.

select w.Category, sum(Hq.Quantity) as Total_Wine_Quantity from Wine as W
join  Harvest_Quantity as Hq
on W.NumW = Hq.NumW
group by Category
order by Total_Wine_Quantity desc

------------ 9) Which producers in the Sousse region have harvested at least one wine in quantities greater than 300 liters? We want the names and first names of the producers, sorted in alphabetical order.

select CONCAT(FirstName, ' ', LastName) as Names, Total_Wine_Quantity, Region  from
(select p.FirstName, p.LastName, p.Region, sum(Hq.Quantity) as Total_Wine_Quantity from Producer as p
join  Harvest_Quantity as Hq
on  p.NumP = Hq.NumP
where Region = 'Sousse'
group by FirstName, LastName, Region) as Tab1
where Total_Wine_Quantity > 300
order by Names



------- 10) List the wine numbers that have a degree greater than 12 and that have been produced by producer number 24.

select w.Degree, w.NumW, p.NumP from Wine as w
join
Harvest_Quantity as Hq
on w.NumW = Hq.NumW
join
Producer as p
on Hq.NumP = p.NumP
where Degree > 12 and p.NumP = 24









