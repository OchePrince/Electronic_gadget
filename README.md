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

##### Product Preference by Gender
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

- **Key Findings**: The analysis indicates a relatively balanced distribution between male and female customers. However, the data  shows that males have strong preference for all the product type compared to  females. This gender-based insight can inform targeted advertising campaigns and promotional strategies.

#### Average Total Sales by Loyalty Members
- **SQL CODE**:
  ```SQL
	SELECT 
		LoyaltyMember,
		AVG(Total_Sales) AS 'Avg Total Sales'
	FROM sales
	WHERE LoyaltyMember IN ('Yes', 'No')
	GROUP BY LoyaltyMember
	ORDER BY 2 DESC;
- **Output**:

  ![loyaltymembers](https://github.com/OchePrince/Electronic_gadget/blob/main/loyaltymembers.png)

- **Key Findings**: The analysis of average total sales based on loyalty membership status provides surprising insights:
  1. **Higher Average Sales for Non-Members**: The data reveals that non-loyalty members have a slightly higher average total sales value of $3,254.20 compared to $3,199.75 for loyalty members. This indicates that, on average, non-members spend marginally more per purchase than loyalty members.
  2. **Spending Behavior Difference**: While loyalty programs are typically designed to encourage higher spending and repeated purchases, the data suggests that in this case, non-members may be making larger purchases when they shop. This could be due to infrequent but higher-value purchases among non-members, whereas loyalty members might make smaller, more frequent purchases.

**Implication**: Understanding customer demographics enables the business to create personalized marketing strategies, optimize product offerings, and enhance customer engagement. By identifying the primary age groups and gender preferences, the business can develop targeted promotions that resonate with the specific interests of these segments.

**Recommendations**: 
1. **Targeted Marketing Campaigns**: Develop campaigns specifically designed for high-purchasing age groups, such as the Adult and Old segments, leveraging platforms and messages that resonate with these demographics.
2. **Gender-Specific Promotions**: Tailor product promotions and advertisements based on gender preferences to increase conversion rates. Smartphones and Tablet are the top male and female preference.
3. **Targeted Promotions for Loyalty Members**: Consider introducing exclusive offers for loyalty members on high-value items or bundling options to encourage larger transactions.
4. **Non-Member Engagement**: Explore ways to convert high-spending non-members into loyalty program participants, as their higher average sales suggest they may be valuable long-term customers if incentivized to join.
5. **Program Enhancements**: Reevaluate the loyalty program structure to ensure it aligns with the spending habits and preferences of the current customer base, possibly offering tiered rewards for reaching higher spending thresholds.
    

  


  
