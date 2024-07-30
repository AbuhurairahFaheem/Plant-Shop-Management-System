CREATE DATABASE `databaseproject` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

use databaseproject;

CREATE TABLE user (
    UserID VARCHAR(20) PRIMARY KEY NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Contact VARCHAR(15) NOT NULL,
    Role ENUM('customer', 'admin', 'seller', 'courier') NOT NULL
);

CREATE TABLE customer (
    UserID VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (UserID) REFERENCES user(UserID),
    Username VARCHAR(50),
    FOREIGN KEY (Username) REFERENCES user(Username),
    Name VARCHAR(50) NOT NULL,
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Location VARCHAR(100)
);

CREATE TABLE courier (
    UserID VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (UserID) REFERENCES user(UserID),
    Username VARCHAR(50),
    FOREIGN KEY (Username) REFERENCES user(Username),
    Name VARCHAR(50) NOT NULL,
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Location VARCHAR(100)
);

CREATE TABLE admin (
    UserID VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (UserID) REFERENCES user(UserID),
    Username VARCHAR(50),
    FOREIGN KEY (Username) REFERENCES user(Username),
    Name VARCHAR(50) NOT NULL,
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Location VARCHAR(100)
);

CREATE TABLE seller (
    UserID VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (UserID) REFERENCES user(UserID),
    Username VARCHAR(50),
    FOREIGN KEY (Username) REFERENCES user(Username),
    Name VARCHAR(50) NOT NULL,
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Location VARCHAR(100)
);

CREATE TABLE category (
    Cat_ID INT PRIMARY KEY AUTO_INCREMENT,
    AdminID VARCHAR(20),
    FOREIGN KEY (AdminID) REFERENCES admin(UserID),
    Name VARCHAR(50) NOT NULL,
    Season VARCHAR(20),
    NoOfProducts INT,
    Description TEXT
);

CREATE TABLE product (
    ProductID VARCHAR(20) PRIMARY KEY,
    Cat_ID INT,
    FOREIGN KEY (Cat_ID) REFERENCES category(Cat_ID),
    SellerID VARCHAR(20),
    FOREIGN KEY (SellerID) REFERENCES seller(UserID),
    PName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2),
    Size VARCHAR(20),
    Description TEXT,
    Image VARCHAR(255)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID VARCHAR(20),
    OrderDate DATE NOT NULL,
    PaymentID INT Not null,
    TrackingID INT Not null,
    FOREIGN KEY (CustomerID) REFERENCES Customer(UserID)
);

CREATE TABLE order_product (
    OrderID INT,
    ProductID VARCHAR(20),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE TrackingDetails (
    TrackingID INT PRIMARY KEY,
    OrderID INT not null,
    CourierID VARCHAR(20) not null,
    DeliveryStatus ENUM('In Transit', 'Out for Delivery', 'Delivered') NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CourierID) REFERENCES Courier(UserID),
    FOREIGN KEY (TrackingID) REFERENCES Orders(TrackingID)
);

ALTER TABLE TrackingDetails
ADD COLUMN TrackingNumber VARCHAR(50) NOT NULL AFTER CourierID;

describe TrackingDetails;


ALTER TABLE Orders
ADD CONSTRAINT TrackingID UNIQUE (TrackingID);

CREATE TABLE PaymentDetails (
    PaymentID INT PRIMARY KEY,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod ENUM('Credit Card', 'Debit Card', 'PayPal', 'Cash') NOT NULL,
    PaymentStatus ENUM('Paid','Unpaid','Pending') NOT NULL,
    PaymentDate DATE NOT NULL,
    FOREIGN KEY (PaymentID) REFERENCES Orders(PaymentID)
);

