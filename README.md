# Credit Risk Analysis and Loan Default Prediction Using SAS

## Overview

Credit risk assessment is a critical process in the financial industry, helping institutions determine the likelihood that a borrower will fail to repay a loan. Accurate credit risk evaluation enables lenders to reduce financial losses, improve lending decisions, and maintain a healthy loan portfolio.

This project uses SAS Studio to perform a comprehensive credit risk analysis on the German Credit Dataset. The analysis combines statistical inference, exploratory data analysis, and predictive modeling to identify factors associated with borrower risk and to develop a model capable of predicting potential loan defaults.

Unlike many introductory credit risk projects that focus solely on classification models, this project incorporates hypothesis testing, confidence interval estimation, multiple linear regression, and logistic regression to provide both statistical and business insights.

---
# Project Objectives

The objectives of this project are to:

* Explore borrower demographic and financial characteristics.
* Identify factors associated with higher credit risk.
* Clean and prepare data for analysis.
* Perform statistical hypothesis testing.
* Construct confidence intervals for key variables.
* Develop multiple regression models to understand financial relationships.
* Build a logistic regression model for default prediction.
* Evaluate model performance using classification metrics.
* Generate actionable business recommendations.

---
# Dataset

## German Credit Dataset

The German Credit Dataset contains information about individuals applying for credit and their associated credit risk classification.

The dataset includes variables related to:

* Borrower age
* Loan amount
* Loan duration
* Employment status
* Savings accounts
* Checking account status
* Housing situation
* Credit history
* Existing loans
* Installment commitments
* Personal characteristics

### Target Variable

The target variable represents borrower creditworthiness.

For modeling purposes:

| Value | Meaning                   |
| ----- | ------------------------- |
| 0     | Non-Default / Good Credit |
| 1     | Default / Bad Credit      |

---

# Tools and Technologies

## Software

* SAS Studio
* GitHub

## SAS Procedures

* PROC IMPORT
* PROC CONTENTS
* PROC PRINT
* PROC FREQ
* PROC MEANS
* PROC UNIVARIATE
* PROC TTEST
* PROC REG
* PROC LOGISTIC

---

# Repository Structure

```text
Credit-Risk-Analysis-and-Loan-Default-Prediction-Using-SAS/

│
├── data/
│   ├── raw/
│   │   └── german_credit_data.csv
│   │
│   └── processed/
│
├── sas_code/
│   ├── 01_import_data.sas
│   ├── 02_data_cleaning.sas
│   ├── 03_exploratory_data_analysis.sas
│   ├── 04_hypothesis_testing.sas
│   ├── 05_confidence_intervals.sas
│   ├── 06_multiple_regression.sas
│   ├── 07_logistic_regression.sas
│   └── 08_model_evaluation.sas
│
├── outputs/
│   ├── figures/
│   └── tables/
│
└── README.md
```

---

# Methodology

## 1. Data Collection and Import

The dataset is imported into SAS Studio and examined using descriptive procedures to understand variable types, formats, and overall structure.

Key activities:

* Dataset import
* Variable inspection
* Initial data quality assessment

---

## 2. Data Cleaning

The raw dataset is transformed into an analysis-ready dataset.

Tasks include:

* Identifying missing values
* Reviewing variable formats
* Creating analysis variables
* Preparing the target variable
* Creating borrower categories

---

## 3. Exploratory Data Analysis 

Exploratory analysis is performed to understand the characteristics of borrowers and loans.

Areas investigated include:

* Age distribution
* Loan amount distribution
* Loan duration distribution
* Credit risk distribution
* Frequency distributions of categorical variables

Deliverables:

* Summary statistics
* Frequency tables
* Histograms
* Distribution analysis

---

## 4. Hypothesis Testing

Statistical tests are conducted to determine whether observed differences between borrower groups are statistically significant.

### Research Questions

#### Age and Credit Risk

H₀: Mean borrower age is equal across risk groups.

H₁: Mean borrower age differs across risk groups.

Method:

* Independent Samples t-Test

---

#### Loan Amount and Credit Risk

H₀: Mean loan amount is equal across risk groups.

H₁: Mean loan amount differs across risk groups.

Method:

* Independent Samples t-Test

---

#### Credit History and Default Risk

H₀: Credit history and default risk are independent.

H₁: Credit history and default risk are associated.

Method:

* Chi-Square Test of Independence

---

## 5. Confidence Interval Estimation

Confidence intervals are constructed to estimate population parameters and quantify uncertainty.

* Mean borrower age
* Mean loan amount
* Mean loan duration

Outputs include:

* Point estimates
* Lower confidence limits
* Upper confidence limits

---

## 6. Multiple Linear Regression

Multiple regression is used to investigate factors that influence loan amounts.

### Model

Dependent Variable:

* Loan Amount

Independent Variables:

* Age
* Loan Duration
* Employment Duration
* Installment Rate

Objectives:

* Identifying significant predictors
* Measure variable effects
* Evaluate model fit

Key Outputs:

* Regression coefficients
* p-values
* Confidence intervals
* R²
* Adjusted R²

---

# Business Applications

The findings from this project can support:

* Credit approval processes
* Risk-based lending decisions
* Loan portfolio management
* Customer risk segmentation
* Financial risk assessment

By identifying high-risk borrower profiles, financial institutions can improve decision-making and reduce potential losses.

---

# Future Enhancements

Potential improvements include:

* Decision Tree Models
* Random Forest Models
* Gradient Boosting Models
* Feature Selection Techniques
* Cross-Validation
* Credit Scoring Systems
* Model Comparison Studies

---

# Key Skills Demonstrated

This project demonstrates proficiency in:

* SAS Programming
* Data Cleaning
* Exploratory Data Analysis
* Statistical Inference
* Hypothesis Testing
* Confidence Interval Estimation
* Multiple Linear Regression
* Business Analytics
* Data Visualization
* GitHub Project Documentation
