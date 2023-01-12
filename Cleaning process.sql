----- cleaning process ----

-- get an overview of the dataset 

SELECT * 
FROM customer

--- check if there are any duplicates in the customer ID column 

SELECT Customer_ID, COUNT(Customer_ID)
FROM customer
GROUP BY Customer_ID
HAVING COUNT(Customer_ID) > 1 

-- there is no duplicate 

--- check the data type and null column 

SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customer'

-- the data type is not correct. 
-- wrong data type: 
--Number_of_Referrals
--Tenure_in_Months
--Total_Refunds
--Total_Extra_Data_Charges
--Total_Long_Distance_Charges
-- Number_of_Referrals
--Avg_Monthly_GB_Download

SELECT 
Number_of_Referrals,
Tenure_in_Months,
Total_Refunds,
Total_Extra_Data_Charges,
Total_Long_Distance_Charges
FROM customer

ALTER TABLE customer
ALTER COLUMN Number_of_Referrals int

ALTER TABLE customer
ALTER COLUMN Tenure_in_Months int

ALTER TABLE customer
ALTER COLUMN Total_Refunds float

ALTER TABLE customer
ALTER COLUMN Total_Extra_Data_Charges float

ALTER TABLE customer
ALTER COLUMN Total_Long_Distance_Charges float

ALTER TABLE customer
ALTER COLUMN Number_of_Referrals int

ALTER TABLE customer 
ALTER COLUMN Avg_Monthly_GB_Download float

ALTER TABLE customer
ALTER COLUMN Number_of_Dependents float 

-- there are few null columns: 
--Avg_Monthly_Long_Distance_Charges, Multiple_Lines, Internet_Type, Avg_Monthly_GB_Download, Online_Security, Online_Backup, Device_Protection_Plan, Premium_Tech_Support
--Streaming_TV, Streaming_Movies, Streaming_Music, Unlimited_Data, Churn_Category, Churn_Reason

--- look at the null value of all the columns 

SELECT * 
FROM customer
WHERE 
Online_Backup IS NULL OR Device_Protection_Plan IS NULL OR Premium_Tech_Support IS NULL OR Streaming_TV IS NULL OR  Streaming_Movies IS NULL OR 
Streaming_Music IS NULL OR Unlimited_Data IS NULL OR Churn_Category IS NULL OR Churn_Reason IS NULL OR Avg_Monthly_Long_Distance_Charges IS NULL OR 
Multiple_Lines IS NULL OR Internet_Type IS NULL OR  Avg_Monthly_GB_Download IS NULL OR Online_Security IS NULL

-- It seems to be that Avg_Monthly_Long_Distance_Charges and multiple lines are null when the answer for the phone service is no. Let's see if it is true. 

SELECT Phone_Service, Avg_Monthly_Long_Distance_Charges, Multiple_Lines
FROM customer
WHERE Phone_Service = 'No'
EXCEPT 
SELECT Phone_Service, Avg_Monthly_Long_Distance_Charges, Multiple_Lines
FROM customer
WHERE Avg_Monthly_Long_Distance_Charges IS NULL AND Multiple_Lines is null

-- there are no rows that are not returned by both two statements. As a result, I can confirm that th avarage monthly long distance changes is null when the phone service is 'no'. 
-- replace the null of average monthly long distances charges column by 'O'

UPDATE customer
SET Avg_Monthly_Long_Distance_Charges = 0 
WHERE Phone_Service = 'No'

-- replace the null values of the multiple lines with 'N/A'
UPDATE customer
SET Multiple_Lines = 'N/A'
WHERE Phone_Service = 'No'

-- check again  

SELECT Phone_Service, Avg_Monthly_Long_Distance_Charges, Multiple_Lines
FROM customer
WHERE Avg_Monthly_Long_Distance_Charges IS NULL OR Multiple_Lines IS NULL

