-- Question 1 answer
SELECT 
    OrderID,
    CustomerName,
    TRIM(Product) AS Product
FROM ProductDetail
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(Products, ',', '","'), '"]'),
    "$[*]" COLUMNS (Product VARCHAR(50) PATH "$")
) AS jt;

-- Question 2 answer

-- Create Orders table (OrderID → CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table (OrderID + Product → Quantity)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders (removing duplicates)
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Insert data into OrderItems
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
-- 