SELECT firstname, lastname, title
FROM employee
LIMIT 5; 

SELECT model, EngineType
FROM model
LIMIT 5; 

#joins
#CreateAList of employees and their immediate managers
SELECT emp.firstName,
  emp.lastName,
  emp.title,
  mng.firstName AS ManagerFirstName, 
  mng.lastName AS ManagerLastName
FROM employee emp
INNER JOIN employee mng 
  ON emp.managerId = mng.employeeId;

#CreateAList of sales peoplewith 0 sales
SELECT emp.firstName,
emp.lastName,
emp.title, 
emp.startDate, 
sls.salesId
FROM employee emp
LEFT JOIN sales sls 
  ON emp.employeeId = sls.employeeId
WHERE emp.title = 'Sales Person'
AND sls.salesId IS NULL;

#CreateaList of customers and their sales, even if some data is gone 
SELECT cus.firstName,
cus.lastName,
cus.email,
sls.salesAmount,
sls.soldDate
FROM customer cus
INNER JOIN sales sls 
  ON cus.customerId = sls.customerId
UNION
--union with customers who have no sales 
SELECT cus.firstName,
cus.lastName,
cus.email,
sls.salesAmount,
sls.soldDate
FROM customer cus 
LEFT JOIN sales sls 
  ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL 
UNION 
-- union with sales missing customer data 
SELECT cus.firstName,
cus.lastName,
cus.email,
sls.salesAmount,
sls.soldDate
FROM sales sls 
LEFT JOIN customer cus 
  ON cus.customerId = sls.customerId
WHERE sls.salesId IS NULL;

#GROUPING
#How many cars have been sold per employee?
SELECT  emp.employeeId,
emp.firstName,
emp.lastName,
count(*) as NumOfCarsSold
FROM sales sls 
INNER JOIN employee emp 
  ON sls.employeeId = emp.employeeId
GROUP BY  emp.employeeId, emp.firstName, emp.lastName
ORDER BY NumOfCarsSold DESC;

#ADVANCED SELEC OPTIONS
#display the number of sales for each employee by month in 2021
