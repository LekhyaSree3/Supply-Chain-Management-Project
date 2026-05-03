SELECT MAX(`Date`) AS Latest_Date
FROM f_sales;

-- MTD (Month-to-Date) --
SELECT
COUNT(`Order Number`) AS MTD_Sales
FROM f_sales
WHERE
YEAR(`Date`) = (
SELECT YEAR(MAX(`Date`)) FROM f_sales
)
AND MONTH(`Date`) = (
SELECT MONTH(MAX(`Date`)) FROM f_sales
);

-- QTD (Quarter-to-Date) --
SELECT
COUNT(`Order Number`) AS QTD_Sales
FROM f_sales
WHERE
YEAR(`Date`) = (
SELECT YEAR(MAX(`Date`)) FROM f_sales
)
AND QUARTER(`Date`) = (
SELECT QUARTER(MAX(`Date`)) FROM f_sales
);

-- YTD (Year-to-Date) --
SELECT
COUNT(`Order Number`) AS YTD_Sales
FROM f_sales
WHERE
YEAR(`Date`) = (
SELECT YEAR(MAX(`Date`)) FROM f_sales
);

-- product wise sales --
SELECT
`Product Name`,
SUM(`Price` * `Quantity on Hand`) AS Product_Wise_Sales
FROM f_inventory_adjusted
GROUP BY `Product Name`
ORDER BY Product_Wise_Sales DESC;

-- Daily Sales Trend --
SELECT
`Date`,
COUNT(`Order Number`) AS Daily_Sales
FROM f_sales
GROUP BY `Date`
ORDER BY `Date`;

-- State Wise Sales --
SELECT
c.`Cust State`,
COUNT(f.`Order Number`) AS State_Wise_Sales
FROM f_sales f
JOIN customer c
ON f.`Cust Key` = c.`Cust Key`
GROUP BY c.`Cust State`
ORDER BY State_Wise_Sales DESC;

-- Top 5 store wise sales --
SELECT
s.`Store Name`,
COUNT(f.`Order Number`) AS Store_Sales
FROM f_sales f
JOIN d_store s
ON f.`Store Key` = s.`Store Key`
GROUP BY s.`Store Name`
ORDER BY Store_Sales DESC
LIMIT 5;

-- Region Wise Sales --
SELECT
s.`Store Region`,
COUNT(f.`Order Number`) AS Region_Sales
FROM f_sales f
JOIN d_store s
ON f.`Store Key` = s.`Store Key`
GROUP BY s.`Store Region`
ORDER BY Region_Sales DESC;

-- Total Inventory--
SELECT
SUM(`Quantity on Hand`) AS Total_Inventory
FROM f_inventory_adjusted;

-- Inventory Value --
SELECT
SUM(`Price` * `Quantity on Hand`) AS Total_Inventory_Value
FROM f_inventory_adjusted;

-- Overstock / Understock / Out of Stock --
SELECT
`Product Name`,
`Quantity on Hand`,
CASE
WHEN `Quantity on Hand` = 0 THEN 'Out of Stock'
WHEN `Quantity on Hand` BETWEEN 1 AND 2 THEN 'Understock'
WHEN `Quantity on Hand` >= 3 THEN 'Overstock'
ELSE 'Normal Stock'
END AS Stock_Status
FROM f_inventory_adjusted
ORDER BY `Quantity on Hand`;


-- Purchase Method Wise Sales --
SELECT
`Purchase Method`,
COUNT(`Order Number`) AS Purchase_Method_Sales
FROM f_sales
GROUP BY `Purchase Method`
ORDER BY Purchase_Method_Sales DESC;




