-- We have the following relational model created. Now we are going to write SQL queries to retrieve data from these tables using DQL language:

----------------------INSTRUCTION----------------------------------------

-- 1) Implement the provided relation model using SQL ( DDL part )
-- 2) Insert data into your tables ( DML part )
-- 3) Write a SQL query to retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, 
    -- along with the total cost of the widgets and gadgets ordered by each customer. The cost of each item should be calculated by multiplying the quantity by the price of the product.
-- 4) Write a query to retrieve the names of the customers who have placed an order for at least one widget, along with the total cost of the widgets ordered by each customer.
-- 5) Write a query to retrieve the names of the customers who have placed an order for at least one gadget, along with the total cost of the gadgets ordered by each customer.
-- 6) Write a query to retrieve the names of the customers who have placed an order for at least one doohickey, along with the total cost of the doohickeys ordered by each customer.
-- 7) Write a query to retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.
-- 8) Write a query to retrieve the names of the products that have been ordered by at least one customer, along with the total quantity of each product ordered.
-- 9) Write a query to retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer.
-- 10) Write a query to retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered.
-- 11) Write a query to retrieve the names of the customers who have placed an order on every day of the week, along with the total number of orders placed by each customer.

---------------------- TABLE TO BE IMPLEMENTED ---------------------------
-- Customers(Customer_Id, Customer_Name, Customer_Tel)
-- Product(Product_Id, Product_Name, Category, Price)
-- Orderss(#Customer_Id, #Product_Id, OrderDate, Quantity, Total_Amount)


---------------- 1) Implement the provided relation model using SQL ( DDL part )

CREATE TABLE Customers(
Customer_Id INT PRIMARY KEY ,
Customer_Name VARCHAR(100),
Customer_Tel VARCHAR(50)
);
select * from Customers


CREATE TABLE Product(
Product_Id INT PRIMARY KEY ,
Product_Name VARCHAR(100),
Category VARCHAR(255),
Price DECIMAL(10, 2)
);
select * from Product


-- There is a composite primary key on the Orderss Table
CREATE TABLE Orderss(
Customer_Id INT NOT NULL foreign key references Customers(Customer_Id) ,
Product_Id INT NOT NULL foreign key references Product(Product_Id),
OrderDate DATE,
Quantity INT,
Total_Amount DECIMAL(10, 2),
Constraint PK_Order Primary Key (Customer_Id, Product_Id)
);
select * from Orderss

sp_help orderss



---------2) Insert data into your tables ( DML part )

-- CUSTOMERS
INSERT INTO Customers (Customer_Id, Customer_Name, Customer_Tel)
VALUES (1, 'Alice', '+2348109876543'),
		(2, 'Bob',  '+2348123456789'),
		(3, 'Charlie', '+2348034567890');

SELECT * FROM Customers


-- Product Table
INSERT INTO Product (Product_Id, Product_Name, Category, Price)
VALUES (1, 'Widget', 'Appliances', 10.00),
	(2, 'Gadget', 'Electronics', 20.00),
	(3, 'Doohickey', 'Devices', 15.00);

SELECT * FROM Product


-- Orderss Table
INSERT INTO Orderss(Customer_Id, Product_Id, OrderDate, Quantity, Total_Amount)
	VALUES (1, 1,  '2021-01-01', 10, 100.00),
			(1, 2, '2021-01-02', 5, 100.00),
			(2, 1, '2021-01-03', 3, 30.00),
			(2, 2, '2021-01-04', 7, 140.00),
			(3, 1, '2021-01-05', 2, 20.00),
			(3, 3, '2021-01-06', 3, 45.00);

select * from Orderss


-- 3) Write a SQL query to retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, along with the 
-- total cost of the widgets and gadgets ordered by each customer. The cost of each item should be calculated by multiplying
-- the quantity by the price of the product.
------------------------------------------------------SOLUTION--------------------------------------

