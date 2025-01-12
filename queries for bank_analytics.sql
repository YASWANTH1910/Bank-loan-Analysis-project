#create database bank_analytics;
use bank_analytics;

# 1)Year wise loan amount stats

select year(issue_d) as Year,
concat("$"," ",format(sum(loan_amnt)/1000000,2)," ","M") as Loan_Amount
from finance_1
group by year
order by year;

# 2)Grade and sub grade wise revol_bal

SELECT grade , sub_grade , 
CONCAT("$", " ", FORMAT(SUM(revol_bal)/1000000, 2), " ", "M") AS Total_Revol_Bal
FROM finance_1 a
JOIN finance_2 b
ON  a.id = b.id
GROUP BY grade, sub_grade
ORDER BY grade , sub_grade;

# 3)Total payment for verified status vs Total Payment for non verified status

SELECT verification_status ,
CONCAT("$", " ", FORMAT(SUM(total_pymnt)/1000000, 2), " ", "M") AS Total_pymnt_amt
FROM finance_1 a
JOIN finance_2 b
ON a.id = b.id
WHERE verification_status IN ("Verified", "Not Verified")
GROUP BY verification_status;

# 4)State wise and month wise loan status

SELECT addr_state AS State,
MONTHNAME(issue_d) AS Month,
loan_status AS Loan_Status,
COUNT(id) AS Count_of_status
FROM finance_1
GROUP BY 1, 2, 3
ORDER BY 4 DESC;

# 5)Home ownership vs last payment date stats

SELECT home_ownership ,
FORMAT(COUNT(last_pymnt_d), 0) AS lst_pymnt_d_status
FROM finance_1 a
JOIN finance_2 b ON b.id = a.id
where home_ownership not in ('other','none')
GROUP BY home_ownership;

---
select CONCAT("$", " ", FORMAT(SUM(loan_amnt)/1000000, 2), " ", "M") AS Total_loan_amt
from finance_1;

---
select CONCAT("$", " ", FORMAT(SUM(funded_amnt)/1000000, 2), " ", "M") AS Total_funded_amt
from finance_1;

---
select CONCAT("$", " ", FORMAT(SUM(revol_bal)/1000000, 2), " ", "M") AS Total_revol_bal
from finance_2;

---
select CONCAT("$", " ", FORMAT(SUM(total_pymnt)/1000000, 2), " ", "M") AS Total_pymnt
from finance_2;

---
select CONCAT("$", " ", FORMAT(SUM(annual_inc)/1000000, 2), " ", "M") AS Total_annual_inc
from finance_1;