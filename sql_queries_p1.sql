
create database sales_project
use sales_project

create table reatil_sales (
transactions_id int primary key,	
sale_date date,
sale_time time,	customer_id int ,	gender varchar(15),	age int,category varchar(15),	quantiy int,	price_per_unit float,cogs float,total_sale float)

select * from reatil_sales 

-- data cleaning
select * from reatil_sales where sale_date is NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR  AGE IS NULL OR CATEGORY IS NULL OR
 quantiy IS NULL OR  price_per_unit IS NULL OR cogs  IS NULL OR  total_sale IS NULL

delete from reatil_sales where sale_date is NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL OR  AGE IS NULL OR CATEGORY IS NULL OR
 quantiy IS NULL OR  price_per_unit IS NULL OR cogs  IS NULL OR  total_sale IS NULL

-- data exploration

-- how many sales we have?
select count(*) from reatil_sales
-- how many unique customer we have 

-- Data analysis and Business Key Problems and Answer
-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from reatil_sales where sale_date='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from reatil_sales where category ='Clothing'  and  DATE_FORMAT(sale_date,'%Y-%m')='2022-11' and quantiy >= 4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as total_sale from reatil_sales group  by category order by 2 desc

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),2)  from reatil_sales where category='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from reatil_sales where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select gender,category,count(transactions_id) from reatil_sales group by gender, category order by 2

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
with cte as(
select year(sale_date) AS YEARs,month(sale_date) as months,round(avg(total_sale),2) AS AVGs ,rank() over(partition by  year(sale_date) 
order by round(avg(total_sale),2) desc) as rank_avg
from reatil_sales group by 1,2 )
select * from cte where rank_avg =1 

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,sum(total_sale) as higest from reatil_sales group by customer_id order by sum(total_sale) desc limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct customer_id) as unique_customers from reatil_sales group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with cte as(
select *,
     case
     when hour(sale_time) <=12 then 'Morning'
	 when hour(sale_time) between 12 and 17 then 'Afternoon'
	 when hour(sale_time) >17 then 'Evening'
     end as shift
     from reatil_sales)
select shift,count(*) as number from cte group by  shift