select count(Product_Name) AS Total_Number_of_Product_Per_Customer, Customer_Name, sum(Total_Amount) as Total_Purchase_Cost
from
(SELECT c.Customer_Name, p.Product_Name, o.Quantity, o.Total_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id
where Quantity >=1 and Product_Name IN('Widget', 'Gadget')) AS Tab1
--where Total_Number_of_Product_Per_Customer > 1
GROUP BY Customer_Name
HAVING count(Product_Name)>1



-----4) Write a query to retrieve the names of the customers who have placed an order for at least one widget, along with the total cost of the widgets ordered by each customer.

SELECT c.Customer_Name, p.Product_Name, o.Quantity, P.Price, o.Total_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id
where Quantity >=1 and Product_Name = 'Widget'


------5) Write a query to retrieve the names of the customers who have placed an order for at least one gadget, along with the total cost of the gadgets ordered by each customers


SELECT c.Customer_Name, p.Product_Name, o.Quantity, P.Price, o.Total_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id
where Quantity >=1 and Product_Name = 'Gadget'


-------6) Write a query to retrieve the names of the customers who have placed an order for at least one doohickey, along with the total cost of the doohickeys ordered by each customer.

SELECT c.Customer_Name, p.Product_Name, o.Quantity, P.Price, o.Total_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id
where Quantity >=1 and Product_Name = 'Doohickey'


----------7) Write a query to retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.


SELECT c.Customer_Name, p.Product_Name, o.Quantity, P.Price, o.Total_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id
where Quantity >=1 and Product_Name IN ('Widget', 'Gadget')

-------------------------------------------------------OR THIS-------------------------------------------

select sum(Quantity) as Total_Quantity_Per_Customer, sum(Total_Amount) as Total_Amount_For_Product_Purchased, Product_Name
from
(SELECT c.Customer_Name, p.Product_Name, o.Quantity, P.Price, o.Total_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id
where Quantity >=1 and Product_Name IN ('Widget', 'Gadget')) as Tab2
group by Product_Name

-------8) Write a query to retrieve the names of the products that have been ordered by at least one customer, along with the total quantity of each product ordered.


select distinct Product_Name, sum(Quantity) as Total_Quantity_Purchased
from
(SELECT p.Product_Name, c.Customer_Name, o.Quantity, P.Price, o.Total_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id
where Quantity >=1) AS Tab3
group by Product_Name


---------9)  Write a query to retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer.

-----------------------------------BASED ON RETURN(RETURNING CLIENTS)---------------------------
select count(Customer_Id) as Total_Number_Of_Order_placed_based_on_Return, Customer_Name
from
(SELECT o.Customer_Id, p.Product_Name, c.Customer_Name, o.Quantity, P.Price, o.Total_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id) as Tab4
group by Customer_Name

-----------------------------------------------BASED ON ORDER QUANTITY--------------------------
select sum(Quantity) AS Total_Purchase_Quantity_Per_Customer, Customer_Name
from
(SELECT o.Customer_Id, p.Product_Name, c.Customer_Name, o.Quantity, P.Price, o.Total_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id) AS Tab5
group by Customer_Name
order by Total_Purchase_Quantity_Per_Customer desc



-------------------------10) Write a query to retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered.

SELECT p.Product_Name, sum(o.Quantity) as Total_Quantity, sum(o.Total_Amount) as Total_Quantity_Amount
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id
group by Product_Name
order by Total_Quantity desc


---------------------- 11) Write a query to retrieve the names of the customers who have placed an order on every day of the week, along with the total number of orders placed by each customer.


SELECT c.Customer_Name, p.Product_Name, o.OrderDate, o.Quantity, P.Price, o.Total_Amount, O.Day_Name
FROM
Customers as c
JOIN 
Orderss as o
ON c.Customer_Id = o.Customer_Id
Join 
Product as p
on o.Product_Id = p.Product_Id
order by Customer_Name, Quantity desc

------------------------- SQL QUERY FOR ADDING DAY_NAME COLUMN AND FOR EXTRACTING DAY NAME FROM THE ORDER DATE COLUMN.---------------

ALTER TABLE Orderss 
ADD Day_Name VARCHAR(20);

UPDATE Orderss
SET Day_Name = DATENAME(dw,OrderDate)

select * from Orderss
