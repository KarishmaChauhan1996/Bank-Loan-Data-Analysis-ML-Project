# Bank-Loan-Data-Analysis-ML-Project

## Project Overview
This project focuses on analyzing loan performance and predicting loan defaults using a real-world lending dataset. It combines SQL-based data analysis, machine learning modeling in Python, and an interactive dashboard in Power BI to provide insights into customer behavior, risk segmentation, and default prediction.

## Tools & Technologies
- SQL Server – For data exploration, aggregation, and advanced analytics using window functions.
- Python (Pandas, Scikit-learn, XGBoost, Matplotlib, Seaborn) – For preprocessing, feature engineering, model building, and evaluation.
- Power BI – For creating interactive dashboards and visual summaries of key metrics.

## Data Description
The dataset contains customer loan information including:

  - Demographics (State, Employment Length, Home Ownership)
  - Financials (Annual Income, Loan Amount, Interest Rate, DTI)
  - Loan Metadata (Purpose, Term, Grade, Loan Status, etc.)
  - Loan status has three categories:
       - Fully Paid
       - Charged Off (considered default)
       - Current (excluded during supervised modeling)

## SQL Data Analysis

- Performed comprehensive exploratory data analysis using SQL:
     - MTD & MoM Trends: Tracked loan issuances and amounts using SUM(...) OVER (...), LAG, NTILE, and FORMAT functions.
- Default Rate Analysis:
     - By loan purpose, term, and grade
     - Using conditional aggregation and window functions
- Risk Segmentation:
     - Created income-to-loan and DTI-based quintiles using NTILE(5)
- Evaluated default likelihood within each segment

## Machine Learning Model (Python)

- Built a supervised classification model to predict whether a loan would default:
- Steps:
   - Data Cleaning & Feature Engineering:Encoded categorical variables, handled missing values, and created features like issue_month, emp_length_num
   - Used scale_pos_weight to address class imbalance (~13% defaults)
- Modeling:
- Model used: XGBoostClassifier

#### Result

- Achieved ROC-AUC Score of 0.98, indicating strong performance

#### Evaluation:

- Accuracy: 98%
- F1-score for default class: 0.93
- Confusion Matrix showed low false negatives

## Power BI Dashboard
Created a dynamic dashboard to:

  - Visualize loan trends by state, purpose, term, and year
  - Analyze default rates over time
  - Segment customers by risk level and loan performance
  - Filter by grade, term, and employment length for detailed insights

## Key Outcomes

- Identified key drivers of default such as high DTI, low income, and longer term loans.
- Built a high-performing prediction model for loan default.
- Delivered an interactive, business-friendly dashboard to explore and monitor loan risk trends.

