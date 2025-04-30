create database sales
use sales
select * from Chocolate_Sales

-- total sales amount for each country.

select Country, sum(Amount) as total_sales
from Chocolate_Sales
group by Country
order by total_sales desc

-- Write an SQL query to find the top 3 months with the highest total
-- chocolate sales amount across all countries.

select top 3 datename(month,date) as Month,
sum(amount) as Total_sales
from [dbo].[Chocolate_Sales]
group by datename(month,date)
order by Total_sales desc

-- Write a query to find the average amount of sales per transaction
-- for each chocolate type. Display the columns: Chocolate_Type and
-- Avg_Sales, and sort the result by Avg_Sales in descending order

select Product, AVG(Amount) as avg_Sales
from Chocolate_Sales
group by product
order by avg_Sales desc

-- Write a query to find the total number of transactions and total
-- sales amount for each sales channel.Display the columns:
-- Sales_Channel, Total_Transactions, and Total_Sales

select Sales_person, count(Sales_person) as Total_Transections,
sum(Amount) as Total_Sales
from Chocolate_Sales
group by Sales_person

-- Write a query to find the product that generated the highest total
-- sales amount Display the columns: Product and Total_Sales

select top 1 product, SUM(Amount) as Highest_Sales
from Chocolate_Sales
group by product
order by Highest_Sales desc

-- Write a query to find the month with the lowest total sales.
-- Display the columns: Month and Total_Sales

select top 1 DATENAME(month,date) as Month,
SUM(AMount) as Lowest_Sales
from Chocolate_Sales
group by DATENAME(month,date)
order by Lowest_Sales asc

-- Write a query to get the total sales amount made by each
-- salesperson for each product. Display the columns: Sales_Person,
-- Product, and Total_Sales

select Sales_Person,Product, SUM(Amount) as Total_Sales
from Chocolate_Sales
group by Sales_Person,Product
order by Sales_Person,Product

-- Write a query to find the product with the highest average sales
-- amount. Display the columns: Product and Avg_Sales

Select product, AVG(Amount) as Avg_Sales
from Chocolate_Sales
group by product

-- Write a query to find the sales person who made the lowest total
-- sales. Display: Sales_Person and Total_Sales.

select top 1 sales_Person, SUM(Amount) as lowest_Sales
from Chocolate_Sales
group by sales_Person
order by lowest_Sales

-- Write a query to find the number of transactions and total sales
-- made in each month.Display: Month, Total_Transactions, and
-- Total_Sales.

select DATENAME(month,date) as Month,
count(date) as Total_Transections,
SUM(amount) as Total_sales
from Chocolate_Sales
group by DATENAME(month,date)
order by Total_sales desc

-- Write a query to find the top 2 products with the lowest average
-- sales.Display: Product, Avg_Sales

select top 2 product,avg(Amount) as Lowest_Sales
from Chocolate_Sales
group by product
order by Lowest_Sales

-- Write a query to find the month with the highest number of
-- transactions.Display: Month, Total_Transactions

select top 1 datename(Month,date) as Month,
count(date) as Total_Transection
from Chocolate_Sales
group by datename(Month,date)
order by Total_Transection desc

-- Write a query to calculate the percentage contribution of each
-- product to the total sales amount.Display: Product, Total_Sales,
-- Percentage_Contribution
select product,Sum(Amount) as Total_Sales,
round(sum(Amount)*100 / (select sum(Amount)from Chocolate_Sales),2) as Percentage_Contribution
from chocolate_Sales
group by Product
order by Total_Sales desc

-- Write a query to display the top 2 salespersons who generated the
-- highest total sales.Show: Sales_Person, Total_Sales

select top 2 sales_person, SUM(amount) as Total_Sales
from Chocolate_Sales
group by sales_person
order by Total_Sales desc

-- Write a query to find the product that had the highest average
-- sales per transaction.Show: Product, Avg_Sales.

select top 1 product, avg(amount) as Highest_Avg_Sales
from Chocolate_Sales
group by product
order by Highest_Avg_Sales desc

-- Write a query to find the month with the fewest total transactions.
-- Show: Month, Total_Transactions.

select top 1 datename(month,date) as month,
count(date) as Total_transections
from Chocolate_Sales
group by datename(month,date)
order by Total_transections

-- Write a query to find each sales person’s highest-selling product.
-- Show: Sales_Person, Product, and Total_Sales.

with Top_Selling_product as (
	select
		Sales_Person,product,
		Sum(Amount) as Total_Sales,
		ROW_NUMBER() over (partition by sales_person order by
		Sum(Amount) desc) as Rank
	from Chocolate_Sales
	group by Sales_Person,product
)

select Sales_Person,product,Total_Sales
from Top_Selling_product
where Rank = 1

-- Write a query to calculate the percentage contribution of each
-- sales person to the overall sales.Display columns: Sales_Person,
-- Total_Sales, Percentage_Contribution.

select sales_person, sum(Amount) as Total_Sales,
sum(Amount) *100 / (select sum(Amount) from Chocolate_Sales )
as Percentage_Contribution
from Chocolate_Sales
group by sales_person
order by Total_Sales desc

-- Write a query to find the product with the lowest average sales
-- amount.Display columns: Product, Avg_Sales.

select top 1 product, avg(amount) as avg_sales
from Chocolate_Sales
group by product
order by avg_sales

-- Write a query to display all products whose total sales are higher
-- than the average total sales of all products.

SELECT Product, SUM(Amount) AS Total_Sales
FROM Chocolate_Sales
GROUP BY Product
HAVING SUM(Amount) > (
    SELECT AVG(Total)
    FROM (
        SELECT SUM(Amount) AS Total
        FROM Chocolate_Sales
        GROUP BY Product
    ) AS ProductSales
)

-- Write a query to find all salespersons whose total sales are
-- greater than the average total sales of all salespersons.Display
-- columns: Sales_Person and Total_Sales.

SELECT sales_Person, SUM(amount) AS Total_Sales
FROM Chocolate_Sales
GROUP BY sales_Person
HAVING SUM(amount) > (
    SELECT AVG(sales_total)
    FROM (
        SELECT SUM(amount) AS sales_total
        FROM Chocolate_Sales
        GROUP BY Sales_Person
    ) AS sales_totals
)
