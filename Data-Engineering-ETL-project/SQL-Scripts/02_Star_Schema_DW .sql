USE Ecommerce_DW;
GO

-- 1. DimDate 
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    Month INT NOT NULL,
    MonthName VARCHAR(20) NOT NULL,
    DayOfMonth INT NOT NULL,
    DayOfWeek INT NOT NULL,
    DayName VARCHAR(20) NOT NULL,
    IsWeekend BIT NOT NULL
);
GO

-- 2. DimUser 
CREATE TABLE DimUser (
    UserSK INT IDENTITY(1,1) PRIMARY KEY, 
    user_id VARCHAR(50) NOT NULL,         
    name VARCHAR(255),
    gender VARCHAR(50),
    city VARCHAR(100),
    signup_date DATETIME
);
GO

-- 3. DimProduct (Slowly Changing Dimension - SCD Type 2 )
CREATE TABLE DimProduct (
    ProductSK INT IDENTITY(1,1) PRIMARY KEY,
    product_id VARCHAR(50) NOT NULL,
    product_name VARCHAR(255),
    category VARCHAR(100),
    brand VARCHAR(100),
    price FLOAT,
    -- SCD Type 2 Fields 
    StartDate DATETIME,
    EndDate DATETIME,
    IsActive BIT 
);
GO

-- 4. DimOrderStatus (Status )
CREATE TABLE DimOrderStatus (
    StatusSK INT IDENTITY(1,1) PRIMARY KEY,
    order_status VARCHAR(50) NOT NULL 
);
GO

-- 5. FactOrders (Fact Table)
CREATE TABLE FactOrders (
    OrderSK INT IDENTITY(1,1) PRIMARY KEY,
    DateKey INT,            
    UserSK INT,             
    ProductSK INT,          
    StatusSK INT,           
    
    order_id VARCHAR(50),   
    
    -- Measures
    quantity INT,
    unit_price FLOAT,
    total_line_amount FLOAT,    
    
    -- Accumulating Fact Fields
    order_create_time DATETIME,
    order_complete_time DATETIME,
    order_process_time_hours INT,

    FOREIGN KEY (DateKey) REFERENCES DimDate(DateKey),
    FOREIGN KEY (UserSK) REFERENCES DimUser(UserSK),
    FOREIGN KEY (ProductSK) REFERENCES DimProduct(ProductSK),
    FOREIGN KEY (StatusSK) REFERENCES DimOrderStatus(StatusSK)
);
GO