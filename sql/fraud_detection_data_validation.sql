SELECT
    COUNT(*)
FROM
    fraud_detection.ps_20174392719_1491204439457_log;

DESCRIBE fraud_detection.ps_20174392719_1491204439457_log;

TRUNCATE TABLE fraud_detection.ps_20174392719_1491204439457_log;

SHOW VARIABLES LIKE 'local_infile';

SET
    GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/ADMIN/Downloads/archive/PS_20174392719_1491204439457_log.csv' INTO TABLE fraud_detection.ps_20174392719_1491204439457_log FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

SELECT
    COUNT(*)
FROM
    fraud_detection.ps_20174392719_1491204439457_log;

SELECT
    *
FROM
    fraud_detection.ps_20174392719_1491204439457_log;

SELECT *, 
ROW_NUMBER() 
OVER(PARTITION BY 
step, `type`, amount, nameOrig, oldbalanceOrg, newbalanceOrig, nameDest, oldbalanceDest, newbalanceDest, isFraud, isFlaggedFraud)
FROM fraud_detection.ps_20174392719_1491204439457_log;

WITH row_num_cte AS
(
SELECT *,
ROW_NUMBER() 
OVER(PARTITION BY 
step, `type`, amount, nameOrig, oldbalanceOrg, newbalanceOrig, nameDest, oldbalanceDest, newbalanceDest, isFraud, isFlaggedFraud) AS row_num
FROM fraud_detection.ps_20174392719_1491204439457_log
)
SELECT *
FROM row_num_cte 
WHERE row_num > 1;

SELECT DISTINCT *
FROM fraud_detection.ps_20174392719_1491204439457_log;

SELECT COUNT(*) AS unique_rows
FROM (
SELECT DISTINCT
   step,
   `type`,
   amount,
   nameOrig,
   oldbalanceOrg,
   newbalanceOrig,
   nameDest,
   oldbalanceDest,
   newbalanceDest,
   isFraud,
   isFlaggedFraud
   FROM fraud_detection.ps_20174392719_1491204439457_log
   ) AS unique_data;
   
SELECT
    SUM(step IS NULL) AS null_step,
    SUM(`type` IS NULL) AS null_type,
    SUM(amount IS NULL) AS null_amount,
    SUM(nameOrig IS NULL) AS null_nameOrig,
    SUM(oldbalanceOrg IS NULL) AS null_oldbalanceOrg,
    SUM(newbalanceOrig IS NULL) AS null_newbalanceOrig,
    SUM(nameDest IS NULL) AS null_nameDest,
    SUM(oldbalanceDest IS NULL) AS null_oldbalanceDest,
    SUM(newbalanceDest IS NULL) AS null_newbalanceDest,
    SUM(isFraud IS NULL) AS null_isFraud,
    SUM(isFlaggedFraud IS NULL) AS null_isFlaggedFraud
FROM fraud_detection.ps_20174392719_1491204439457_log;

SELECT SUM(isFlaggedFraud IS NULL) AS null_isFlaggedFraud
FROM fraud_detection.ps_20174392719_1491204439457_log;

SELECT
    `type`,
    COUNT(*) AS transaction_count
FROM fraud_detection.ps_20174392719_1491204439457_log
GROUP BY `type`
ORDER BY transaction_count DESC;

SELECT *
FROM fraud_detection.ps_20174392719_1491204439457_log
ORDER BY 1;

SELECT
CASE WHEN
    ROUND(oldbalanceOrg - amount, 2) = ROUND(newbalanceOrig, 2)
THEN 'MATCH'
ELSE 'MISMATCH'
END AS comparison,
COUNT(*)
FROM fraud_detection.ps_20174392719_1491204439457_log
GROUP BY CASE WHEN
    ROUND(oldbalanceOrg - amount, 2) = ROUND(newbalanceOrig, 2)
THEN 'MATCH'
ELSE 'MISMATCH'
END;

SELECT 
CASE WHEN
    ROUND(oldbalanceDest + amount, 2) = ROUND(newbalanceDest, 2)
THEN 'MATCH'
ELSE 'MISMATCH'
END AS comparison,
COUNT(*)
FROM fraud_detection.ps_20174392719_1491204439457_log
GROUP BY CASE WHEN
    ROUND(oldbalanceDest + amount, 2) = ROUND(newbalanceDest, 2)
THEN 'MATCH'
ELSE 'MISMATCH'
END;

SELECT
    SUM(amount) AS total_transactions,
    SUM(
        CASE
            WHEN isFraud = 1 THEN amount
            ELSE 0
        END
    ) AS fraud_transactions,
    SUM(isFraud) AS no_of_frauds
FROM
    fraud_detection.ps_20174392719_1491204439457_log;

SELECT
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS no_of_frauds,
    (SUM(isFraud) / COUNT(*)) * 100 AS fraud_rate
FROM
    fraud_detection.ps_20174392719_1491204439457_log;

SELECT
    `type`,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS no_of_frauds,
    ((SUM(isFraud) / COUNT(*)) * 100) AS fraud_rate
FROM
    fraud_detection.ps_20174392719_1491204439457_log
GROUP BY
    `type`;

SELECT
    `type`,
    SUM(amount) AS total_amount,
    SUM(
        CASE
            WHEN isFraud = 1 THEN amount
            ELSE 0
        END
    ) AS fraud_amount,
    (
        SUM(
            CASE
                WHEN isFraud = 1 THEN amount
                ELSE 0
            END
        ) / SUM(amount)
    ) * 100 AS percentage_fraud
FROM
    fraud_detection.ps_20174392719_1491204439457_log
GROUP BY
    `type`;

SELECT
    `type`,
    AVG(amount) AS avg_amt,
    AVG(
        CASE
            WHEN isFraud = 1 THEN amount
        END
    ) AS avg_fraud