INSERT INTO user (UserID, Username, Password, Email, Contact, Role) VALUES
('1', 'john_doe', 'password1', 'john.doe@example.com', '1234567890', 'admin'),
('2', 'jane_smith', 'password2', 'jane.smith@example.com', '9876543210', 'admin'),
('3', 'mike_taylor', 'password3', 'mike.taylor@example.com', '6549873210', 'admin'),
('4', 'kevin_wilson', 'password4', 'kevin.wilson@example.com', '6543217890', 'admin'),
('5', 'amanda_hill', 'password5', 'amanda.hill@example.com', '1597534680', 'admin'),
('6', 'jacob_robinson', 'password6', 'jacob.robinson@example.com', '1473692580', 'admin'),
('7', 'ryan_wright', 'password7', 'ryan.wright@example.com', '6543219870', 'admin'),
('8', 'ethan_baker', 'password8', 'ethan.baker@example.com', '3579512468', 'admin'),
('9', 'jackson_cook', 'password9', 'jackson.cook@example.com', '9876543210', 'admin'),
('10', 'sebastian_diaz', 'password10', 'sebastian.diaz@example.com', '9876541230', 'admin');

INSERT INTO user (UserID, Username, Password, Email, Contact, Role) VALUES
('11', 'sara_white', 'password11', 'sara.white@example.com', '3216549870', 'customer'),
('12', 'lisa_miller', 'password12', 'lisa.miller@example.com', '4567893210', 'customer'),
('13', 'olivia_lee', 'password13', 'olivia.lee@example.com', '2587413690', 'customer'),
('14', 'ella_adams', 'password14', 'ella.adams@example.com', '3219876540', 'customer'),
('15', 'hailey_hall', 'password15', 'hailey.hall@example.com', '4563219870', 'customer'),
('16', 'natalie_young', 'password16', 'natalie.young@example.com', '9876541230', 'customer'),
('17', 'mia_king', 'password17', 'mia.king@example.com', '1596324780', 'customer'),
('18', 'victoria_kelly', 'password18', 'victoria.kelly@example.com', '3219876540', 'customer'),
('19', 'brooklyn_cox', 'password19', 'brooklyn.cox@example.com', '4569873210', 'customer'),
('20', 'aubrey_bailey', 'password20', 'aubrey.bailey@example.com', '1234567890', 'customer');

INSERT INTO user (UserID, Username, Password, Email, Contact, Role) VALUES
('21', 'alice_jone', 'password21', 'alice.jone@example.com', '4561237890', 'seller'),
('22', 'emily_davis', 'password22', 'emily.davis@example.com', '7893216540', 'seller'),
('23', 'andrew_scot', 'password23', 'andrew.scot@example.com', '3216549870', 'seller'),
('24', 'grace_morgan', 'password24', 'grace.morgan@example.com', '9873216540', 'seller'),
('25', 'chloe_scott', 'password25', 'chloe.scott@example.com', '7896541230', 'seller'),
('26', 'hannah_russell', 'password26', 'hannah.russell@example.com', '6543217890', 'seller'),
('27', 'zoe_gonzalez', 'password27', 'zoe.gonzalez@example.com', '8529631470', 'seller'),
('28', 'sara_whit', 'password28', 'sara.whit@example.com', '3216549870', 'seller'),
('29', 'natali_young', 'password29', 'natali.young@example.com', '9876541230', 'seller'),
('30', 'ela_adams', 'password30', 'ela.adams@example.com', '3219876540', 'seller');

INSERT INTO user (UserID, Username, Password, Email, Contact, Role) VALUES
('31', 'bob_brown', 'password31', 'bob.brown@example.com', '7894561230', 'courier'),
('32', 'peter_carter', 'password32', 'peter.carter@example.com', '3692581470', 'courier'),
('33', 'samuel_hall', 'password33', 'samuel.hall@example.com', '1236547890', 'courier'),
('34', 'brayden_ortiz', 'password34', 'brayden.ortiz@example.com', '3216549870', 'courier'),
('35', 'logan_ward', 'password35', 'logan.ward@example.com', '4561237890', 'courier'),
('36', 'sebastian_dia', 'password36', 'sebastian.dia@example.com', '9876541230', 'courier'),
('37', 'nathan_wood', 'password37', 'nathan.wood@example.com', '1237896540', 'courier'),
('38', 'gabriel_nelson', 'password38', 'gabriel.nelson@example.com', '7896543210', 'courier'),
('39', 'andrew_scott', 'password39', 'andrew.scott@example.com', '3216549870', 'courier'),
('40', 'luke_roberts', 'password40', 'luke.roberts@example.com', '7891236540', 'courier');

