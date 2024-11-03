# Customer Purchase Behavior 

## Project Overview
The primary goal of this project is to analyze customer purchasing patterns to identify trends, insights, and areas for potential improvement. By examining factors such as order status, product popularity, and demographic behavior (age and gender), this project aims to support data-driven decision-making in marketing, inventory planning, and customer retention strategies.

## Data Source
This data was gotten from Kaggle (Electronic_sales_Sep2023-Sep2024.csv). Click the link to download the data.
[Download here](https://www.kaggle.com/datasets/cameronseamons/electronic-sales-sep2023-sep2024)

## Data Overview
The csv dataset contains the 16 columns and 20000 rows. The data set contains the following column:
- Customer ID
- Age
- Gender
- Loyalty Member
- Product Type
- SKU
- Rating
- Order Status
- Payment Method
- Total Price
- Unit Price
- Quantity
- Purchase Date
- Shipping Type
- Add-ons Purchase
- Add-on Total

## Tools Used
- MySQL Workbench: For data cleaning and exploratory data analysis.
-- Microsoft Excel 2019: For exploratory data analysis and data visualization.

## Key Insights
### Sales Perfomance by Product Type
#### **Question 1**: What is the most popular product and least popular product?
- **Objective**: To identify the most in-demand products by analyzing the sales data, which can reveal customer preferences and help shape future inventory and marketing strategies.
  
- **SQL CODE**: The following code was used to calculate the count of each product type, identifying the most and least popular products based on the number of sales transactions.
   ```SQL
    SELECT 
	    Product_Type, 
	    COUNT(*) AS product_count
   FROM 
	    sales
   GROUP BY 
	    Product_Type
   ORDER BY 	
	  product_count DESC;
   
- **Output**:

  ![Popular product](https://github.com/OchePrince/Electronic_gadget/blob/main/Popular%20product.png)

- **Key Findings**: The analysis revealed that Smartphone is the most popular product type, indicating high demand and interest from customers, while Headphones were identified as the least popular product.

- **Implication**: This information is valuable for inventory management, allowing the business to prioritize high-demand items. Stock levels for popular products like Smartphones should be maintained to meet demand, while lower-demand items like Headphones may need different stocking strategies.

- **Recommendations**: Leverage the popularity of Smartphones in promotions, bundling offers, and targeted advertising campaigns. By focusing on these high-performing items, the business can maximize conversions, improve sales, and enhance the effectiveness of marketing efforts. For lower-demand products, consider implementing promotional discounts or alternative sales strategies to increase their appeal.

#### **Question 2**: What is the Total Sales and Quantity Sold for each Product Type?
- **OBJECTIVE**: To determine which Product type generate the most and least total sales and the number of quantity sold.
- **SQL CODE** :
  ```SQL
	SELECT
	  Product_Type,
	    SUM(Total_Sales) AS Total_sales,
	    SUM(Quantity) AS Quantity_sold
	FROM sales
	WHERE OrderStatus = 'Completed'
	GROUP BY Product_Type
	ORDER BY 2 DESC;
- **CODE OUTPUT**:
  



