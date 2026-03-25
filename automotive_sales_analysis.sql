-- ============================================
-- Automotive Market Sales Analysis
-- Dataset: 23,906 car sales transactions
-- Period: 2022 to 2023
-- Author: [Your Name]
-- ============================================


-- Query 1: Total units sold and revenue by brand
SELECT 
    Company,
    COUNT(*) AS units_sold,
    SUM(Price_USD) AS total_revenue,
    ROUND(AVG(Price_USD), 0) AS avg_price
FROM car_sales
GROUP BY Company
ORDER BY units_sold DESC;


-- Query 2: Top 5 best selling brands
SELECT 
    Company,
    COUNT(*) AS units_sold,
    SUM(Price_USD) AS total_revenue
FROM car_sales
GROUP BY Company
ORDER BY units_sold DESC
LIMIT 5;


-- Query 3: Year on year sales trend
SELECT 
    Year,
    COUNT(*) AS units_sold,
    SUM(Price_USD) AS total_revenue,
    ROUND(AVG(Price_USD), 0) AS avg_price
FROM car_sales
GROUP BY Year
ORDER BY Year ASC;


-- Query 4: YoY growth calculation
SELECT 
    Year,
    units_sold,
    units_sold - LAG(units_sold) OVER (ORDER BY Year) AS yoy_unit_change,
    ROUND((units_sold - LAG(units_sold) OVER (ORDER BY Year)) * 100.0 
        / LAG(units_sold) OVER (ORDER BY Year), 1) AS yoy_growth_pct
FROM (
    SELECT Year, COUNT(*) AS units_sold
    FROM car_sales
    GROUP BY Year
) yearly_data;


-- Query 5: Sales by body style
SELECT 
    Body_Style,
    COUNT(*) AS units_sold,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM car_sales), 1) AS pct_share,
    ROUND(AVG(Price_USD), 0) AS avg_price
FROM car_sales
GROUP BY Body_Style
ORDER BY units_sold DESC;


-- Query 6: Sales by region
SELECT 
    Dealer_Region,
    COUNT(*) AS units_sold,
    SUM(Price_USD) AS total_revenue,
    ROUND(AVG(Price_USD), 0) AS avg_price
FROM car_sales
GROUP BY Dealer_Region
ORDER BY units_sold DESC;


-- Query 7: Transmission mix
SELECT 
    Transmission,
    COUNT(*) AS units_sold,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM car_sales), 1) AS pct_share,
    ROUND(AVG(Price_USD), 0) AS avg_price
FROM car_sales
GROUP BY Transmission
ORDER BY units_sold DESC;


-- Query 8: Top 10 best selling models
SELECT 
    Company,
    Model,
    COUNT(*) AS units_sold,
    ROUND(AVG(Price_USD), 0) AS avg_price,
    SUM(Price_USD) AS total_revenue
FROM car_sales
GROUP BY Company, Model
ORDER BY units_sold DESC
LIMIT 10;


-- Query 9: Color preference analysis
SELECT 
    Color,
    COUNT(*) AS units_sold,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM car_sales), 1) AS pct_share
FROM car_sales
GROUP BY Color
ORDER BY units_sold DESC;


-- Query 10: Buyer gender split and spending
SELECT 
    Gender,
    COUNT(*) AS units_sold,
    ROUND(AVG(Price_USD), 0) AS avg_price,
    SUM(Price_USD) AS total_revenue
FROM car_sales
GROUP BY Gender;


-- Query 11: Engine type breakdown
SELECT 
    Engine,
    COUNT(*) AS units_sold,
    ROUND(AVG(Price_USD), 0) AS avg_price,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM car_sales), 1) AS pct_share
FROM car_sales
GROUP BY Engine
ORDER BY units_sold DESC;


-- Query 12: Top brand per region
SELECT 
    Dealer_Region,
    Company,
    COUNT(*) AS units_sold
FROM car_sales
GROUP BY Dealer_Region, Company
ORDER BY Dealer_Region, units_sold DESC;


-- Query 13: Monthly sales trend
SELECT 
    Year,
    Month,
    COUNT(*) AS units_sold,
    SUM(Price_USD) AS monthly_revenue
FROM car_sales
GROUP BY Year, Month
ORDER BY Year ASC, Month ASC;


-- Query 14: High value transactions above average price
SELECT 
    Company,
    Model,
    COUNT(*) AS units_sold,
    ROUND(AVG(Price_USD), 0) AS avg_price
FROM car_sales
WHERE Price_USD > (SELECT AVG(Price_USD) FROM car_sales)
GROUP BY Company, Model
ORDER BY units_sold DESC
LIMIT 10;


-- Query 15: Overall dataset summary
SELECT 
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT Company) AS total_brands,
    COUNT(DISTINCT Model) AS total_models,
    COUNT(DISTINCT Dealer_Region) AS total_regions,
    SUM(Price_USD) AS total_revenue,
    ROUND(AVG(Price_USD), 0) AS avg_transaction_price,
    MIN(Price_USD) AS min_price,
    MAX(Price_USD) AS max_price
FROM car_sales;
