# Loan Default Risk Analysis & Predictive Modeling

## Project Overview

This project focuses on analyzing loan performance and predicting loan defaults using a real-world lending dataset. It combines SQL-based data analysis, machine learning modeling in Python, and an interactive dashboard in Power BI to provide insights into customer behavior, risk segmentation, and default prediction.

## Objective

- Perform descriptive and exploratory data analysis using SQL to identify default trends and financial risk patterns.
- Engineer meaningful features for modeling and segment borrowers by risk levels.
- Build a classification model to accurately predict loan default risk.
- Design a Power BI dashboard for intuitive, interactive, and actionable insight delivery

## Data Overview

The dataset contains customer loan information including:

  - Demographics (State, Employment Length, Home Ownership)
  - Financials (Annual Income, Loan Amount, Interest Rate, DTI)
  - Loan Metadata (Purpose, Term, Grade, Loan Status, etc.)
  - Loan status has three categories:
       - Fully Paid
       - Charged Off (considered default)
       - Current (ongoing loan payment, excluded during supervised modeling)
    
## Tools & Technologies

- Data Analysis	SQL Server – Advanced SQL (CTEs, Window Functions, Aggregates)
- ML Modeling	Python – Pandas, NumPy, Scikit-learn, XGBoost, Matplotlib, Seaborn
- Dashboarding	Power BI – DAX, Custom Visuals, Slicers, Filters, Trend Visualizations
- Data Format	CSV file – 38,000+ loan records with 20+ features

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

| Metric             | Value                              |
| ------------------ | ---------------------------------- |
| Accuracy           | 98.0%                              |
| ROC-AUC Score      | 0.9842                             |
| F1-Score (Default) | 0.93                               |
| Confusion Matrix   | TP: 963, FN: 104, FP: 47, TN: 6382 |

The model demonstrated high discriminatory power with minimal false negatives, making it suitable for deployment in credit risk scenarios.

## Power BI Dashboard
Created a dynamic dashboard to:

  - Analyze loan disbursements and defaults over time
  - Visualize loan trends by state, purpose, term, and year
  - Segment customers by risk level and loan performance
  - Filter by grade, term, and employment length for detailed insights

## Project Structure

- data/ # Raw and processed datasets
- notebooks/ # Jupyter notebooks for EDA and modeling
- scripts/ # Python scripts for cleaning and prediction
- powerbi/ # Power BI dashboard file (.pbix)
- outputs/ # Plots, reports, and metrics
- README.md # Project documentation

## Key Outcomes

- Identified key drivers of default such as high DTI, low income, and longer term loans.
- Built a high-performing prediction model for loan default.
- Delivered an interactive, business-friendly dashboard to explore and monitor loan risk trends.

## Future Enhancements

- Incorporate real-time loan applications for scoring via REST APIs.
- Add macroeconomic variables (unemployment, inflation).
- Integrate customer credit bureau data for deeper profiling.
- Deploy model using Flask + Streamlit + SQL backend

