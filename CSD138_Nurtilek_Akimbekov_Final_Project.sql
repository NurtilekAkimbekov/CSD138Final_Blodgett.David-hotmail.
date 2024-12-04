/*
This sql file serves as the file for the submission for your team's Final Group Project

Change the name of this file to include
your team member names
Members: Nurtilek Akimbekov
*/
/*
Team Information:
1) PM: Nurtilek is listed here
2) Team Members:
   All my teammates helped on creating database during MidTermProject. But Final Project I improved myself

3) The PM submits the sql file
PM Nurtilek: created tables, created constrains, improved database.


Right below here, list your team's updated 
and best sql code for the midterm group project
i.e.
- creating the database
- creating tables
- creating constraints
insert statements
select statements to list what was inserted
in the tables
*/

-- Create Database:
DROP DATABASE IF EXISTS sporting_goods_store;
CREATE DATABASE sporting_goods_store;
USE sporting_goods_store;

-- Create Tables:
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL UNIQUE,
    contact_name VARCHAR(50) NOT NULL,
    contact_email VARCHAR(100) NOT NULL UNIQUE,
    phone_number CHAR(10) NOT NULL,
    address VARCHAR(150) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    supplier_id INT NOT NULL,
    CONSTRAINT FK_Products_Suppliers
      FOREIGN KEY (supplier_id)
      REFERENCES Suppliers (supplier_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number CHAR(10) NOT NULL,
    address VARCHAR(150) NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    shipping_address VARCHAR(150) NOT NULL,
    CONSTRAINT FK_Orders_Customers
      FOREIGN KEY (customer_id)
      REFERENCES Customers (customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Order_Items_Orders
      FOREIGN KEY (order_id)
      REFERENCES Orders (order_id),
    CONSTRAINT FK_Order_Items_Products
      FOREIGN KEY (product_id)
      REFERENCES Products (product_id)
);

-- Insert Sample Data:
INSERT INTO Customers (first_name, last_name, email, phone_number, address) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St, Springfield, IL'),
('Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Oak Rd, Chicago, IL'),
('Michael', 'Johnson', 'michael.johnson@example.com', '5551234567', '789 Pine Ave, Peoria, IL'),
('Emily', 'Davis', 'emily.davis@example.com', '4445556666', '101 Maple St, Naperville, IL'),
('David', 'Martinez', 'david.martinez@example.com', '6667778888', '202 Birch Ln, Joliet, IL'),
('Sarah', 'Garcia', 'sarah.garcia@example.com', '3334445555', '303 Cedar Blvd, Rockford, IL'),
('James', 'Rodriguez', 'james.rodriguez@example.com', '2223334444', '404 Elm St, Decatur, IL'),
('Olivia', 'Wilson', 'olivia.wilson@example.com', '1112223333', '505 Walnut St, Bloomington, IL'),
('William', 'Moore', 'william.moore@example.com', '7778889999', '606 Pine St, Champaign, IL'),
('Sophia', 'Taylor', 'sophia.taylor@example.com', '8889990000', '707 Ash Dr, Urbana, IL');

-- Insert Suppliers data first
INSERT INTO Suppliers (supplier_name, contact_name, contact_email, phone_number, address) 
VALUES
('Alice B.', 'Alicia Brown', 'alicia.brown@example.com', '1234567890', '100 Supply Rd, Chicago, IL'),
('Thomas M.', 'Thomas Muller', 'thomas.muller@example.com', '2345678901', '200 Supply Ave, Springfield, IL'),
('Charlie W.', 'Charlie White', 'charlie.white@example.com', '3456789012', '300 Supply St, Peoria, IL'),
('Daisy G.', 'Daisy Green', 'daisy.green@example.com', '4567890123', '400 Supply Blvd, Naperville, IL'),
('Mbappe S.', 'Mbappe Smith', 'mbappe.smith@example.com', '5678901234', '500 Supply Ln, Rockford, IL'),
('Fiona G.', 'Fiona Gray', 'fiona.gray@example.com', '6789012345', '600 Supply Dr, Joliet, IL'),
('George B.', 'George Brown', 'george.brown@example.com', '7890123456', '700 Supply Ct, Aurora, IL'),
('Hanna B.', 'Hannah Blue', 'hannah.blue@example.com', '8901234567', '800 Supply Pl, Elgin, IL'),
('Ian G.', 'Ian Gold', 'ian.gold@example.com', '9012345678', '900 Supply Rd, Waukegan, IL'),
('Jenna D.', 'Jenna Davis', 'jenna.davis@example.com', '0123456789', '1000 Supply Dr, Cicero, IL');

-- Now insert Products data
INSERT INTO Products (product_name, category, price, stock_quantity, supplier_id) 
VALUES
('Soccer Ball', 'Sports', 20.00, 50, 1),
('Basketball', 'Sports', 25.00, 30, 2),
('Tennis Racket', 'Sports', 50.00, 20, 3),
('Running Shoes', 'Footwear', 60.00, 15, 4),
('Yoga Mat', 'Fitness', 10.00, 40, 5),
('Cycling Helmet', 'Cycling', 45.00, 25, 6),
('Golf Club', 'Golf', 100.00, 10, 7),
('Dumbbell', 'Fitness', 30.00, 20, 8),
('Swim Cap', 'Swimming', 5.00, 60, 9),
('Baseball Bat', 'Sports', 15.00, 10, 10);

INSERT INTO Orders (customer_id, order_date, total_amount, status, shipping_address) VALUES
(1, '2024-11-01', 45.00, 'Shipped', '123 Main St, Springfield, IL'), -- John
(2, '2024-11-05', 60.00, 'Pending', '456 Oak Rd, Chicago, IL'), -- Jane
(3, '2024-10-29', 75.00, 'Delivered', '789 Pine Ave, Peoria, IL'), -- Michael
(4, '2024-11-07', 90.00, 'Processing', '101 Maple St, Naperville, IL'), -- Emily
(5, '2024-11-05', 35.00, 'Cancelled', '202 Birch Ln, Joliet, IL'), -- David
(6, '2024-11-06', 150.00, 'Shipped', '303 Cedar Blvd, Rockford, IL'), -- Sarah
(7, '2024-11-07', 80.00, 'Delivered', '404 Elm St, Decatur, IL'),  -- James
(8, '2024-10-31', 95.00, 'Pending', '505 Walnut St, Bloomington, IL'),-- Olivia
(9, '2024-11-02', 40.00, 'Delivered', '606 Pine St, Champaign, IL'), -- William
(10, '2024-11-05', 55.00, 'Shipped', '707 Ash Dr, Urbana, IL'); -- Sophia

INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 20.00),
(2, 3, 1, 50.00),
(3, 4, 1, 60.00),
(4, 5, 3, 10.00),
(5, 2, 1, 25.00),
(6, 6, 2, 45.00),
(7, 7, 1, 100.00),
(8, 8, 1, 30.00),
(9, 9, 2, 5.00),
(10, 10, 1, 15.00);

