CREATE TABLE IF NOT EXISTS sales (
	CustomerID INT,
    Age INT,
    Age_bracket VARCHAR(20),
    Gender VARCHAR(10),
	LoyaltyMember VARCHAR(5),
    Product_Type VARCHAR(20),
    SKU VARCHAR(20),
    Rating INT,
    OrderStatus VARCHAR(20),
    PaymentMethod VARCHAR(20),
    TotalPrice DECIMAL(10,2),
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    PurchaseDate DATE,
    `Month` VARCHAR(20),
    `Year` VARCHAR(20),
    Shipping_Type VARCHAR(20),
    Addons_Purchased VARCHAR(100),
    Add_on_total DECIMAL(10,2),
    Total_Sales DECIMAL(10,2)

);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/M&G_gadget.csv"
INTO TABLE sales
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- DATA CLEANING
SELECT 
	*
FROM sales;
-- Checking For Duplicates
SELECT MD5(CONCAT(CustomerID, LoyaltyMember, Product_Type, SKU, PurchaseDate, OrderStatus, PaymentMethod, UnitPrice, Quantity, Shipping_Type, Addons_Purchased)) AS hash_key,
       COUNT(*) AS occurrence
FROM sales
GROUP BY hash_key
HAVING COUNT(*) > 1;
-- No Duplicate was found

-- Checking Outliers
SELECT *
FROM sales
WHERE Quantity > (SELECT AVG(Quantity) + 3 * STDDEV(Quantity) FROM sales);

UPDATE sales
SET Gender = 'Unknown'
WHERE Gender IS NULL OR Gender = '';

-- DESCRIPTIVE STATISTICS OF THE SALES DATA
SELECT
	AVG(UnitPrice) AS "Average Unit Price",
    MIN(UnitPrice) AS "Mininum Unit Price",
    MAX(UnitPrice) AS "Maximum Unit Price",
    AVG(Quantity) AS "Average Quantity Sold",
    AVG(TotalPrice) AS "Average Total Price",
    AVG(Total_Sales) AS "Average Total Sales"
FROM sales;

-- Which Product Type is the most popular?
SELECT 
	Product_Type, 
	COUNT(*) AS product_count
FROM 
	sales
GROUP BY 
	Product_Type
ORDER BY 	
	product_count DESC;

-- Product Type on Total Sales And Quantity Sold
SELECT 
	Product_Type,
    SUM(Total_Sales) AS Total_sales,
    SUM(Quantity) AS Quantity_sold
FROM sales
WHERE OrderStatus = 'Completed'
GROUP BY Product_Type
ORDER BY 2 DESC;

-- Order Status Overview: 
SELECT 
	OrderStatus,
    COUNT(*) AS 'Number of Orders'
FROM
	sales
GROUP BY 
	OrderStatus
ORDER BY 
	2 DESC;
    
-- Payment Method Overview: Which Payment method is the most used by customers?
SELECT
	PaymentMethod,
    COUNT(*) AS `count`
FROM 
	sales
GROUP BY 
	PaymentMethod
ORDER BY 
	2 DESC;
    
  -- Order Staus on Shipping Type  
SELECT 
	Shipping_Type, 
	OrderStatus,
	COUNT(*) AS `count`
FROM sales 
WHERE OrderStatus IN ('Completed', 'Cancelled')
GROUP BY Shipping_Type, OrderStatus
ORDER BY `count` DESC, Shipping_Type;


-- Analyzing the Impact on Add-ons on the Total Sales
SELECT Addons_Purchased
FROM sales;

 UPDATE sales
 set Addons_Purchased = null
 where Addons_Purchased = 'NA';
 
SELECT 
    CASE 
        WHEN Addons_Purchased IS NOT NULL AND Addons_Purchased != '' THEN 'With Add-ons'
        ELSE 'Without Add-ons'
    END AS Addon_Status,
    AVG(Total_Sales) AS Avg_total_sales
FROM 
    sales
WHERE 
    OrderStatus = 'Completed'
GROUP BY 
    Addon_Status;

-- Query for Revenue Impact of Cancellations and Completed Orders
SELECT 
	OrderStatus,
    COUNT(*) AS total_orders,
    SUM(Total_Sales) AS "Total Sales"
FROM sales
WHERE OrderStatus IN ("Completed", "Cancelled")
GROUP BY OrderStatus;

-- Impact on high level orders on cancellations
SELECT 
    OrderStatus,
    COUNT(*) AS total_orders,
    SUM(Total_Sales) AS total_revenue,
    SUM(CASE WHEN Total_Sales > 1000 THEN Total_Sales ELSE 0 END) AS high_value_revenue
