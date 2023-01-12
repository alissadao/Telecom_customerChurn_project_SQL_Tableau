SELECT * 
FROM customer

--- QUESTION1: HOW MANY PEOPLE JOINED AND CHURNED DURING THE LAST QUARTER? 

SELECT COUNT(Customer_Status) as num_of_people
FROM customer
WHERE Customer_Status = 'Joined' 

-- There are 454 people who joined 

SELECT COUNT(Customer_Status) as num_of_people
FROM customer
WHERE Customer_Status = 'Churned'

--There are 1869 people who churned 

SELECT COUNT(Customer_Status) as num_of_people
FROM customer
WHERE Customer_Status = 'Stayed'

--4720


--- QUESTION 2: THE CUSTOMER PROFILE FOR WHO JOINED 

SELECT *, 
CASE WHEN 
Age < 15 THEN 'Children and young adolescents'
WHEN Age >= 15 AND Age <= 64 THEN 'Working-age'
WHEN Age > 64 THEN 'The Elderly'
END AS age_range
INTO joined_customer
FROM customer
WHERE Customer_Status = 'Joined'

SELECT * 
FROM joined_customer

ALTER TABLE joined_customer
DROP COLUMN Customer_Status, Churn_Category, Churn_Reason, age_group

SELECT COUNT(Gender) as number_of_people, Gender
FROM joined_customer
GROUP BY Gender -- more male

SELECT COUNT(age_range), age_range
FROM joined_customer
GROUP BY age_range -- more working age

SELECT COUNT(Married) as number_of_people, Married
FROM joined_customer
GROUP BY Married -- more unmarried

SELECT COUNT(Offer) as number_of_people, Offer
FROM joined_customer
GROUP BY Offer -- none offer

SELECT COUNT(Phone_Service) as number_of_people, Phone_Service
FROM joined_customer
GROUP BY Phone_Service -- yes

SELECT COUNT(Internet_Service) as number_of_people, Internet_Service
FROM joined_customer
GROUP BY Internet_Service -- yes

SELECT COUNT(Contract) as number_of_people, Contract
FROM joined_customer
GROUP BY Contract -- month to month

SELECT COUNT(Paperless_Billing) as number_of_people, Paperless_Billing
FROM joined_customer
GROUP BY Paperless_Billing -- no 

SELECT COUNT(Payment_Method) as number_of_people, Payment_Method
FROM joined_customer
GROUP BY Payment_Method -- credit card 

ALTER TABLE joined_customer
ALTER COLUMN Number_of_Dependents float

SELECT CEILING(AVG(Number_of_Dependents)) AS average_dependents
FROM joined_customer -- 1 

SELECT ROUND(AVG(Avg_Monthly_Long_Distance_Charges),2) AS avg_charge
FROM joined_customer --22.3

SELECT Multiple_Lines, COUNT(Multiple_Lines)
FROM joined_customer
GROUP BY Multiple_Lines -- no is majority 

SELECT Internet_Type, COUNT(Internet_Type)
FROM joined_customer
GROUP BY Internet_Type -- DSL 

SELECT Online_Security, COUNT(Online_Security)
FROM joined_customer
GROUP BY Online_Security -- NO 

SELECT Online_Backup, COUNT(Online_Backup)
FROM joined_customer
GROUP BY Online_Backup -- NO

SELECT Device_Protection_Plan, COUNT(Device_Protection_Plan)
FROM joined_customer
GROUP BY Device_Protection_Plan --NO

SELECT Premium_Tech_Support, COUNT(Premium_Tech_Support)
FROM joined_customer
GROUP BY Premium_Tech_Support --NO

SELECT Streaming_Movies, COUNT(Streaming_Movies)
FROM joined_customer
GROUP BY Streaming_Movies --NO

SELECT Streaming_Music, COUNT(Streaming_Music)
FROM joined_customer
GROUP BY Streaming_Music -- NO

SELECT Streaming_TV, COUNT(Streaming_TV)
FROM joined_customer
GROUP BY Streaming_TV --NO

SELECT Unlimited_Data, COUNT(Unlimited_Data)
FROM joined_customer
GROUP BY Unlimited_Data -- YES 

