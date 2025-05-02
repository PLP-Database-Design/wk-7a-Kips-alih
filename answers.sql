-- Achieving 1NF
SELECT OrderID, CustomerName, TRIM(Products) AS Product
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');

--SQL Query to Achieve 2NF:
-- Step 1: Create the new table for Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Step 2: Insert unique orders with CustomerName
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

--Step 3: Create a table for OrderDetails
CREATE TABLE OrderDetails (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step4: Insert data into OrderDetails table without CustomerName
INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;