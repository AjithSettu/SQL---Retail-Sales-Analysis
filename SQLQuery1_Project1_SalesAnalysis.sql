
SELECT count(*) FROM [SQL - Retail Sales Analysis_utf ]


--Data Cleaning

--Dealing with NULL Values
select * from [SQL - Retail Sales Analysis_utf ]
where transactions_id is null

select * from [SQL - Retail Sales Analysis_utf ]
where sale_date is null

--Checking NULL values for all columns
select * from [SQL - Retail Sales Analysis_utf ]
where transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or
	gender is null
	or
	customer_id is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null

--Deleting NULL values
delete from [SQL - Retail Sales Analysis_utf ]
where transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or
	gender is null
	or
	customer_id is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null

--Data Exploration

--How many sales has happened
select count(transactions_id) from [SQL - Retail Sales Analysis_utf ]

--How many distinct customers We have
select count (distinct Customer_id) from [SQL - Retail Sales Analysis_utf ]

--How many distinct Categories We have
select count (distinct category) from [SQL - Retail Sales Analysis_utf ]

--Data Analysis & Business key Problems

--1)Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from [SQL - Retail Sales Analysis_utf ]
where
	sale_date = '2022-11-05'


--2)Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:


select * from [SQL - Retail Sales Analysis_utf ]
where category = 'clothing' and quantiy>=4 and sale_date between '2022-11-01' and '2022-11-30'


--3)Write a SQL query to calculate the total sales (total_sale) for each category:
select category,sum(total_sale) as [Sum of Total Sales] from [SQL - Retail Sales Analysis_utf ]
group by category

--4)Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
select category,AVG(customer_id) as [Average of Customers] from [SQL - Retail Sales Analysis_utf ]
where category = 'Beauty'
group by category

--5)Write a SQL query to find all transactions where the total_sale is greater than 1000:
select * from [SQL - Retail Sales Analysis_utf ] 
where total_sale>1000

--6)Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select count(distinct(transactions_id)) as [Number of Transactions],gender,category from [SQL - Retail Sales Analysis_utf ]
group by category, gender
order by 1

--7)Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select year(sale_date),
		month(sale_date),
		avg(Total_sale)
from(

select year(sale_date) as [Year],
		month(sale_date) as [Month],
		avg(Total_sale) as [Average Sales],
		rank() over(partition by year(Sale_date) order by avg(Total_sale)desc) as rank
from [SQL - Retail Sales Analysis_utf ]
group by 1,2
) as x
where rank =1


--8)**Write a SQL query to find the top 5 customers based on the highest total sales **:

select top 5 customer_id,sum(total_sale)[Sum of Total Sales] from [SQL - Retail Sales Analysis_utf ]
group by customer_id
order by 1 desc 


--9)Write a SQL query to find the number of unique customers who purchased items from each category.:

select count(distinct customer_id)[Unique Catgory],category from [SQL - Retail Sales Analysis_utf ]
group by category

--10)Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with Salesbyhour as
(
select *,
	case
		when DATEPART(HOUR,sale_time) <12  then 'Morning'
		when DATEPART(HOUR,sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as Shift
from [SQL - Retail Sales Analysis_utf ]
)
SELECT Shift,count(*) as Total_Orders 
from Salesbyhour
group by Shift
