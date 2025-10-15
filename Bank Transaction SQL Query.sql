create database Bank;
use Bank;
create table Bank_Transactions(
    Transaction_ID varchar(50) primary key,
    Account_Number varchar(30),
    Transaction_Date datetime,
    Transaction_Amount decimal(10,2),
    Merchant_Name varchar(100),
    Transaction_Type varchar(20),
    Category varchar(50),
    City varchar(50),
    Country varchar(50),
    Payment_Method varchar(50),
    Customer_Age int,
    Customer_Gender varchar(10),
	Customer_Occupation varchar(100),
	Customer_Income decimal(12,2),
    Account_Balance decimal(12,2),
    Transaction_Status varchar(20),
    Fraud_Flag varchar(10),
    Discount_Applied boolean ,
    Loyalty_Points_Earned int,
    Transaction_Description text
);

select * from bank_transactions;

-- 1 Total Transaction Amount by Month
select
    date_format(Transaction_Date, '%Y-%m') as Month,
    sum(Transaction_Amount) as Total_Amount
from Bank_Transactions
group by Month
order by Month;

-- 2 Top 10 Merchants by Total Transaction Amount
select merchant_name, sum(transaction_amount) as total_spent
from bank_transactions
group by merchant_name
order by total_spent desc
limit 10;

-- 3 Transaction Count by Category
select category, count(*) as total_transactions
from bank_transactions
group by category
order by total_transactions desc;

-- 4 Average Spending by Gender
select customer_gender, avg(transaction_amount) as avg_spending
from bank_transactions
group by customer_gender;

-- 5 Fraud vs Non-Fraud Transactions
select fraud_flag, count(*) as count_transactions, 
       sum(transaction_amount) as total_amount
from bank_transactions
group by fraud_flag;

-- 6 Most Common Payment Methods
select payment_method, count(*) as usage_count
from bank_transactions
group by payment_method
order by usage_count desc;

-- 7 Average Income vs Average Balance by Occupation
select customer_occupation,
       avg(customer_income) as avg_income,
       avg(account_balance) as avg_balance
from bank_transactions
group by customer_occupation
order by avg_income desc;

-- 8 Discount Impact Analysis
select discount_applied,
       avg(transaction_amount) as avg_amount,
       avg(loyalty_points_earned) as avg_points
from bank_transactions
group by discount_applied;

-- 9 Transaction Status Summary
select transaction_status, count(*) as total, 
       sum(transaction_amount) as total_amount
from bank_transactions
group by transaction_status;

-- 10 Age Group Spending Pattern
select 
  case 
    when customer_age < 25 then 'under 25'
    when customer_age between 25 and 40 then '25-40'
    when customer_age between 41 and 60 then '41-60'
    else '60+'
  end as age_group,
  avg(transaction_amount) as avg_spending
from bank_transactions
group by age_group;

-- 11 City wise Average income
select City,
       avg(customer_income) as avg_income
from bank_transactions
group by City
order by avg_income desc;