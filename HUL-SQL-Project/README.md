# HUL-SQL-Project
![hul](https://github.com/user-attachments/assets/7bf9454e-e480-4815-91db-0dadc81ebc91)

# 🧠 SQL Business Case Study — Data Analysis Project

### 📚 **Database Tables Used**

```
Customers
Financial_Performance
Inventory
Market_Data
Products
Sales
```

---

## 🧩 **1. Product Insights**

**Q1.** List all products launched after 2019 with their category and brand.

```sql
SELECT product_name, category, brand, launch_date 
FROM products 
WHERE launch_date > '2019-12-31'
ORDER BY launch_date DESC;
```

**Q2.** Find the count of products in each category.

```sql
SELECT category, COUNT(*) AS product_count
FROM products 
GROUP BY category 
ORDER BY product_count;
```

**Q3.** Which category has the highest average MRP?

```sql
SELECT category, AVG(mrp) AS avg_mrp
FROM products
GROUP BY category
ORDER BY avg_mrp DESC
LIMIT 1;
```

**Q4.** Find all products where MRP > ₹100 but belong to “Fabric Care” category.

```sql
SELECT *
FROM products 
WHERE mrp > 100 
  AND category = 'Fabric Care';
```

**Q5.** Retrieve products with missing inventory data.

```sql
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN inventory i ON p.product_id = i.product_id
WHERE i.product_id IS NULL;
```

---

## 💰 **2. Sales Performance**

**Q6.** Find top 5 products by total revenue.

```sql
SELECT *
FROM financial_performance
ORDER BY revenue DESC
LIMIT 5;
```

**Q7.** Calculate the average discount given per region.

```sql
SELECT region, ROUND(AVG(discount), 2) AS average_discount
FROM sales
GROUP BY region
ORDER BY average_discount DESC;
```

**Q8.** Identify products that sold more than 9,000 units overall.

```sql
SELECT p.product_name, SUM(s.quantity_sold) AS total_units
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.quantity_sold) > 9000
ORDER BY total_units DESC;
```

**Q9.** Find monthly revenue trends (grouped by year & month).

```sql
SELECT 
    YEAR(sales_date) AS year,
    MONTH(sales_date) AS month,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY YEAR(sales_date), MONTH(sales_date)
ORDER BY year, month;
```

---

## 👥 **3. Customer Analysis**

**Q10.** Count total customers by region and customer type.

```sql
SELECT region, customer_type, COUNT(*) AS total_customers
FROM customers
GROUP BY region, customer_type;
```

**Q11.** List top 3 cities with the most registered customers.

```sql
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC
LIMIT 3;
```

**Q12.** Find customers who made purchases in more than one region.

```sql
SELECT c.customer_name, COUNT(DISTINCT s.region) AS regions_bought
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT s.region) > 1;
```

**Q13.** Show customers who registered before 2020 but made purchases only after 2022.

```sql
SELECT DISTINCT c.customer_name
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE c.registration_date < '2020-01-01'
  AND s.sales_date > '2022-12-31';
```

---

## 📦 **4. Inventory Management**

**Q14.** Identify products where stock quantity is below reorder level.

```sql
SELECT p.product_name, i.stock_quantity, i.reorder_level
FROM inventory i
JOIN products p ON i.product_id = p.product_id
WHERE i.stock_quantity < i.reorder_level;
```

**Q15.** List total stock available per location.

```sql
SELECT location, SUM(stock_quantity) AS total_stock
FROM inventory
GROUP BY location;
```

**Q16.** Find the average reorder level for each product category.

```sql
SELECT p.category, ROUND(AVG(i.reorder_level), 2) AS avg_reorder_level
FROM inventory i
JOIN products p ON i.product_id = p.product_id
GROUP BY p.category;
```

**Q17.** Identify locations with zero stock of any product.

```sql
SELECT location, product_id
FROM inventory
WHERE stock_quantity = 0;
```

---

## 💹 **5. Financial Performance**

**Q18.** Calculate total profit per year across all products.

```sql
SELECT year, SUM(profit) AS total_profit
FROM financial_performance
GROUP BY year
ORDER BY year;
```

**Q19.** Find the profit margin (%) for each product.

```sql
SELECT p.product_name,
       ROUND((f.profit / f.revenue) * 100, 2) AS profit_margin
FROM financial_performance f
JOIN products p ON f.product_id = p.product_id
WHERE f.revenue > 0;
```

**Q20.** Identify the top-performing product each quarter based on profit.

```sql
SELECT year, quarter, product_id, MAX(profit) AS max_profit
FROM financial_performance
GROUP BY year, quarter;
```

**Q21.** Compare marketing spend vs revenue by quarter (ROI).

```sql
SELECT year, quarter,
       SUM(marketing_spend) AS total_spend,
       SUM(revenue) AS total_revenue,
       ROUND((SUM(revenue) / SUM(marketing_spend)), 2) AS ROI
FROM financial_performance
GROUP BY year, quarter;
```

---

## 🌍 **6. Market & Competition**

**Q22.** Which region has the highest market share in “Hair Care” category?

```sql
SELECT region, market_share
FROM market_data
WHERE product_category = 'Hair Care'
ORDER BY market_share DESC
LIMIT 1;
```

**Q23.** Find regions with growth rate above 5% and high competition level.

```sql
SELECT region, growth_rate, competition_level
FROM market_data
WHERE growth_rate > 5 
  AND competition_level = 'High';
```

**Q24.** Analyze whether higher population regions have higher market share.

```sql
SELECT region, population_million, market_share
FROM market_data
ORDER BY population_million DESC;
```

---

## 🏁 **Conclusion**

This SQL Business Analysis explores six key dimensions — **Products, Sales, Customers, Inventory, Finance, and Market Trends.**
By executing these 24 SQL queries, we can uncover hidden business insights such as:

* Top-performing products and regions
* Customer engagement trends
* Inventory efficiency
* Profitability and ROI performance

This project demonstrates how **structured SQL analysis** can transform raw data into **actionable business intelligence** for decision-making and future forecasting.

---




