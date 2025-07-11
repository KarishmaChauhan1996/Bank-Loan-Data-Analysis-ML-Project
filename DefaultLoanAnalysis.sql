-----------------------------------------------Bank Loan Analysis-------------------------------------------------------------

SELECT * FROM financial_loan;

-- Total loan applications

SELECT COUNT(*) AS total_loan_applications FROM financial_loan ;

-- Total Funded amount

SELECT SUM(loan_amount) AS total_funded_amount FROM financial_loan ;

-- Total recieved amount

SELECT SUM(total_payment) AS total_recieved_amount FROM financial_loan;

-- Average interest rate

SELECT AVG(int_rate) AS avg_int_rate FROM financial_loan;

-- Average DTI

SELECT AVG(dti) AS avg_dti FROM financial_loan;

-- Status of loans

SELECT loan_status, COUNT(*) AS no_of_loans ,
SUM(loan_amount) AS funded_amount, 
SUM(total_payment) AS ampount_recieved
FROM financial_loan
GROUP BY loan_status;

-- Total funded amount by month

SELECT DATEPART(month, 'issue_date') AS month, 
SUM(loan_amount) AS funded_amount
FROM financial_loan
GROUP BY DATEPART(month, 'issue_date');

-- Total funded amount by state

SELECT address_state AS state, 
SUM(loan_amount) AS funded_amount
FROM financial_loan
GROUP BY address_state
ORDER BY funded_amount DESC ;

-- Total funded amount by term

SELECT term, 
SUM(loan_amount) AS funded_amount
FROM financial_loan
GROUP BY term
ORDER BY funded_amount DESC ;

-- Total funded amount by employment length

SELECT emp_length AS employment_length, 
SUM(loan_amount) AS funded_amount
FROM financial_loan
GROUP BY emp_length
ORDER BY funded_amount DESC ;


-- Total funded amount by purpose

SELECT purpose, 
SUM(loan_amount) AS funded_amount
FROM financial_loan
GROUP BY purpose
ORDER BY funded_amount DESC ;

-- Total funded amount by home ownership

SELECT home_ownership, 
SUM(loan_amount) AS funded_amount
FROM financial_loan
GROUP BY home_ownership
ORDER BY funded_amount DESC ;

-- Average interest rate by purpose

SELECT purpose,
	ROUND(AVG(int_rate),4) AS avg_int_rate
FROM financial_loan
GROUP BY purpose
ORDER BY avg_int_rate DESC; 

-- Top 10 employees by loan volume

SELECT Top 10 member_id,
       COUNT(*) AS total_loans,
       ROUND(AVG(loan_amount), 2) AS avg_loan_amt
FROM financial_loan
GROUP BY member_id
ORDER BY total_loans DESC
;

-- Loan default rate by grade

SELECT grade,
       COUNT(*) AS total_loans,
       SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaulted_loans,
       ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM financial_loan
GROUP BY grade
ORDER BY default_rate_pct DESC;

-- Loan default rate by term

SELECT term,
       COUNT(*) AS total_loans,
       SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaulted_loans,
       ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM financial_loan
GROUP BY term
ORDER BY default_rate_pct DESC;

--Loan Default rate by purpose

SELECT purpose,
       COUNT(*) AS total_loans,
       SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaulted_loans,
       ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM financial_loan
GROUP BY purpose
ORDER BY default_rate_pct DESC;

SELECT * FROM financial_loan

-- Loan default rate by verification status

SELECT verification_status,
       COUNT(*) AS total_loans,
       SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaulted_loans,
       ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM financial_loan
GROUP BY verification_status
ORDER BY default_rate_pct DESC;

-- Loan default rate by interet rate

SELECT interest_bins,  COUNT(*) AS total_loans,
       SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaulted_loans,
       ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM
(
SELECT *, 
	CASE WHEN int_rate<0.1 THEN '<0.1'
	WHEN int_rate BETWEEN 0.1 AND 0.2 THEN '0.1-0.2'
	WHEN int_rate >0.2 THEN '>0.2'
END AS interest_bins
FROM financial_loan
) a
GROUP BY interest_bins
ORDER BY default_rate_pct DESC;

-- Loan default rate by annual income

SELECT income_bins,  COUNT(*) AS total_loans,
       SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaulted_loans,
       ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM
(
SELECT *, 
	CASE WHEN annual_income<25000 THEN '<25k'
	WHEN annual_income BETWEEN 25000 AND 50000 THEN '25k-50k'
	WHEN annual_income BETWEEN 50000 AND 100000 THEN '50k-1Lakh'
	WHEN annual_income BETWEEN 100000 AND 500000 THEN '1Lakh-5Lakh'
	WHEN annual_income BETWEEN 500000 AND 1000000 THEN '5Lakh-10Lakh'
	WHEN annual_income >1000000 THEN '>10Lakh'
END AS income_bins
FROM financial_loan
) a
GROUP BY income_bins
ORDER BY default_rate_pct DESC;

-- Loan default rate by debt-to-income ratio

SELECT dti_bins,  COUNT(*) AS total_loans,
       SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaulted_loans,
       ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM
