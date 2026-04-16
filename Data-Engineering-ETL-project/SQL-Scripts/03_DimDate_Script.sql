SELECT MIN(FullDate), MAX(FullDate) FROM DimDate;

USE Ecommerce_DW;
TRUNCATE TABLE DimDate;

USE Ecommerce_DW;

-- 1. මුලින්ම FactOrders එක හිස් කරන්න (මොකද ඒක DimDate එකට සම්බන්ධ නිසා)
DELETE FROM FactOrders;

-- 2. දැන් DimDate එක හිස් කරන්න (දැන් මේකට අවසර ලැබෙනවා)
DELETE FROM DimDate;

DECLARE @StartDate DATE = '2023-01-01';
DECLARE @EndDate DATE = '2027-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DimDate (
        DateKey, FullDate, Year, Quarter, Month, MonthName, DayOfMonth, DayOfWeek, DayName, IsWeekend
    )
    SELECT 
        CAST(FORMAT(@StartDate, 'yyyyMMdd') AS INT),
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DAY(@StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate),
        CASE WHEN DATENAME(WEEKDAY, @StartDate) IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END;

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;

SELECT TOP 10 * FROM DimDate;

SELECT TOP 10 UserSK, ProductSK, StatusSK, total_line_amount 
FROM FactOrders;

-- Staging එකේ තියෙන පේළි ගණන
SELECT COUNT(*) AS Staging_Count FROM Ecommerce_Staging.dbo.STG_order_items;

-- Warehouse එකේ තියෙන පේළි ගණන
SELECT COUNT(*) AS Warehouse_Count FROM Ecommerce_DW.dbo.FactOrders;

SELECT * FROM FactOrders 
WHERE UserSK IS NULL OR ProductSK IS NULL OR StatusSK IS NULL;

SELECT product_id, COUNT(*) as VersionCount 
FROM DimProduct 
GROUP BY product_id 
HAVING COUNT(*) > 1;


SELECT * FROM FactOrders 
WHERE ABS(total_line_amount - (quantity * unit_price)) > 0.01;

SELECT d.Year, d.MonthName, SUM(f.total_line_amount) AS MonthlySales
FROM FactOrders f
JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.MonthName
ORDER BY d.Year, MIN(d.Month);

SELECT *
FROM FactOrders 