SELECT ROUND(AVG(Total_Charges), 2) AS TOTALCHARGE, ROUND(AVG(Total_Refunds),2) AS REFUND, 
ROUND(AVG(Total_Revenue),2) AS REVENUE, ROUND(AVG(Total_Extra_Data_Charges),2) AS EXTRADATA,
ROUND(AVG(Total_Long_Distance_Charges),2) AS long_distance, ROUND(AVG(Monthly_Charge),2) AS monthly
FROM joined_customer

--REFUND	REVENUE	EXTRADATA	TOTALCHARGE	long_distance	monthly
--0.24	119.56	2.38	79.29	38.13	42.78

SELECT TOP 5 City, COUNT(City) as num
FROM joined_customer
GROUP BY City
ORDER BY COUNT(City) DESC  

-- top 5 cities with the most of the customers: Los Angeles, San Diego, San Francisco, Glendale, Sacramento

--- QUESTION 3: THE CUSTOMER PROFILE FOR WHO STAYED 

-- firstly, create a new table for the stayed customers. 

SELECT *, 
CASE WHEN 
Age < 15 THEN 'Children and young adolescents'
WHEN Age >= 15 AND Age <= 64 THEN 'Working-age'
WHEN Age > 64 THEN 'The Elderly'
END AS age_range
INTO stayed_customer
FROM customer
WHERE Customer_Status = 'Stayed'

SELECT * 
FROM stayed_customer

ALTER TABLE stayed_customer
DROP COLUMN Churn_Category, Churn_Reason, age_group

SELECT COUNT(Gender), Gender
FROM stayed_customer
GROUP BY Gender -- male

SELECT COUNT(age_range), age_range
FROM stayed_customer
GROUP BY age_range -- working age

SELECT Married, COUNT(Married)
FROM stayed_customer
GROUP BY Married -- yes

SELECT COUNT(Offer), Offer
FROM stayed_customer
GROUP BY Offer -- none

SELECT Phone_Service, COUNT(Phone_Service)
FROM stayed_customer
GROUP BY Phone_Service -- yes

SELECT Multiple_Lines, COUNT(Multiple_Lines)
FROM stayed_customer
GROUP BY Multiple_Lines --NO

SELECT Internet_Service, COUNT(Internet_Service)
FROM stayed_customer
GROUP BY Internet_Service -- yes

SELECT Internet_Type, COUNT(Internet_Type)
FROM stayed_customer
GROUP BY Internet_Type -- Fiber Optic

SELECT Online_Security, COUNT(Online_Security)
FROM stayed_customer
GROUP BY Online_Security --NO

SELECT Online_Backup, COUNT(Online_Backup)
FROM stayed_customer
GROUP BY Online_Backup --YES

SELECT Device_Protection_Plan, COUNT(Device_Protection_Plan)
FROM stayed_customer 
GROUP BY Device_Protection_Plan --YES

SELECT Premium_Tech_Support, COUNT(Premium_Tech_Support)
FROM stayed_customer
GROUP BY Premium_Tech_Support --NO

SELECT Streaming_Movies, COUNT(Streaming_Movies)
FROM stayed_customer
GROUP BY Streaming_Movies -- YES

SELECT Streaming_Music, COUNT(Streaming_Music)
FROM stayed_customer
GROUP BY Streaming_Music -- NO

SELECT Streaming_TV, COUNT(Streaming_TV)
FROM stayed_customer
GROUP BY Streaming_TV -- YES

SELECT Unlimited_Data, COUNT(Unlimited_Data)
FROM stayed_customer
GROUP BY Unlimited_Data -- YES

SELECT Contract, COUNT(Contract)
FROM stayed_customer
GROUP BY Contract -- two year

SELECT Paperless_Billing, COUNT(Paperless_Billing)
FROM stayed_customer
GROUP BY Paperless_Billing -- yes

SELECT Payment_Method, COUNT(Payment_Method)
FROM stayed_customer
GROUP BY Payment_Method -- bank withdrawal 