FROM
    fraud_detection.ps_20174392719_1491204439457_log
GROUP BY
    `type`;

SELECT
    step,
    COUNT(*)
FROM
    fraud_detection.ps_20174392719_1491204439457_log
GROUP BY
    step
ORDER BY
    2 DESC;

SELECT
    step,
    SUM(amount) AS total_transactions,
    SUM(
        CASE
            WHEN isFraud = 1 THEN amount
            ELSE 0
        END
    ) AS fraud_transactions,
    (
        SUM(
            CASE
                WHEN isFraud = 1 THEN amount
                ELSE 0
            END
        ) / SUM(amount)
    ) * 100 AS fraud_rate
FROM
    fraud_detection.ps_20174392719_1491204439457_log
GROUP BY
    step
ORDER BY
    4 DESC;

SELECT
    step,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_transations,
    (SUM(isFraud) / COUNT(*)) * 100 AS fraud_rate
FROM
    fraud_detection.ps_20174392719_1491204439457_log
GROUP BY
    step
ORDER BY
    3 DESC;

SELECT
    `type`,
    AVG(
        CASE
            WHEN isFraud THEN amount
        END
    ) AS fraud_transaction_amt
FROM
    fraud_detection.ps_20174392719_1491204439457_log
GROUP BY
    `type`;

SELECT
    *
FROM
    fraud_detection.ps_20174392719_1491204439457_log;

SELECT
    nameOrig,
    COUNT(*)
FROM
    fraud_detection.ps_20174392719_1491204439457_log
WHERE
    isFraud = 1
GROUP BY
    nameOrig
HAVING
    COUNT(*) > 1
ORDER BY
    2 DESC;

SELECT
    amount,
    oldbalanceOrg - newbalanceOrig AS balance_diff,
    isFraud
FROM
    fraud_detection.ps_20174392719_1491204439457_log
ORDER BY
    3 DESC
LIMIT
    20;

SELECT
    amount,
    oldbalanceOrg - newbalanceOrig AS balance_diff,
    CASE
        WHEN ROUND(amount, 2) = ROUND(oldbalanceOrg - newbalanceOrig, 2) THEN "MATCH"
        ELSE "MISMATCH"
    END AS comparison
FROM
    fraud_detection.ps_20174392719_1491204439457_log
WHERE
    isFraud = 1
LIMIT
    20;

SELECT
    CASE
        WHEN ROUND(amount, 2) = ROUND(oldbalanceOrg - newbalanceOrig, 2) THEN "MATCH"
        ELSE "MISMATCH"
    END AS comparison,
    isFraud,
    COUNT(*)
FROM
    fraud_detection.ps_20174392719_1491204439457_log
GROUP BY
    isFraud,
    CASE
        WHEN ROUND(amount, 2) = ROUND(oldbalanceOrg - newbalanceOrig, 2) THEN "MATCH"
        ELSE "MISMATCH"
    END;

SELECT
    CASE
        WHEN ROUND(amount, 2) = ROUND(oldbalanceOrg - newbalanceOrig, 2) THEN "MATCH"
        ELSE "MISMATCH"
    END AS comparison,
    COUNT(*),
    COUNT(
        CASE
            WHEN isFraud = 1 THEN isFraud
        END
    ) AS fraud_transactions,
    (
        COUNT(
            CASE
                WHEN isFraud = 1 THEN isFraud
            END
        ) / COUNT(*)
    ) * 100 AS fraud_rate
FROM
    fraud_detection.ps_20174392719_1491204439457_log
GROUP BY
    CASE
        WHEN ROUND(amount, 2) = ROUND(oldbalanceOrg - newbalanceOrig, 2) THEN "MATCH"
        ELSE "MISMATCH"
    END;

SELECT
    *
FROM
    fraud_detection.ps_20174392719_1491204439457_log;

SELECT
    oldbalanceDest,
    newbalanceDest,
    amount,
    oldbalanceDest + amount AS expected_new_balance,
    isFraud
FROM
    fraud_detection.ps_20174392719_1491204439457_log
LIMIT
    20;

SELECT 
oldbalanceDest,
amount,
newbalanceDest,
oldbalanceDest + amount AS expected_new_bal,
isFraud,
CASE WHEN oldbalanceDest + amount = newbalanceDest THEN "MATCH" ELSE "MISMATCH" END AS comparison
FROM fraud_detection.ps_20174392719_1491204439457_log
ORDER BY comparison;

SELECT 
CASE WHEN ROUND(oldbalanceDest + amount = newbalanceDest, 2) THEN "MATCH" ELSE "MISMATCH" END AS comparison,
COUNT(*) AS total_transactions,
SUM(isFraud) AS fraud_transactions,
(SUM(isFraud) / COUNT(*)) * 100 AS fraud_rate
FROM fraud_detection.ps_20174392719_1491204439457_log
GROUP BY CASE WHEN ROUND(oldbalanceDest + amount = newbalanceDest, 2) THEN "MATCH" ELSE "MISMATCH" END;

SELECT 
SUM(CASE WHEN isFlaggedFraud = 1 THEN isFraud END),
(SUM(CASE WHEN isFlaggedFraud = 1 THEN isFraud END) / SUM(isFraud)) *100
FROM fraud_detection.ps_20174392719_1491204439457_log;

SELECT 
SUM(CASE WHEN isFraud = 1 THEN isFlaggedFraud END)
FROM fraud_detection.ps_20174392719_1491204439457_log;

SELECT 
AVG(CASE WHEN isFraud = 1 THEN amount END),
AVG(CASE WHEN isFraud = 0 THEN amount END)
FROM fraud_detection.ps_20174392719_1491204439457_log;