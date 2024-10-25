/* CHAPTER 3: QUERY PRIMER
Select: Determines which columns to include in the query’s result set
From: Identifies the tables from which to draw data and how the tables should be joined 
Where: Filters out unwanted data
Group by: Used to group rows together by common column values
Having: Filters out unwanted groups
Order by: Sorts the rows of the final result set by one or more columns

!! SELECT emp_id, 'ACTIVE', ROUND(amt * -1), UPPER(fname) FROM employee;
Column aliases AS
DISTINCT
TABLES: 
- permanent table (CREATE TABLE table_name)
- temporary table (rows returned by a subquery)
- virtual table (create using CREATE VIEW statement)
mysql> CREATE VIEW employee_vw AS
    -> SELECT emp_id, fname, lname, 
    -> YEAR(start_date) start_year 
    -> FROM employee;
mysql> SELECT emp_id, start_year 
    -> FROM employee_vw;
GROUP BY and HAVING
ORDER BY

ORDER OF EXECUTIONS:
FROM (including JOIN, APPLY, etc.)
WHERE
GROUP BY (can remove duplicates)
Aggregations
HAVING
Window functions
SELECT
DISTINCT (can remove duplicates)
UNION, INTERSECT, EXCEPT (can remove duplicates)
ORDER BY
OFFSET
LIMIT

*/
/*
Retrieve the employee ID, first name, and last name for all bank employees. Sort by last name and then by first name.
*/
USE bank;
SELECT emp_id, fname, lname
FROM employee
ORDER BY lname, fname;

/*
Retrieve the account ID, customer ID, and available balance for all accounts whose status equals 'ACTIVE' and whose available balance is greater than $2,500.
*/
SELECT account_id, cust_id, avail_balance
FROM account
WHERE status = 'ACTIVE' AND avail_balance > 2500;

/*Write a query against the account table that returns the IDs of the employees who opened the accounts (use the account.open_emp_id column). Include a single row for each distinct employee.
*/
SELECT DISTINCT open_emp_id
FROM account;
/*
Fill in the blanks (denoted by <#>) for this multi-data-set query to achieve the results shown here:
mysql> SELECT p.product_cd, a.cust_id, a.avail_balance
-> FROM product p INNER JOIN account <1>
-> ON p.product_cd = <2>
-> WHERE p.<3> = 'ACCOUNT'
-> ORDER BY <4>, <5>;
*/
SELECT p.product_cd, a.cust_id, a.avail_balance 
FROM product p 
INNER JOIN account a 
ON p.product_cd = a.product_cd 
WHERE p.product_type_cd = 'ACCOUNT' 
ORDER BY product_cd, cust_id;