/*
Programming Problem - Indexes
*/

-- Create an Index:
CREATE INDEX idx_products_category ON Products (category);

/*
Programming Problem - Multi-table Query
*/

-- Example: Multi-table Query
SELECT p.product_name, c.first_name, o.order_date
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id;

/*
Programming Problem - Subquery
*/

-- Example: Subquery
SELECT product_name
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);

/*
Programming Problem - Updatable Single Table View
*/

-- Example: Creating an Updatable View
CREATE VIEW products_view AS
SELECT product_id, product_name, price
FROM Products;

-- Example of an update through a view
UPDATE products_view
SET price = 25.00
WHERE product_name = 'Soccer Ball';

/*
Programming Problem - Stored Procedure
*/

-- Example: Stored Procedure
DELIMITER //
CREATE PROCEDURE get_order_details(IN orderID INT)
BEGIN
    SELECT * FROM Orders WHERE order_id = orderID;
    SELECT * FROM Order_Items WHERE order_id = orderID;
END //
DELIMITER ;

/*
Programming Problem - Stored Function
*/

-- Example: Stored Function
DELIMITER //
CREATE FUNCTION total_order_amount(orderID INT)  
RETURNS DECIMAL(10,2) 
DETERMINISTIC 
READS SQL DATA
BEGIN     
    DECLARE total DECIMAL(10,2);     
    SELECT SUM(price * quantity) INTO total     
    FROM Order_Items     
    WHERE order_id = orderID;     
    RETURN total; 
END;

DELIMITER ;