INSERT INTO customer (UserID, Username, Name, DOB, Gender, Location)
VALUES
('11', 'sara_white', 'Sara White', '1990-05-15', 'Female', 'New York'),
('12', 'lisa_miller', 'Lisa Miller', '1985-12-10', 'Female', 'Los Angeles'),
('13', 'olivia_lee', 'Olivia Lee', '1992-07-25', 'Female', 'Chicago'),
('14', 'ella_adams', 'Ella Adams', '1988-03-30', 'Female', 'Houston'),
('15', 'hailey_hall', 'Hailey Hall', '1995-09-05', 'Female', 'Miami'),
('16', 'natalie_young', 'Natalie Young', '1998-01-20', 'Female', 'San Francisco'),
('17', 'mia_king', 'Mia King', '1993-11-18', 'Female', 'Seattle'),
('18', 'victoria_kelly', 'Victoria Kelly', '1987-06-12', 'Female', 'Boston'),
('19', 'brooklyn_cox', 'Brooklyn Cox', '1991-04-22', 'Female', 'Denver'),
('20', 'aubrey_bailey', 'Aubrey Bailey', '1989-08-08', 'Female', 'Atlanta');

INSERT INTO courier (UserID, Username, Name, DOB, Gender, Location)
VALUES
('31', 'bob_brown', 'Bob Brown', '1987-08-25', 'Male', 'New York'),
('32', 'peter_carter', 'Peter Carter', '1990-02-15', 'Male', 'Los Angeles'),
('33', 'samuel_hall', 'Samuel Hall', '1985-11-30', 'Male', 'Chicago'),
('34', 'brayden_ortiz', 'Brayden Ortiz', '1992-07-10', 'Male', 'Houston'),
('35', 'logan_ward', 'Logan Ward', '1996-04-05', 'Male', 'Miami'),
('36', 'sebastian_diaz', 'Sebastian Diaz', '1999-10-20', 'Male', 'San Francisco'),
('37', 'nathan_wood', 'Nathan Wood', '1993-06-18', 'Male', 'Seattle'),
('38', 'gabriel_nelson', 'Gabriel Nelson', '1988-01-12', 'Male', 'Boston'),
('39', 'andrew_scott', 'Andrew Scott', '1991-09-22', 'Male', 'Denver'),
('40', 'luke_roberts', 'Luke Roberts', '1989-05-08', 'Male', 'Atlanta');

INSERT INTO admin (UserID, Username, Name, DOB, Gender, Location)
VALUES
('1', 'john_doe', 'John Doe', '1980-05-15', 'Male', 'New York'),
('2', 'jane_smith', 'Jane Smith', '1975-12-10', 'Female', 'Los Angeles'),
('3', 'mike_taylor', 'Mike Taylor', '1988-08-20', 'Male', 'Chicago'),
('4', 'kevin_wilson', 'Kevin Wilson', '1992-03-25', 'Male', 'Houston'),
('5', 'amanda_hill', 'Amanda Hill', '1985-11-05', 'Female', 'Miami'),
('6', 'jacob_robinson', 'Jacob Robinson', '1990-02-28', 'Male', 'San Francisco'),
('7', 'ryan_wright', 'Ryan Wright', '1987-06-15', 'Male', 'Seattle'),
('8', 'ethan_baker', 'Ethan Baker', '1983-09-30', 'Male', 'Boston'),
('9', 'jackson_cook', 'Jackson Cook', '1986-12-18', 'Male', 'Denver'),
('10', 'sebastian_diaz', 'Sebastian Diaz', '1995-07-10', 'Male', 'Atlanta');