(
SELECT *, 
	CASE WHEN dti<0.1 THEN '<0.1'
	WHEN dti BETWEEN 0.1 AND 0.2 THEN '0.1-0.2'
	WHEN dti >0.2 THEN '>0.2'
END AS dti_bins
FROM financial_loan
) a
GROUP BY dti_bins
ORDER BY default_rate_pct DESC;


-- Loan default rate by issue month and term
SELECT 
  FORMAT(issue_date, 'yyyy-MM') AS issue_month,
  term,
  COUNT(*) AS total_loans,
  SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaults,
  ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END)/ COUNT(*), 2) AS default_rate_pct
FROM financial_loan
GROUP BY FORMAT(issue_date, 'yyyy-MM'), term
ORDER BY issue_month, term;

-- Customers with income but defaulted

SELECT Top 10 id, member_id, emp_title, annual_income, loan_amount, dti, int_rate
FROM financial_loan
WHERE annual_income > 500000 AND loan_status = 'Charged Off'
ORDER BY annual_income DESC
;

-- Top defaulted loans with maximum recovery rate 

SELECT Top 20
  id,
  loan_amount,
  total_payment,
  int_rate,
  ROUND(100.0 * total_payment / loan_amount, 2) AS recovery_pct,
  loan_status
FROM financial_loan
WHERE loan_status = 'Charged Off'
ORDER BY recovery_pct DESC
;

-- Top fully paid loans with maximum recovery rate 

SELECT Top 20
  id,
  loan_amount,
  total_payment,
  int_rate,
  ROUND(100.0 * total_payment / loan_amount, 2) AS recovery_pct,
  loan_status
FROM financial_loan
WHERE loan_status = 'Fully Paid'
ORDER BY recovery_pct DESC
;

-- Multi dimensional Risk profile summary

SELECT 
  grade,
  home_ownership,
  verification_status,
  COUNT(*) AS total_loans,
  SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaults,
  ROUND(100.0 * SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM financial_loan
GROUP BY grade, home_ownership, verification_status
ORDER BY default_rate_pct DESC;

-- Profile of defaulted customers(top 20) with minimum recovery rate

SELECT Top 20
  id,
  home_ownership,
  verification_status,
  emp_length,
  annual_income,
  dti,
  loan_amount,
  total_payment,
  int_rate,
  ROUND(100.0 * total_payment / loan_amount, 2) AS recovery_pct,
  loan_status
FROM financial_loan
WHERE loan_status = 'Charged Off'
ORDER BY recovery_pct ASC
;

-- Month-on-Month (MoM) change in loan defaults

WITH monthly_default_loan AS
 (
 SELECT 
	FORMAT (issue_date, 'yyyy-MM') AS issue_month,
	SUM(CASE WHEN loan_status = 'Charged off' THEN 1 ELSE 0 END) AS defaults
FROM financial_loan
GROUP BY FORMAT (issue_date, 'yyyy-MM')
)
SELECT 
	issue_month,
	defaults,
	LAG(defaults) OVER( ORDER BY issue_month) as prev_month_default,
	defaults- LAG(defaults) OVER( ORDER BY issue_month) AS mom_change,
	ROUND(100.0 * (defaults - LAG(defaults) OVER (ORDER BY issue_month)) / 
        NULLIF(LAG(defaults) OVER (ORDER BY issue_month), 0), 2) AS mom_change_pct
FROM monthly_default_loan;

-- Month-to-Date (MTD) Loan issuance

WITH daily_loans AS (
  SELECT 
    CAST(issue_date AS DATE) AS issue_day,
    COUNT(*) AS daily_loan_count,
    SUM(loan_amount) AS daily_loan_amount
  FROM financial_loan
  GROUP BY CAST(issue_date AS DATE)
)
SELECT 
  issue_day,
  SUM(daily_loan_count) OVER (
    PARTITION BY FORMAT(issue_day, 'yyyy-MM') 
    ORDER BY issue_day
  ) AS mtd_loan_count,
  SUM(daily_loan_amount) OVER (
    PARTITION BY FORMAT(issue_day, 'yyyy-MM') 
    ORDER BY issue_day
  ) AS mtd_loan_amount
FROM daily_loans
ORDER BY issue_day;

-- Rolling 3-month default count

WITH loan_months AS (
  SELECT 
    FORMAT(issue_date, 'yyyy-MM') AS issue_month,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN 1 ELSE 0 END) AS defaults
  FROM financial_loan
  GROUP BY FORMAT(issue_date, 'yyyy-MM')
)
SELECT 
  issue_month,
  defaults,
  SUM(defaults) OVER (
    ORDER BY issue_month 
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ) AS rolling_3m_defaults
FROM loan_months;

-- Rank Customers by Highest Loan Amount Within Each State

SELECT *
FROM
(
		SELECT 
			member_id,
			address_state,
			loan_amount,
			RANK() OVER(PARTITION BY address_state ORDER BY loan_amount DESC) AS rnk
		FROM financial_loan
	) AS a
WHERE rnk <=1


-- Loan-to-Income Ratio Ranking (Within Purpose)
-- (Classifies loans into 5 risk tiers per purpose based on loan-to-income ratio)

SELECT *,
       NTILE(5) OVER (PARTITION BY purpose ORDER BY dti) AS income_risk_quintile
FROM financial_loan;