SELECT CEILING(AVG(Number_of_Dependents)) AS dependent, CEILING(AVG(Number_of_Referrals)) AS referral, 
CEILING(AVG(Tenure_in_Months)) AS tenure, ROUND(AVG(Avg_Monthly_Long_Distance_Charges),2) AS monthly_distance_charge, 
ROUND(AVG(Avg_Monthly_GB_Download),2) AS GB_download, ROUND(AVG(Monthly_Charge),2) AS monthly_charge, 
ROUND(AVG(Total_Charges),2) AS total_charge, ROUND(AVG(Total_Refunds),2) AS refund, ROUND(AVG(Total_Extra_Data_Charges),2) AS extraData_Charge,
ROUND(AVG(Total_Long_Distance_Charges),2) AS total_distance, ROUND(AVG(Total_Revenue),2) AS revenue
FROM stayed_customer

--dependent	referral	tenure	monthly_distance_charge	GB_download	monthly_charge	total_charge	refund	extraData_Charge	total_distance	revenue
--1	2	41	22.94	20.36	61.74	2788.52	2.3	7.17	942.29	3735.68

SELECT TOP 5 City, COUNT(City) as num
FROM stayed_customer
GROUP BY City
ORDER BY COUNT(City) DESC  

--Los Angeles, San Diego, San Jose, Sacramento, San Francisco

--- QUESTION 4: PROFILE OF PEOPLE WHO CHURNED

SELECT *, 
CASE WHEN 
Age < 15 THEN 'Children and young adolescents'
WHEN Age >= 15 AND Age <= 64 THEN 'Working-age'
WHEN Age > 64 THEN 'The Elderly'
END AS age_range
INTO churned_customer
FROM customer
WHERE Customer_Status = 'Churned'

ALTER TABLE churned_customer
DROP COLUMN Churn_Category, Churn_Reason, age_group

SELECT * 
FROM churned_customer

SELECT COUNT(Gender), Gender
FROM churned_customer
GROUP BY Gender -- female

SELECT COUNT(age_range), age_range
FROM churned_customer
GROUP BY age_range -- working age

SELECT Married, COUNT(Married)
FROM churned_customer
GROUP BY Married -- no

SELECT COUNT(Offer), Offer
FROM churned_customer
GROUP BY Offer -- none

SELECT Phone_Service, COUNT(Phone_Service)
FROM churned_customer
GROUP BY Phone_Service -- yes

SELECT Multiple_Lines, COUNT(Multiple_Lines)
FROM churned_customer
GROUP BY Multiple_Lines -- yes 

SELECT Internet_Service, COUNT(Internet_Service)
FROM churned_customer
GROUP BY Internet_Service -- yes

SELECT Internet_Type, COUNT(Internet_Type)
FROM churned_customer
GROUP BY Internet_Type -- Fiber Optic

SELECT Online_Security, COUNT(Online_Security)
FROM churned_customer
GROUP BY Online_Security --NO

SELECT Online_Backup, COUNT(Online_Backup)
FROM churned_customer
GROUP BY Online_Backup -- no

SELECT Device_Protection_Plan, COUNT(Device_Protection_Plan)
FROM churned_customer 
GROUP BY Device_Protection_Plan --YES

SELECT Premium_Tech_Support, COUNT(Premium_Tech_Support)
FROM churned_customer
GROUP BY Premium_Tech_Support --NO

SELECT Streaming_Movies, COUNT(Streaming_Movies)
FROM churned_customer
GROUP BY Streaming_Movies -- no

SELECT Streaming_Music, COUNT(Streaming_Music)
FROM churned_customer
GROUP BY Streaming_Music -- NO

SELECT Streaming_TV, COUNT(Streaming_TV)
FROM churned_customer
GROUP BY Streaming_TV -- no

SELECT Unlimited_Data, COUNT(Unlimited_Data)
FROM churned_customer
GROUP BY Unlimited_Data -- YES

SELECT Contract, COUNT(Contract)
FROM churned_customer
GROUP BY Contract -- month to month

SELECT Paperless_Billing, COUNT(Paperless_Billing)
FROM churned_customer
GROUP BY Paperless_Billing -- yes

SELECT Payment_Method, COUNT(Payment_Method)
FROM churned_customer
GROUP BY Payment_Method -- bank withdrawal 