INSERT INTO seller (UserID, Username, Name, DOB, Gender, Location)
VALUES
('21', 'alice_jone', 'Alice Jone', '1984-09-12', 'Female', 'New York'),
('22', 'emily_davis', 'Emily Davis', '1990-06-25', 'Female', 'Los Angeles'),
('23', 'andrew_scot', 'Andrew Scot', '1988-03-18', 'Male', 'Chicago'),
('24', 'grace_morgan', 'Grace Morgan', '1985-12-30', 'Female', 'Houston'),
('25', 'chloe_scott', 'Chloe Scott', '1993-08-05', 'Female', 'Miami'),
('26', 'hannah_russell', 'Hannah Russell', '1989-04-20', 'Female', 'San Francisco'),
('27', 'zoe_gonzalez', 'Zoe Gonzalez', '1986-11-15', 'Female', 'Seattle'),
('28', 'sara_whit', 'Sara Whit', '1991-02-28', 'Female', 'Boston'),
('29', 'natali_young', 'Natali Young', '1994-07-10', 'Female', 'Denver'),
('30', 'ela_adams', 'Ela Adams', '1992-10-15', 'Female', 'Atlanta');

INSERT INTO category (AdminID, Name, Season, NoOfProducts, Description)
VALUES
('1', 'Indoor Plants', 'All Seasons', 50, 'A variety of indoor plants suitable for home and office environments.'),
('1', 'Outdoor Plants', 'All Seasons', 70, 'A collection of outdoor plants for gardens, balconies, and outdoor spaces.'),
('1', 'Flowering Plants', 'Spring Seasons', 30, 'Beautiful flowering plants to add color and fragrance to your surroundings.'),
('5', 'Cacti', 'Fall Seasons', 20, 'Low-maintenance cacti and succulents, perfect for beginners.'),
('5', 'Herbs', 'All Seasons', 15, 'A selection of herbs for culinary and medicinal purposes.'),
('1', 'Fruit Trees', 'Summer Seasons', 10, 'Fruit-bearing trees suitable for home gardens and orchards.'),
('7', 'Shrubs', 'All Seasons', 25, 'Ornamental shrubs to enhance the beauty of your garden.'),
('7', 'Bamboo Plants', 'All Seasons', 5, 'Lucky bamboo and other bamboo varieties for a touch of elegance.'),
('7', 'Aquatic Plants', 'Winter Seasons', 8, 'Aquatic plants for ponds, water gardens, and aquariums.'),
('3', 'Air Purifying Plants', 'Summer Seasons', 12, 'Plants known for their air-purifying properties, ideal for improving indoor air quality.');

INSERT INTO product (ProductID, Cat_ID, SellerID, PName, Price, Size, Description, Image)
VALUES
('101', 6, '21', 'Fig', 49.99, 'Medium', 'A popular indoor plant with large, fiddle-shaped leaves.', 'fiddle_leaf_fig.jpg'),
('102', 6, '21', 'Berry', 59.99, 'Large', 'A tropical plant known for its unique, split leaves.', 'monstera_deliciosa.jpg'),
('103', 4, '22', 'Hydrangea', 29.99, 'Small', 'A beautiful flowering shrub with large, colorful blooms.', 'hydrangea.jpg'),
('104', 3, '22', 'Lavender', 19.99, 'Small', 'A fragrant herb with purple flowers, often used for its calming properties.', 'lavender.jpg'),
('105', 3, '23', 'Orchid', 39.99, 'Small', 'An elegant flowering plant known for its beauty and variety of colors.', 'orchid.jpg'),
('106', 3, '23', 'Roses', 24.99, 'Medium', 'Classic flowers that are perfect for gifting and adding a romantic touch.', 'roses.jpg'),
('107', 4, '27', 'Aloe Vera', 14.99, 'Small', 'A succulent plant with medicinal properties, known for its soothing gel.', 'aloe_vera.jpg'),
('108', 4, '24', 'Echeveria', 9.99, 'Small', 'A popular succulent with rosette-shaped leaves, easy to care for.', 'echeveria.jpg'),
('109', 5, '25', 'Basil', 5.99, 'Small', 'A versatile herb used in cooking, known for its fresh aroma and flavor.', 'basil.jpg'),
('110', 5, '30', 'Mint', 4.99, 'Small', 'A refreshing herb used in beverages and cooking, with a cooling effect.', 'mint.jpg');