FROM 
    sales
WHERE 
    OrderStatus IN ('Completed', 'Cancelled')
GROUP BY 
    OrderStatus;

-- Total Sales By Months in 2024
SELECT MIN(`Year`), MAX(`Year`)
FROM sales;

SELECT
	`Month`,
    SUM(CASE WHEN OrderStatus = 'Completed' THEN Total_Sales ELSE 0 END) AS total_completed_sales,
    SUM(CASE WHEN OrderStatus = 'Cancelled' THEN Total_Sales ELSE 0 END) AS total_cancelled_sales
FROM 
	sales
WHERE `Year` = 2024
GROUP BY 
	`Month`
ORDER BY 2 DESC;

-- Cancellation Rate by Product Type
SELECT
	Product_Type,
    SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS 'Cancelled Orders',
    COUNT(*) AS 'Total Orders',
    (SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS 'Cancellation Rate'
FROM 
	sales
GROUP BY 
	Product_Type;
    
-- Cancellation Rate by Payment Method
SELECT
	PaymentMethod,
    SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS 'Cancelled Orders',
    COUNT(*) AS 'Total Orders',
    (SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS 'Cancellation Rate'
FROM 
	sales
GROUP BY 
	PaymentMethod
ORDER BY 4 DESC;
    
-- Trends Over Time for Cancelled and Completed Orders
SELECT 
    `Year`, 
    `Month`,
    OrderStatus,
    COUNT(*) AS total_orders
FROM sales
GROUP BY `Year`, `Month`, OrderStatus
ORDER BY `Year`, `Month`;

-- Seasonal Sales Trend
SELECT 
    `Year`, 
    `Month`,
    SUM(Total_Sales) AS Total_Sales
FROM sales
GROUP BY `Year`, `Month`
ORDER BY `Year`, Total_Sales DESC;

-- Correlation Analysis between Orderstatus and Payment method
SELECT 
    PaymentMethod,
    OrderStatus,
    AVG(Total_Sales) AS avg_sales
FROM sales
GROUP BY PaymentMethod, OrderStatus
ORDER BY 3 DESC;

-- Total Sales by Shipping Type
SELECT 
    Shipping_Type,
    AVG(Total_Sales) AS Avg_sales
FROM 
    sales
WHERE OrderStatus = 'Completed'
GROUP BY 
    Shipping_Type
ORDER BY Avg_sales DESC;

SELECT *
FROM sales;

-- Average Ratings for Product Type
SELECT 
	Product_Type,
    AVG(Rating) Average_Ratings
FROM 
	sales
GROUP BY 
	Product_Type
ORDER BY 2 DESC;

-- Average Ratings for Shipping Type
SELECT 
	Shipping_Type,
    AVG(Rating) Average_Ratings
FROM sales
GROUP BY Shipping_Type
ORDER BY 2 DESC;

-- Demographic Analysis
-- 1. The Ratio of Male to Female customers?
SELECT 
	SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) AS "Number of Males",
    SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS "Number of Females",
    CASE
		WHEN SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) = 0 THEN 'INFINITY'
	ELSE
		ROUND(SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END)/SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END), 2) 
	END AS "Ratio of Male to Female" 
FROM sales;

-- Average Total Sales by Age Brackect
SELECT 
	Age_bracket,
    AVG(Total_Sales)  AS avg_sales
FROM 
	sales
WHERE 
    OrderStatus = 'Completed'
GROUP BY Age_bracket
ORDER BY 2 DESC;

-- Most Popular Products by Age Group
SELECT 
	Age_bracket,
    Product_Type,
    COUNT(Product_Type) AS purchase_count
FROM sales
GROUP BY Age_bracket, Product_Type
ORDER BY Age_bracket, 3 DESC ;

-- Average Total Sales by Gender
SELECT 
	Gender,
    AVG(Total_Sales) AS Average_sales
FROM 
	sales
WHERE 
    OrderStatus = 'Completed'
GROUP BY 
	Gender
ORDER BY 2 DESC;

-- Product Preference by Gender
SELECT 
    Gender,
    Product_Type,
    COUNT(*) AS Product_Count
FROM 
    sales
GROUP BY 
    Gender, 
    Product_Type
ORDER BY 
    Gender, 
    Product_Count DESC;
    
-- Cross-Analysis of Age and Gender On Total Sales
SELECT 
	Gender,
    Age_bracket,
    AVG(Total_Sales) AS Avg_Sales