SELECT CEILING(AVG(Number_of_Dependents)) AS dependent, CEILING(AVG(Number_of_Referrals)) AS referral, 
CEILING(AVG(Tenure_in_Months)) AS tenure, ROUND(AVG(Avg_Monthly_Long_Distance_Charges),2) AS monthly_distance_charge, 
ROUND(AVG(Avg_Monthly_GB_Download),2) AS GB_download, ROUND(AVG(Monthly_Charge),2) AS monthly_charge, 
ROUND(AVG(Total_Charges),2) AS total_charge, ROUND(AVG(Total_Refunds),2) AS refund, ROUND(AVG(Total_Extra_Data_Charges),2) AS extraData_Charge,
ROUND(AVG(Total_Long_Distance_Charges),2) AS total_distance, ROUND(AVG(Total_Revenue),2) AS revenue
FROM churned_customer

--dependent	referral	tenure	monthly_distance_charge	GB_download	monthly_charge	total_charge	refund	extraData_Charge	total_distance	revenue
--1	0	17	23.17	22.18	73.35	1531.8	1.52	7.16	433.92	1971.35

SELECT TOP 5 City, COUNT(City)
FROM churned_customer
GROUP BY City
ORDER BY COUNT(City) DESC

-- San Diego, Los Angeles, San Francisco, San Jose, Fallbrook

--- Question 5: What city that can be focused to develop (have the potential development)

-- city with both a great number of customers who staying and joining as well as having large population 
;WITH most_customer AS 
(SELECT TOP 5 customer.City, COUNT(customer.Customer_ID) AS num_people, SUM(zipcode.Population) AS total_population
FROM customer
INNER JOIN 
zipcode
ON customer.Zip_Code = zipcode.Zip_Code
WHERE customer.Customer_Status = 'Joined'
GROUP BY customer.City
ORDER BY COUNT(customer.Customer_ID) DESC),

best_size AS 
(SELECT TOP 5 customer.City, COUNT(customer.Customer_ID) AS num_people, SUM(zipcode.Population) AS total_population
FROM customer
INNER JOIN 
zipcode
ON customer.Zip_Code = zipcode.Zip_Code
WHERE customer.Customer_Status = 'Joined'
GROUP BY customer.City
ORDER BY SUM(zipcode.Population) DESC)

SELECT * 
FROM most_customer
INNER JOIN 
best_size
ON most_customer.City = best_size.City

--Los Angeles
--San Francisco
--San Diego
--Sacramento


--- QUESTIONS 6: Is the company losing high value customers?
SELECT * 
FROM customer

-- First task, how much percentage of the total revenue did the churned customers account for?

SELECT 
ROUND((SELECT SUM(Total_Revenue)
FROM customer
WHERE Customer_Status ='Churned')/SUM(Total_Revenue),4)*100 AS revenue_churned
FROM customer

SELECT 
ROUND((SELECT SUM(Total_Revenue)
FROM customer
WHERE Customer_Status ='Stayed')/SUM(Total_Revenue),4)*100 AS revenue_stayed
FROM customer

SELECT 
ROUND((SELECT SUM(Total_Revenue)
FROM customer
WHERE Customer_Status ='Joined')/SUM(Total_Revenue),4)*100 AS revenue_joined
FROM customer

-- 17,24%, compared to 82,51% of stayed and 0.25% of joined customers

-- Second task: What are the top customers who contribute above the average revenue of the company 

SELECT COUNT(Customer_Status) AS num_people, Customer_Status
FROM customer
WHERE Total_Revenue > 
(SELECT AVG(Total_Revenue)
FROM customer)
GROUP BY Customer_Status

--Customer_Status	num_people
--Churned	446
--Stayed	2316

--people who leave do not generate that much revenue for the company 


---- FINAL QUESTION: WHY DO THE CUSTOMERS LEAVE? 

SELECT TOP 3 COUNT(Churn_Reason) AS num_reason, Churn_Reason
FROM customer
WHERE Churn_Reason != 'N/A'
GROUP BY Churn_Reason
ORDER BY COUNT(Churn_Reason) DESC 

--Churn_Reason
--Competitor had better devices
--Competitor made better offer
--Attitude of support person









