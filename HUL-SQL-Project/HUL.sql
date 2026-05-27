create database HUL;
use HUL;

CREATE TABLE Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    Pack_Size VARCHAR(20),
    MRP DECIMAL(8,2),
    Price_Category VARCHAR(20),
    Launch_Date DATE
);

-- 2. SALES TABLE
CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Product_ID INT,
    Customer_ID INT,
    Region VARCHAR(30),
    Sales_Date DATE,
    Quantity_Sold INT,
    Revenue DECIMAL(12,2),
    Discount DECIMAL(8,2),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);


-- 3. CUSTOMERS TABLE
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Customer_Type VARCHAR(30),
    City VARCHAR(50),
    State VARCHAR(50),
    Region VARCHAR(30),
    Registration_Date DATE
);


-- 4. INVENTORY TABLE
CREATE TABLE Inventory (
    Product_ID INT,
    Location VARCHAR(50),
    Stock_Quantity INT,
    Reorder_Level INT,
    Last_Updated DATE,
    PRIMARY KEY (Product_ID, Location),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);


-- 5. FINANCIAL_PERFORMANCE TABLE
CREATE TABLE Financial_Performance (
    Year INT,
    Quarter INT,
    Product_ID INT,
    Revenue DECIMAL(15,2),
    Profit DECIMAL(15,2),
    Marketing_Spend DECIMAL(12,2),
    Manufacturing_Cost DECIMAL(12,2),
    PRIMARY KEY (Year, Quarter, Product_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);


-- 6. MARKET_DATA TABLE
CREATE TABLE Market_Data (
    Region VARCHAR(30),
    Product_Category VARCHAR(50),
    Market_Share DECIMAL(5,2),
    Competition_Level VARCHAR(20),
    Population_Million DECIMAL(8,2),
    Growth_Rate DECIMAL(5,2),
    PRIMARY KEY (Region, Product_Category)
);

select * from customers;
select * from sales;
select * from products;
select * from inventory;
select * from market_data;
select * from financial_performance;




