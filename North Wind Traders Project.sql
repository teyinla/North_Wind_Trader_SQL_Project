/*Question 1
The UK sales team are visiting the Seattle office. 
Write a SQL statement to display the lastname, firstname, title, country 
and city of the employees you would now expect to be in Seattle */

SELECT  lastname, firstname, title, country, city 
FROM employees
WHERE city = 'Seattle';


/*Question 2
List the details of all the shippers been used by the company.*/

SELECT * 
FROM shippers


/* Question 3
List the names and prices of the ten cheapest products.*/

WITH t AS (
	SELECT productname, unitprice AS price 
	FROM products
	ORDER BY price ASC
	LIMIT 10
)
SELECT * 
FROM t
ORDER BY price DESC


/* Question 4
List out the countries of Northwind Trader’s suppliers are based.*/

SELECT DISTINCT(country) 
FROM suppliers;


/* Question 5
Get the total value of those units, for each supplier*/

SELECT p.supplierid, s.companyname,round(SUM(p.unitprice*p.unitsinstock)::numeric,2) AS "Total Value" 
FROM products p
JOIN suppliers s
ON p.supplierid = s.supplierid
GROUP BY p.supplierid,s.companyname
ORDER BY p.supplierid;


/* Question 6
Write a SQL query to display the product name and unit price of the top
3 most expensive products.*/

WITH k AS (
	SELECT productname, unitprice AS price 
	FROM products
	ORDER BY price DESC
	LIMIT(3)
	)
SELECT * 
FROM k
ORDER BY price ASC


/*Question 7
Write a query that displays the full name (i.e. include the title of courtesy,
last name and first name), title and hire date of the employee(s) 
in the employees table with the job title Sales */

SELECT concat(titleofcourtesy,' ',firstname, ' ', lastname) AS "full name", title, hiredate 
FROM employees
WHERE title = 'Sales Representative';


/*Question 8
The company wants to determine the top 5 ordered products from start of business. 
Write a SQL statement to display the product name and the product quantity 
(Use productquantity as the column alias).*/

SELECT productname, unitsonorder AS Productquantity 
FROM products
ORDER BY Productquantity DESC
LIMIT(5)


/*Question 9
The company wants to determine the bottom 5 ordered products from start of business. 
Write a SQL statement to display the product name and the product quantity 
(Use productquantity as the column alias).*/

SELECT productname, unitsonorder AS Productquantity 
FROM products
ORDER BY Productquantity ASC
LIMIT(5);


/*Question 10
How many employees where hired between August 14 1992 and August 4 1993? */

SELECT COUNT(employeeid) AS "No_of_Employees" 
FROM employees
WHERE hiredate BETWEEN '1992-08-14' AND '1993-08-04';


/*Question 11
Write a query to display the productid and productname for each product from the 
products table with name containing spread.*/

SELECT productid, productname 
FROM products
WHERE productname ILIKE ('%spread%')


/*Question 12
What is the total revenue generated based on product ordered
between 14/02/1997 and 25/12/1997? */

SELECT round(SUM((1-discount)*(unitprice*quantity))::numeric,2) AS "Total Revenue" 
FROM order_details
WHERE orderid IN (SELECT orderid 
				  FROM orders 
				  WHERE orderdate BETWEEN '1997-02-14' AND '1997-12-25')

--Alternatively
SELECT round(SUM((1-d.discount)*(d.unitprice*d.quantity))::numeric,2) AS "Total Revenue" 
FROM order_details d
JOIN orders o 
ON d.orderid = o.orderid
WHERE o.orderdate BETWEEN '1997-02-14' AND '1997-12-25'


/*Question 13
How many of the products sold are Beverages? */

SELECT c.categoryname, COUNT(o.orderid) AS "Total_Number_Sold" 
FROM categories c
JOIN products p
ON c.categoryid = p.categoryid
JOIN order_details o
ON o.productid = p.productid
WHERE c.categoryname = 'Beverages'
GROUP BY c.categoryname

/*Question 14 //The question may be a continuation of 13 (order_details table)
What is the count of products that are Confections? */

SELECT c.categoryname, COUNT(o.orderid) AS "Total_Number_Sold" 
FROM categories c
JOIN products p
ON c.categoryid = p.categoryid
JOIN order_details o
ON o.productid = p.productid
WHERE c.categoryname = 'Confections'
GROUP BY c.categoryname

--Question 14 //Maybe the question is talking about the product table

SELECT c.categoryname, COUNT(p.productid) AS "Total_Number" 
FROM products p
JOIN categories c
ON p.categoryid = c.categoryid
WHERE c.categoryname = 'Confections'
GROUP BY c.categoryname