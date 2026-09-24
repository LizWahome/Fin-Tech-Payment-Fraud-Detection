## Dataset  This project uses the [Dataset Name](https://www.kaggle.com/datasets/ealaxi/paysim1) from Kaggle. Download it and place it in the data/ folder before running the SQL scripts. 

# Fraud Detection Analysis | SQL + Power BI

## Overview

This project analyzes a synthetic financial transaction dataset to investigate fraudulent transaction patterns and evaluate the performance of an existing fraud-flagging mechanism.

The analysis was carried out using MySQL for data validation and exploratory analysis, followed by Power BI for interactive visualization and dashboard development.

The project focuses on three areas:

1. Overall fraud patterns
2. Transaction and balance behavior associated with fraud
3. Performance of the existing fraud-flagging mechanism

---

## Tools

- MySQL
- Power BI
- DAX
- SQL

---

## Dataset

The dataset contains 6,362,620 financial transactions across five transaction types:

- CASH_IN
- CASH_OUT
- DEBIT
- PAYMENT
- TRANSFER

Key fields include:

- Transaction type
- Transaction amount
- Originating account
- Destination account
- Origin account balances
- Destination account balances
- Fraud indicator
- System fraud flag
- Step/time-like identifier

The dataset is synthetic and does not represent real financial transactions.

---

## Data Validation & Cleaning

The data was examined before dashboard development.

Validation included:

- NULL-value checks
- Transaction-type consistency checks
- Negative amount and balance checks
- Origin balance consistency checks
- Destination balance consistency checks
- Investigation of duplicate records

### Validation findings

- No NULL values were identified.
- Five expected transaction types were present.
- No negative transaction amounts or balances were identified.
- Balance consistency checks revealed substantial mismatches in the dataset. These were retained rather than automatically treated as errors because they may represent characteristics of the synthetic dataset.
- Exact duplicate verification could not be completed because repeated large duplicate-check queries caused MySQL connection/resource failures.

---

## Key Findings

### Overall fraud

- Total transactions: **6,362,620**
- Fraudulent transactions: **8,213**
- Fraud rate: **0.1291%**

### Fraud by transaction type

Fraud was concentrated in:

- TRANSFER
- CASH_OUT

TRANSFER had the higher fraud rate, while CASH_OUT had a slightly higher number of fraudulent transactions because of its larger transaction volume.

### Transaction value

Fraudulent transactions had a substantially higher average transaction amount than non-fraudulent transactions.

- Average fraudulent transaction amount: approximately **1.47M**
- Average non-fraudulent transaction amount: approximately **178K**

The analysis treats these as transaction values rather than confirmed financial losses.

### Fraud flagging performance

The dataset contains two separate indicators:

- `isFraud` — fraud label
- `isFlaggedFraud` — system flag

The system flagged **16 transactions**.

All 16 flagged transactions were labelled as fraudulent:

- Flagged transactions: **16**
- Flagged fraudulent transactions: **16**
- Detection precision: **100%**
- Detection recall: approximately **0.19%**

This means the flagged transactions had perfect precision within this dataset, but the flag captured only a very small proportion of the fraudulent transactions.

---

## Power BI Dashboard

The dashboard contains three pages.

### 1. Fraud Overview

Provides an executive summary of:

- Transaction volume
- Fraud volume
- Fraud rate
- Transaction value
- Fraudulent transaction value
- Fraud rate by transaction type
- Fraud trends across the dataset's step dimension

### 2. Fraud Patterns & Transaction Behavior

Explores:

- Fraud versus non-fraud transaction amounts
- Fraud by transaction type
- Origin balance consistency
- Destination balance consistency
- Fraud behavior across different transaction characteristics

### 3. Fraud Detection Performance

Evaluates:

- Flagged transactions
- Flagged fraudulent transactions
- Detection precision
- Detection recall
- Fraud versus flagged transaction outcomes

---

## Important Limitations

This analysis uses a synthetic dataset.

The dataset does not contain a calendar timestamp, so `step` is used as a time-like analytical dimension rather than a true date.

The `isFraud` field is treated as the dataset's fraud label, while `isFlaggedFraud` represents the system flag.

Detection metrics should therefore be interpreted within the context of this dataset and should not be treated as evidence of real-world fraud-detection performance.

---

## Project Workflow

```text
Raw Dataset
     ↓
MySQL Data Validation
     ↓
SQL Exploratory Analysis
     ↓
Business Questions
     ↓
Power BI Data Model
     ↓
DAX Measures
     ↓
Interactive Dashboard
     ↓
Insights & Interpretation