INSERT INTO Orders (CustomerID, OrderDate, PaymentID, TrackingID)
VALUES
('11', '2024-05-01', 1, 101),
('11', '2024-05-02', 2, 102),
('13', '2024-05-03', 3, 103),
('11', '2024-05-04', 4, 104),
('15', '2024-05-05', 5, 105),
('17', '2024-05-06', 6, 106),
('17', '2024-05-07', 7, 107),
('19', '2024-05-08', 8, 108),
('19', '2024-05-09', 9, 109),
('20', '2024-05-10', 10, 110);

INSERT INTO order_product (OrderID, ProductID)
VALUES
(1, '101'),
(1, '102'),
(2, '103'),
(2, '104'),
(3, '105'),
(3, '106'),
(4, '105'),
(4, '101'),
(5, '109'),
(5, '102'),
(6, '103'),
(7, '102'),
(8, '109'),
(9, '105'),
(10, '103');

INSERT INTO TrackingDetails (TrackingID, OrderID, CourierID, DeliveryStatus, TrackingNumber)
VALUES
(101, 1, '31', 'In Transit', 'TN123456'),
(102, 2, '32', 'Out for Delivery', 'TN234567'),
(103, 3, '33', 'Delivered', 'TN345678'),
(104, 4, '34', 'In Transit', 'TN456789'),
(105, 5, '35', 'Out for Delivery', 'TN567890'),
(106, 6, '36', 'Delivered', 'TN678901'),
(107, 7, '37', 'In Transit', 'TN789012'),
(108, 8, '38', 'Out for Delivery', 'TN890123'),
(109, 9, '39', 'Delivered', 'TN901234'),
(110, 10, '40', 'In Transit', 'TN012345');

INSERT INTO PaymentDetails (PaymentID, Amount, PaymentMethod, PaymentStatus, PaymentDate) 
VALUES 
(1, 100.00, 'Credit Card', 'Paid', '2024-05-01'), 
(2, 150.00, 'Debit Card', 'Paid', '2024-05-02'), 
(3, 75.00, 'PayPal', 'Unpaid', '2024-05-03'), 
(4, 200.00, 'Cash', 'Paid', '2024-05-04'), 
(5, 120.00, 'Credit Card', 'Unpaid', '2024-05-05'), 
(6, 80.00, 'Debit Card', 'Pending', '2024-05-06'), 
(7, 90.00, 'PayPal', 'Paid', '2024-05-07'), 
(8, 110.00, 'Cash', 'Pending', '2024-05-08'), 
(9, 95.00, 'Credit Card', 'Unpaid', '2024-05-09'), 
(10, 130.00, 'Debit Card', 'Paid', '2024-05-10');
 select * from Orders;
 select * from category;

/* 1 to retrieve all orders information, where payment status is paid*/
SELECT Orders.OrderID, customer.Name AS CustomerName, Orders.OrderDate,
    SUM(PaymentDetails.Amount) AS TotalAmount, PaymentDetails.PaymentStatus
FROM Orders
JOIN PaymentDetails ON Orders.PaymentID = PaymentDetails.PaymentID
JOIN customer ON Orders.CustomerID = customer.UserID
WHERE PaymentDetails.PaymentStatus = 'Paid'
GROUP BY Orders.OrderID, customer.Name, Orders.OrderDate;

/* 2 to retrieve information of how much products are ordered yet*/
SELECT Orders.OrderID, product.PName AS ProductName,
    (SELECT COUNT(*) FROM order_product WHERE OrderID = Orders.OrderID) AS QuantityOrdered,
    (SELECT SUM(product.Price) FROM order_product
        JOIN product ON order_product.ProductID = product.ProductID
        WHERE order_product.OrderID = Orders.OrderID) AS TotalPrice
