USE Ecommerce_Staging;
GO

-- පරණ Table එක මකා දමන්න
IF OBJECT_ID('dbo.stg_order_items', 'U') IS NOT NULL
    DROP TABLE dbo.stg_order_items;
GO

-- අලුතින් Table එක සෑදීම (ID ඔක්කොම VARCHAR විදිහට)
CREATE TABLE dbo.stg_order_items (
    order_item_id VARCHAR(50),
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    user_id VARCHAR(50),
    quantity INT,
    item_price DECIMAL(18, 2),
    item_total DECIMAL(18, 2)
);
GO