FROM 
	sales
WHERE 
    OrderStatus = 'Completed'
GROUP BY 
	Gender,
    Age_bracket
ORDER BY 
    Age_bracket,
    Gender;

-- Steps For Estimating Customer Lifetime Value
-- 1. Average Revenue Per Purchase
SELECT 
	Age_bracket,
    Gender,
    AVG(Total_Sales) AS avg_revenue_per_purchase
FROM 
	sales
WHERE 
    OrderStatus = 'Completed'
GROUP BY
	Age_bracket,
    Gender
ORDER BY 
	Age_bracket,
    Gender;
    
SELECT 
	LoyaltyMember,
	AVG(Total_Sales) AS 'Avg Total Sales'
FROM sales
WHERE LoyaltyMember IN ('Yes', 'No')
GROUP BY LoyaltyMember
ORDER BY 2 DESC;
    
-- 2. Average Purchase Frequency
WITH Purchase_Frequency AS (
	SELECT
		CustomerID,
        Age_bracket,
        Gender,
        COUNT(*) AS purchase_count,
        SUM(Total_Sales) AS Total_revenue
    FROM 
		sales
	WHERE 
		OrderStatus = 'Completed'
	GROUP BY 
		CustomerID, Age_bracket, Gender
)
SELECT
	Age_bracket,
    Gender,
    AVG(purchase_count) AS Avg_purchase_count,
    AVG(Total_revenue) AS Avg_total_revenue
FROM 
	Purchase_Frequency
GROUP BY 
	Age_bracket,
    Gender;
    
-- 3. Estimate Customer Lifetime Value by Age and Gender
WITH CLV_Calculation AS (
    SELECT 
        Age_bracket,
        Gender,
        AVG(Total_Sales) AS avg_revenue_per_purchase,
        COUNT(DISTINCT CustomerID) / NULLIF(COUNT(*), 0) AS avg_purchase_frequency
    FROM sales
    WHERE 
		OrderStatus = 'Completed'
    GROUP BY Age_bracket, Gender
)

SELECT 
    Age_bracket,
    Gender,
    avg_revenue_per_purchase * avg_purchase_frequency * 5 AS estimated_CLV
FROM CLV_Calculation;

-- Number of customers by Age_bracket and gender.
SELECT 
    Age_bracket,
    Gender,
    COUNT(DISTINCT CustomerID) AS customer_count
FROM sales
GROUP BY Age_bracket, Gender;

-- Popular Product Type by Gender and Age_bracket
SELECT 
    Age_bracket,
    Gender,
    Product_Type,
    COUNT(*) AS purchase_count
FROM sales
GROUP BY Age_bracket, Gender, Product_Type
ORDER BY purchase_count DESC, Age_bracket;

-- Correlation analysis of Product type and Cancelled orders
SELECT COUNT(OrderStatus)
FROM sales
WHERE OrderStatus = 'Cancelled';

SELECT Product_Type, 
       COUNT(*) AS total_orders,
       SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
       (SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS cancellation_rate
FROM sales
GROUP BY Product_Type
order by cancellation_rate desc;

SELECT Shipping_Type, 
       COUNT(*) AS total_orders,
       SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
       (SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS cancellation_rate
FROM sales
GROUP BY Shipping_Type
ORDER BY cancelled_orders DESC, cancellation_rate DESC;

SELECT Age_bracket, Gender, 
       COUNT(*) AS total_orders,
       SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
       (SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS cancellation_rate
FROM sales
GROUP BY Age_bracket, Gender
ORDER BY cancellation_rate DESC;


SELECT PaymentMethod, 
       COUNT(*) AS total_orders,
       SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
       (SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS cancellation_rate
FROM sales
GROUP BY PaymentMethod
ORDER BY cancelled_orders DESC, cancellation_rate DESC;

SELECT Product_Type, Rating, 
       COUNT(*) AS total_orders,
       SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
       (SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS cancellation_rate
FROM sales
GROUP BY Product_Type, Rating
ORDER BY Product_Type , Rating;


SELECT Product_Type,
	Quantity, UnitPrice, Total_Sales
FROM sales
WHERE Shipping_Type = 'Expedited'
GROUP BY Product_Type,Quantity, UnitPrice, Total_Sales ;

SELECT MIN(Quantity), AVG(Quantity), MAX(Quantity) 
FROM sales;

SELECT Shipping_Type, Quantity
FROM sales
WHERE Quantity > 5
GROUP BY Shipping_Type, Quantity
ORDER BY Quantity DESC;

























































































