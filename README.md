# Retail Sales Analysis SQL Project

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

 ```sql
create database sales_project;
use sales_project;

create table reatil_sales (
transactions_id int primary key,	
sale_date date,
sale_time time,	
customer_id int ,
gender varchar(15),	
age int,
category varchar(15),	
quantiy int,	
price_per_unit float,
cogs float,
total_sale float);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select count(*) from reatil_sales
SELECT COUNT(DISTINCT customer_id) FROM reatil_sales;
SELECT DISTINCT category FROM reatil_sales

select * from reatil_sales where sale_date is NULL OR sale_time IS NULL OR customer_id IS NULL
OR gender IS NULL OR  AGE IS NULL OR CATEGORY IS NULL OR
quantiy IS NULL OR  price_per_unit IS NULL OR cogs  IS NULL OR  total_sale IS NULL

delete from reatil_sales where sale_date is NULL OR sale_time IS NULL OR
customer_id IS NULL OR gender IS NULL OR  AGE IS NULL OR CATEGORY IS NULL OR
 quantiy IS NULL OR  price_per_unit IS NULL OR cogs  IS NULL OR  total_sale IS NULL

```

### 3. Data Analysis & Findings

 1 **Write a SQL query to retrieve all columns for sales made on '2022-11-05**
 ```sql
select * from reatil_sales where sale_date='2022-11-05'
```
2 **Write a SQL query to retrieve all transactions where the category is 'Clothing' 
and the quantity sold 
is more than 4 in the month of Nov-2022**
```sql
select * from reatil_sales where category ='Clothing'  and  DATE_FORMAT(sale_date,'%Y-%m')='2022-11' and quantiy >= 4
```
3 **Write a SQL query to calculate the total sales (total_sale) for each category.**
```sql
select category,sum(total_sale) as total_sale from reatil_sales group  by category order by 2 desc
```
4 **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```sql
select round(avg(age),2)  from reatil_sales where category='Beauty'
```
5 **Write a SQL query to find all transactions where the total_sale is greater than 1000.**
```sql
select * from reatil_sales where total_sale > 1000
```
6 **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**
```sql
select gender,category,count(transactions_id) from reatil_sales group by gender, category order by 2
```
7 **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**
```sql
with cte as(
select year(sale_date) AS YEARs,month(sale_date) as months,round(avg(total_sale),2) AS AVGs
,rank() over(partition by  year(sale_date) 
order by round(avg(total_sale),2) desc) as rank_avg
from reatil_sales group by 1,2 )
select * from cte where rank_avg =1
```
8 **Write a SQL query to find the top 5 customers based on the highest total sales**
```sql
select customer_id,sum(total_sale) as higest from reatil_sales group by customer_id
order by sum(total_sale) desc limit 5
```
9 **Write a SQL query to find the number of unique customers who purchased items from each category.**
```sql
select category,count(distinct customer_id) as unique_customers from reatil_sales group by category
```
10 **Write a SQL query to create each shift and number of orders (Example Morning <=12, 
Afternoon Between 12 & 17, Evening >17)**
```sql
with cte as(
select *,
     case
     when hour(sale_time) <=12 then 'Morning'
	 when hour(sale_time) between 12 and 17 then 'Afternoon'
	 when hour(sale_time) >17 then 'Evening'
     end as shift
     from reatil_sales)
select shift,count(*) as number from cte group by  shift
```

























