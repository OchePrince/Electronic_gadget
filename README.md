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

---
### Total Sales Impact of Order Status
**Objective**: To compare Total Sales from *Completed* vs *Cancelled Orders* and reasons for cancelled orders.

#### Overview of Order Status 
- **SQL CODE**:
  ```SQL
	SELECT 
		OrderStatus,
	    COUNT(*) AS 'Number of Orders'
	FROM
		Sales                                 
	GROUP BY 
		OrderStatus
	ORDER BY                       
		2 DESC;
- **Output**:

  ![orderstatus overview](https://github.com/OchePrince/Electronic_gadget/blob/main/orderstatus%20overview.png)

-**Key Findings**: 67% of the total orders were completed while 33% of the Total orders were cancelled.

#### Revenue Impact of Cancellation and Completed Orders
- **SQL CODE**:
  ```SQL
	SELECT 
		OrderStatus,
	    COUNT(*) AS total_orders,
	    SUM(Total_Sales) AS "Total Sales"
	FROM sales
	WHERE OrderStatus IN ("Completed", "Cancelled")
	GROUP BY OrderStatus;
- **Output**:

  ![orderstatus sales](https://github.com/OchePrince/Electronic_gadget/blob/main/orderstatus%20sales.png)

- **Key Findings**: $21,382,354.52 was loss due to cancelled orders and $43,465,210.81 was made from completed orders.

#### Effect of Product Type on Order Status
- **SQL CODE**:
  ```SQL
	SELECT Product_Type, 
	       COUNT(*) AS total_orders,
	       SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
	       (SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS cancellation_rate
	FROM sales
	GROUP BY Product_Type
	order by cancellation_rate desc;

- **Output**:

  ![product type on cancelled orders](https://github.com/OchePrince/Electronic_gadget/blob/main/product%20type%20on%20cancelled%20orders.png)

- **Key Findings**:
  1. **High Cancellation Rates Consistency**: The cancellation rates across all product types—Smartphones, Tablets, Laptops, Smartwatches, and Headphones—are quite similar, all around 32-33%. This consistency could indicate a systemic issue affecting all product categories, such as issues with the overall purchase experience, order processing, or shipping delays.
  2. **Smartphone and Tablet have the highest number of total orders and cancelled orders**: This suggest that high-demand product may experience higher-order volume, which could be leading to increased cancellations due to factors like stock shortages or fulfillment delays.
  3. **Potential for Product-Specific Improvement**: Although Headphones have the lowest cancellation count (650), their rate is still significant. Examining specific reasons for cancellations in this category might reveal opportunities to improve product appeal or resolve issues specific to the category, even if on a smaller scale.

- **Recommendations**:
   1. **Inventory Management**: Consider reinforcing stock for high-demand items like Smartphones and Tablets to minimize cancellations due to unavailability.
   2. **Order Fulfillment**: Streamlining the order and shipping process for these popular items could help reduce cancellations.

#### Effect of Shipping Type on Order Status
- **SQL CODE**:
  ```SQL
	SELECT Shipping_Type, 
	       COUNT(*) AS total_orders,
	       SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
	       (SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS cancellation_rate
	FROM sales
	GROUP BY Shipping_Type
	ORDER BY cancelled_orders DESC, cancellation_rate DESC;

- **Output**:

  ![Shipping type on order status](https://github.com/OchePrince/Electronic_gadget/blob/main/Shipping%20type%20on%20order%20status.png)

- **Key Findings**:
   1. **Consistent Cancellation Rates Across Shipping Options**: The cancellation rates for each shipping type—Standard, Expedited, Overnight, Same Day, and Express—are all close to the 32-34% range. This similarity suggests that cancellations are not strongly dependent on the shipping type alone, but could be influenced by other factors, such as product availability or customer expectations across the board.
   2. **Standard Shipping Has Highest Absolute Cancellations**: Although cancellation rates are similar, Standard Shipping has the highest number of canceled orders in absolute terms (2,164). This may indicate that customers who choose the more economical Standard Shipping option are also more likely to cancel, potentially due to longer delivery times or delayed fulfillment.

- **Recommendations**:
   1. **Focus on Standard Shipping Improvement**: Given the higher absolute cancellations for Standard Shipping, consider reviewing fulfillment timelines and communication for this option. Improving reliability for Standard Shipping can directly impact a significant portion of orders.
   2. **Refine Fast Shipping Experience**: For expedited options (Same Day and Express), ensure transparent communication about order processing times to set realistic expectations and reduce potential cancellations.
   3. **Customer Feedback Analysis by Shipping Type**: Analyzing customer feedback specific to each shipping method may reveal insights on factors leading to cancellations, especially for high-cancellation options like Standard and Same Day.
---

### Average Sales by Shipping Type
- **Objective**: The aim of this analysis is to determine which shipping types are associated with the highest average sales, as well as to understand if certain shipping options are linked to more canceled orders. This insight will help in identifying which shipping methods contribute most significantly to revenue.
- **SQL CODE**:
  ```SQL
	SELECT 
	    Shipping_Type,
	    AVG(Total_Sales) AS Avg_sales
	FROM 
	    sales
	WHERE OrderStatus = 'Completed'
	GROUP BY 
	    Shipping_Type
	ORDER BY Avg_sales DESC;

- **Output**:

  ![Shipping type sales](https://github.com/OchePrince/Electronic_gadget/blob/main/Shipping%20type%20sales.png)
 - **SQL CODE**:
   ```SQL
	SELECT 
		Shipping_Type, 
		OrderStatus,
		COUNT(*) AS total_orders
	FROM sales 
	WHERE OrderStatus IN ('Completed', 'Cancelled')
	GROUP BY Shipping_Type, OrderStatus
	ORDER BY total_orders DESC, Shipping_Type;

- **Output**:

  ![SHIPPING VS OS](https://github.com/OchePrince/Electronic_gadget/blob/main/SHIPPING%20VS%20OS.png)

- **Key Findings**:
   1. Expedited and Same Day Shipping type contribute the most to the revenue with each generating an average sale of $3,896.13 and $3872.69 respectively. This indicates that these shipping options are particularly favored by customers making higher-value purchases, suggesting a possible association between faster shipping options and larger orders.
   2. Standard and Overnight shipping types have the highest counts of both completed and canceled orders. While they are the most commonly used shipping options, they do not generate the highest average revenue compared to Expedited and Same Day options. This suggests that customers may choose Standard and Overnight shipping more often for smaller purchases or less time-sensitive orders.

- **Recommendations**:
  1. Expedited and Same Day shipping options could be promoted for high-value items, as they are associated with higher revenue per order.
  2. Improving efficiency in Standard and Overnight shipping types might help reduce cancellations, enhancing customer experience for commonly used, lower-cost shipping options.
  3. Analyzing customer preferences for these high-revenue shipping types can guide targeted promotions, particularly for customers inclined toward faster, higher-value purchases.
---

### Correlation Analysis of Payment Method and Order Status
- **Objective**: The aim is to explore any relationship between payment methods and the likelihood of order cancellations. By understanding if certain payment methods correspond with higher or lower cancellation rates, the business can make informed decisions to enhance payment processing or implement customer support initiatives around payment options.
- **SQL CODE**:
  ```SQL
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

- **Output**:

   ![Paymentmethod analysis](https://github.com/OchePrince/Electronic_gadget/blob/main/Paymentmethod%20analysis.png)

- **Key Findings**:
   1. Credit  Card and Paypal Payment method shows a higher cancellation rate with 33.6% and 33.4% respectively. This may indicate issues related to transaction approval, buyer’s remorse, or customer hesitation specific to these methods.
   2. Payment methods with lower cancellation rates, such as Cash or Debit Card, might be perceived as more secure or involve fewer complications, suggesting that these options could be emphasized in checkout processes to reduce cancellations.

- **Recommendation: This analysis is useful for optimizing payment processing and identifying if customer education or improvements in specific payment methods could reduce cancellations. For instance, if online payment methods show higher cancellations, additional resources like reminders about secure checkout, flexibility in payment, or incentives for using certain methods could improve completion rates.
---

### Seasonal Sales Trend
- **Objective**: To monitor monthly sales trends and pinpoint peak sales periods to inform marketing strategies and inventory planning.
- **SQL CODE**:
  ```SQL
	SELECT 
	    `Year`, 
	    `Month`,
	    SUM(Total_Sales) AS Total_Sales
	FROM sales
	GROUP BY `Year`, `Month`
	ORDER BY `Year`, Total_Sales DESC;

- **Output**:

  ![Sales Trend](https://github.com/OchePrince/Electronic_gadget/blob/main/Sales%20Trend.png)

- **Key Findings**:
   1. **Initial Surge in Sales (2023)**:
       1. Sales tracking began in September 2023 with an initial total of $489,974.41.
       2. October 2023 saw a substantial increase, reaching $2,356,303.47, marking the highest point in that year.
       3. Following this peak, sales gradually declined, with $2,014,209.48 recorded by the year's end.
   2. **Fluctuating Sales Patterns in 2024**:
       1. January 2024 opened with strong sales, totaling $6,756,367.63, the highest monthly amount observed.
       2. Sales fluctuated through the year, with a notable drop to $5,137,210.01 in September 2024, the lowest monthly total recorded in 2024.
- **Insights**: These trends suggest seasonal peaks, with strong performances early in the year and dips in mid-to-late 2024. This information can be valuable for planning promotions and inventory adjustments to capitalize on high-demand periods and address slower months.

- **Recommendations**:
   1. **Increase Marketing Efforts**: Boost promotional activities in months preceding peak periods to maximize sales during high-demand times.
   2. **Inventory Planning**: Adjust inventory to match anticipated demand fluctuations, particularly preparing for lower sales in the late third quarter.
---

### Impact of Addons Purchase on Total Sales
- **Objective**: Assess how add-ons contribute to total sales and determine if they significantly boost revenue.
- **SQL CODE**:
  ```SQL
	SELECT 
	    CASE 
	        WHEN Addons_Purchased IS NOT NULL AND Addons_Purchased != '' THEN 'With Add-ons'
	        ELSE 'Without Add-ons'
	    END AS Addon_Status,
	    AVG(Total_Sales) AS avg_total_sales
	FROM 
	    sales
	WHERE 
	    OrderStatus = 'Completed'
	GROUP BY 
	    Addon_Status;
  

  

  
  

  



  