FROM Orders
JOIN order_product ON Orders.OrderID = order_product.OrderID
JOIN product ON order_product.ProductID = product.ProductID;

select* from seller;

/* 3 List all sellers with their products and corresponding categories:*/
SELECT 
    s.Name AS SellerName, 
    p.PName AS Product, 
    c.Name AS Category 
FROM 
    seller s 
JOIN 
    product p ON s.UserID = p.SellerID 
JOIN 
    category c ON p.Cat_ID = c.Cat_ID;
    
/* 4 Retrieve orders along with customer details and tracking information*/
SELECT 
    o.OrderID, 
    c.Name AS CustomerName, 
    o.OrderDate, 
    td.DeliveryStatus, 
    td.TrackingNumber 
FROM 
    Orders o 
JOIN 
    customer c ON o.CustomerID = c.UserID 
JOIN 
    TrackingDetails td ON o.TrackingID = td.TrackingID;

/* 5 Get product details along with their categories and descriptions*/
SELECT 
    p.PName AS ProductName, 
    c.Name AS Category, 
    p.Description AS ProductDescription, 
    c.Description AS CategoryDescription 
FROM 
    product p 
JOIN 
    category c ON p.Cat_ID = c.Cat_ID;

/* 6 retrieve seller name with total amount of his products sold as total revenue*/
SELECT seller.Name AS SellerName,
    SUM((SELECT SUM(product.Price) FROM order_product
        JOIN product ON order_product.ProductID = product.ProductID
        WHERE product.SellerID = seller.UserID)) AS TotalRevenue
FROM seller
GROUP BY seller.Name;

/* 7 Retrieve Orders with OrderID, Customer Name, and Days Since Order Date using Date Function*/
SELECT Orders.OrderID, customer.Name AS CustomerName,
    DATEDIFF(NOW(), Orders.OrderDate) AS DaysSinceOrder
FROM Orders
JOIN customer ON Orders.CustomerID = customer.UserID;

/* 8 retrieve order details along with courier details*/
SELECT 
    o.OrderID,
    td.TrackingID,
    td.DeliveryStatus,
    td.TrackingNumber,
    cu.Name AS CourierName,
    u.Contact AS CourierContact,
    cu.Location AS CourierLocation
FROM Orders o
JOIN TrackingDetails td ON o.TrackingID = td.TrackingID
JOIN courier cu ON td.CourierID = cu.UserID
JOIN user u ON cu.UserID = u.UserID;

/* 9 get order and product details */
SELECT o.OrderID, cu.Name AS CustomerName,p.PName AS ProductName, p.Price AS UnitPrice, p.Size AS ProductSize 
FROM Orders o
JOIN order_product op ON o.OrderID = op.OrderID
JOIN product p ON op.ProductID = p.ProductID
JOIN customer cu ON o.CustomerID = cu.UserID;
    
/*10 get payment details of order*/
SELECT 
    o.OrderID,
    pd.Amount AS TotalAmount,
    pd.PaymentStatus,
    pd.PaymentMethod
FROM Orders o
JOIN PaymentDetails pd ON o.PaymentID = pd.PaymentID;
    
/* 11 retrieve product with max price and product with min price */
SELECT 
    CONCAT('Price ($', MAX(p.Price), '): ', MAX(p.PName)) AS MaxPriceProduct,
    CONCAT('Price ($', MIN(p.Price), '): ', MIN(p.PName)) AS MinPriceProduct,
    CONCAT('Price ($', (SELECT MAX(Price) FROM product WHERE Price < (SELECT MAX(Price) FROM product)), '): ', 
        (SELECT PName FROM product WHERE Price = (SELECT MAX(Price) FROM product WHERE Price < (SELECT MAX(Price) FROM product)))) AS SecondMaxPriceProduct
FROM product p;

