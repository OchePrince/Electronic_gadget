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
- **Objective**: To determine which Product type generate the most and least total sales and the number of quantity sold.
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
- **Output**:

  ![Quantity sold](https://github.com/OchePrince/Electronic_gadget/blob/main/Quantity%20sold.png)

- **Key Findings**: The analysis reveals significant insights into product performance;
  1. **Smartphone**: Leading the sales chart with total sales of $14.6 million and a quantity sold of 21,947 units.
  2. **Smartwatch**: Following closely, this product type generated $9.5 million in sales and saw 12,244 units sold.
  3. **Headphones**: On the contrary, this product type performed the weakest, generating only $2.8 million in sales with a total of 7,565 units sold.

- **Recommendations**:
  1. **Expand Inventory for High-Selling Products**: Given the robust sales figures for Smartphones and Smartwatches, increasing stock levels and variety for these items will ensure availability to meet customer demand.
  2. **Develop Targeted Marketing Strategies for Low-Selling Products**: For Headphones, consider implementing targeted marketing campaigns to raise awareness and encourage purchases. This may include promotions, bundling with popular products, or leveraging customer reviews and testimonials to enhance their appeal.
---
### Customer Analysis Demographics
**Objective**: The analysis of customer demographics aims to provide valuable insights into the characteristics and behaviors of our customer base. By examining factors such as age, gender, and loyalty status, we can better understand our audience and tailor our marketing strategies accordingly.
#### Average Total Sales by Age Bracket
- **SQL CODE**:
  ```SQL
	SELECT 
		Age_bracket,
	    AVG(Total_Sales)  AS avg_sales
	FROM 
		sales
	WHERE 
	    OrderStatus = 'Completed'
	GROUP BY Age_bracket
	ORDER BY 2 DESC;
- **Output**:

  ![agebracket](https://github.com/OchePrince/Electronic_gadget/blob/main/agebracket%20.png)

- **Key Findings**: The data reveals a diverse age distribution among our customers. The majority of sales are concentrated in specific age brackets, with the Adult and Old groups accounting for significant portions of total purchases. This suggests that marketing efforts could be particularly effective if targeted toward these demographics.

#### Average Total Sales by Gender
- **SQL CODE**:
  ```SQL
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
- **Output**:

  ![gender sales](https://github.com/OchePrince/Electronic_gadget/blob/main/gender%20sales.png)

- **Key Findings**: The data shows that the average sales for the female customers is slightly higher than the average sales of the male customers,  it suggests that on average, female customers tend to spend more per transaction than male customers. Here are some potential insights and interpretations for this finding:
   1. Female customers might be purchasing higher-value products, or products with add-ons or upgrades, leading to higher average sales.
   2. It could also indicate that certain products appealing more to female customers have higher price points or are purchased in larger quantities per transaction.
   3. Understanding which product type drive higher average sales among females can help in creating tailored recommendations and promotions for similar products.

#### Product Preference by Gender
- **SQL CODE**:
  ```SQL
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
- **Output**:

  ![gender preference](https://github.com/OchePrince/Electronic_gadget/blob/main/gender%20preference.png)



  


  

  
  





   
  	
  
	