-- there are no nulls left
-- it also seems to be that Online_Backup ,Device_Protection_Plan, Premium_Tech_Support, Streaming_TV, Streaming_Movies, Streaming_Music, Unlimited_Data, Avg_Monthly_GB_Download
--Internet_Type, and Online_Security are empty when the Internet Service is "No". Let's see if it is true or not

SELECT Internet_Service, Internet_Type, Avg_Monthly_GB_Download, Online_Security, Online_Backup, Device_Protection_Plan, Premium_Tech_Support,
Streaming_TV, Streaming_Movies, Streaming_Music, Unlimited_Data
FROM customer
WHERE Internet_Service = 'No'
EXCEPT 
SELECT Internet_Service, Internet_Type, Avg_Monthly_GB_Download, Online_Security, Online_Backup, Device_Protection_Plan, Premium_Tech_Support,
Streaming_TV, Streaming_Movies, Streaming_Music, Unlimited_Data
FROM customer
WHERE Internet_Type IS NULL AND Avg_Monthly_GB_Download IS NULL AND Online_Security IS NULL AND Online_Backup IS NULL AND Device_Protection_Plan IS NULL AND
Premium_Tech_Support IS NULL AND Streaming_TV IS NULL AND Streaming_Movies IS NULL AND Streaming_Music IS NULL AND Unlimited_Data IS NULL

-- Our hypothesis is correct. Now, replace all the null values with 'N/A'
UPDATE customer
SET Online_Backup = 'N/A', 
Device_Protection_Plan  = 'N/A',
Premium_Tech_Support  = 'N/A',
Streaming_TV = 'N/A',
Streaming_Movies = 'N/A',
Streaming_Music = 'N/A',
Unlimited_Data = 'N/A'
WHERE Internet_Service = 'No'

-- replace the null values  in column Avg_Monthly_GB_Download with 0
UPDATE customer
SET Avg_Monthly_GB_Download = 0 
WHERE Internet_Service = 'No'

-- check again
SELECT * 
FROM customer
WHERE 
Online_Backup IS NULL OR 
Device_Protection_Plan IS NULL OR
Premium_Tech_Support IS NULL OR
Streaming_TV IS NULL OR 
Streaming_Movies IS NULL OR
Streaming_Music IS NULL OR
Unlimited_Data IS NULL OR
Avg_Monthly_Long_Distance_Charges IS NULL OR
Multiple_Lines IS NULL OR
Internet_Type IS NULL OR 
Avg_Monthly_GB_Download IS NULL OR
Online_Security IS NULL

-- there are no null values left. 
-- it seems that the churn category and churn reason are null when the customer status is ot "Churn". Let's check 

SELECT Customer_Status, Churn_Category, Churn_Reason
FROM customer
WHERE Customer_Status != 'Churned'
EXCEPT 
SELECT Customer_Status, Churn_Category, Churn_Reason
FROM customer
WHERE Churn_Category IS NULL OR Churn_Reason IS NULL 
-- our hypothesis is correct. Let's replace the null values with "N/A"

UPDATE customer
set Churn_Category = 'N/A'
WHERE Customer_Status != 'Churned'

UPDATE customer
SET Churn_Reason = 'N/A'
WHERE Customer_Status != 'Churned'

-- check again 
SELECT Customer_Status, Churn_Category, Churn_Reason
FROM customer
WHERE Churn_Category IS NULL OR Churn_Reason IS NULL 

-- no null values left 


-- checking syntax error
SELECT LEN(Zip_Code) AS length_
FROM customer
WHERE LEN(Zip_Code) > 5 
--correct syntax 

-- the customer table is cleaned. 

-- now, look at the zip_code table 

SELECT * 
FROM zipcode

-- check duplicate for the zip code column 

SELECT Zip_Code, COUNT(Zip_Code)
FROM zipcode
GROUP BY Zip_Code
HAVING COUNT(Zip_code) > 1 
-- no duplicate 

-- now, check the data type and null columns

SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'zipcode'
-- correct data type and no null 

-- both two tables are cleaned. 