/* 12 Showing info using left joins */
SELECT 
    CONCAT('Order ID: ', o.OrderID) AS OrderInfo,
    CONCAT('Customer: ', cu.Name) AS CustomerInfo,
    CONCAT('Product: ', p.PName) AS ProductInfo,
    CONCAT('Price: $', p.Price) AS PriceInfo
FROM 
    Orders o
LEFT JOIN 
    order_product op ON o.OrderID = op.OrderID
LEFT JOIN 
    product p ON op.ProductID = p.ProductID
LEFT JOIN 
    customer cu ON o.CustomerID = cu.UserID;
    
/* 13 Active Couriers with Delivery Status*/
SELECT co.Name AS CourierName, td.DeliveryStatus, td.TrackingNumber, cu.Location AS DeliveryLocation
FROM courier co
LEFT JOIN TrackingDetails td ON co.UserID = td.CourierID
LEFT JOIN Orders o ON td.OrderID = o.OrderID
LEFT JOIN customer cu ON o.CustomerID = cu.UserID
WHERE td.DeliveryStatus = 'In Transit' OR td.DeliveryStatus = 'Out for Delivery';

/* 14 names containg 'A' */
SELECT Name as 'Names '
FROM customer
WHERE Name LIKE '%A%';

/* 15  Products having price greater than average price */
SELECT 
    product.PName AS ProductName,
    product.Price AS ProductPrice,
    category.Name AS CategoryName,
    product.Size AS ProductSize
FROM product JOIN category ON product.Cat_ID = category.Cat_ID
WHERE product.Price > (SELECT AVG(Price) FROM product)
ORDER BY product.Price DESC;

UPDATE Product SET Price = 25.00 WHERE ProductID = '101';
select * from product;





UPDATE TrackingDetails SET DeliveryStatus = 'Delivered' WHERE CourierID = 32;
select * from TrackingDetails;

UPDATE PaymentDetails SET PaymentStatus = 'Paid' WHERE PaymentDate = '2024-05-03' AND PaymentStatus = 'Unpaid';
select * from PaymentDetails;


UPDATE courier SET Location = 'Berlin' WHERE UserID = 32;
select * from courier;

UPDATE category SET NoOfProducts = 30 Where Name = 'Cacti';
select * from category;

UPDATE orders SET OrderDate = '2012-12-12' Where CustomerID = 15 ;
select * from orders;


UPDATE seller SET Location = 'Berlin' WHERE Username = 'alice_jone';
select * from seller;


UPDATE customer SET Name = 'Natalie Youngest' WHERE Username = 'natalie_young';
select * from customer;

UPDATE admin SET DOB = '2012-12-12' WHERE UserID = 1;
select * from admin;

UPDATE user SET Password = '123456' WHERE UserID = 1;
select * from user;

DELETE FROM Product WHERE ProductID = '110';
select * from product;

DELETE FROM TrackingDetails WHERE TrackingNumber = 'TN123456';
select * from TrackingDetails;

DELETE FROM category WHERE AdminID = 3;
select * from category;

DELETE FROM order_product WHERE OrderID = 1 AND ProductID = 102;
select * from product;

DELETE FROM Orders WHERE PaymentID IN (SELECT PaymentID FROM PaymentDetails WHERE PaymentStatus = 'Unpaid');

DElETE FROM PaymentDetails WHERE PaymentDate = '2024-05-03';
select * from PaymentDetails;

DELETE FROM Product WHERE ProductID = '107';
select * from product;

DELETE FROM TrackingDetails WHERE OrderID= 2;
select * from TrackingDetails;

DELETE FROM category WHERE NoOfProducts <= 5;
select * from category;

DElETE FROM PaymentDetails WHERE PaymentMethod = 'Credit Card' AND PaymentDate = '2024-05-09';
select * from PaymentDetails;

DELETE FROM order_product WHERE ProductID = 104;

DELETE FROM order_product WHERE ProductID IN (SELECT ProductID FROM product WHERE Cat_ID IN (SELECT Cat_ID FROM category WHERE NoOfProducts < 10));
select * from order_product;



