# 🍀 Plant-Shop-Management-System

Welcome to the **PlantShop Management System**! This project offers a comprehensive database solution designed to manage an online plant shop, covering user roles, products, orders, payments, and more.

## 📑 Table of Contents

- [🌟 Project Overview](#-project-overview)
- [🗂️ Database Schema](#-database-schema)
- [📋 Tables Description](#-tables-description)
- [📊 Sample Data](#-sample-data)
- [🔍 Queries](#-queries)
- [⚙️ Setup Instructions](#-setup-instructions)
- [🤝 Contributing](#-contributing)
- [📜 License](#-license)

## 🌟 Project Overview

The **PlantShop Management System** aims to streamline the operations of an online plant shop by providing a robust and scalable database structure. It includes:

- **User Management**: Admins, Sellers, Customers, and Couriers
- **Product Management**: Categories and Products
- **Order Processing**: Orders, Products in Orders
- **Payment Tracking**: Payment Details
- **Delivery Tracking**: Tracking Details

## 🗂️ Database Schema

The database schema consists of the following tables:

1. **user**
2. **customer**
3. **courier**
4. **admin**
5. **seller**
6. **category**
7. **product**
8. **orders**
9. **order_product**
10. **trackingdetails**
11. **paymentdetails**

## 📋 Tables Description

### `user` 🧑‍💼

| Column   | Type         | Constraints                                 |
|----------|--------------|---------------------------------------------|
| UserID   | VARCHAR(20)  | PRIMARY KEY, NOT NULL                       |
| Username | VARCHAR(50)  | UNIQUE, NOT NULL                            |
| Password | VARCHAR(50)  | NOT NULL                                    |
| Email    | VARCHAR(100) | NOT NULL                                    |
| Contact  | VARCHAR(15)  | NOT NULL                                    |
| Role     | ENUM         | ('customer', 'admin', 'seller', 'courier'), NOT NULL |

### `customer` 👤

| Column   | Type         | Constraints                                 |
|----------|--------------|---------------------------------------------|
| UserID   | VARCHAR(20)  | PRIMARY KEY, FOREIGN KEY REFERENCES `user`(UserID) |
| Username | VARCHAR(50)  | FOREIGN KEY REFERENCES `user`(Username)     |
| Name     | VARCHAR(50)  | NOT NULL                                    |
| DOB      | DATE         |                                             |
| Gender   | ENUM         | ('Male', 'Female', 'Other')                 |
| Location | VARCHAR(100) |                                             |

### `courier` 🚚

| Column   | Type         | Constraints                                 |
|----------|--------------|---------------------------------------------|
| UserID   | VARCHAR(20)  | PRIMARY KEY, FOREIGN KEY REFERENCES `user`(UserID) |
| Username | VARCHAR(50)  | FOREIGN KEY REFERENCES `user`(Username)     |
| Name     | VARCHAR(50)  | NOT NULL                                    |
| DOB      | DATE         |                                             |
| Gender   | ENUM         | ('Male', 'Female', 'Other')                 |
| Location | VARCHAR(100) |                                             |

### `admin` 👨‍💼

| Column   | Type         | Constraints                                 |
|----------|--------------|---------------------------------------------|
| UserID   | VARCHAR(20)  | PRIMARY KEY, FOREIGN KEY REFERENCES `user`(UserID) |
| Username | VARCHAR(50)  | FOREIGN KEY REFERENCES `user`(Username)     |
| Name     | VARCHAR(50)  | NOT NULL                                    |
| DOB      | DATE         |                                             |
| Gender   | ENUM         | ('Male', 'Female', 'Other')                 |
| Location | VARCHAR(100) |                                             |

### `seller` 🛒

| Column   | Type         | Constraints                                 |
|----------|--------------|---------------------------------------------|
| UserID   | VARCHAR(20)  | PRIMARY KEY, FOREIGN KEY REFERENCES `user`(UserID) |
| Username | VARCHAR(50)  | FOREIGN KEY REFERENCES `user`(Username)     |
| Name     | VARCHAR(50)  | NOT NULL                                    |
| DOB      | DATE         |                                             |
| Gender   | ENUM         | ('Male', 'Female', 'Other')                 |
| Location | VARCHAR(100) |                                             |

### `category` 📦

| Column       | Type          | Constraints                                 |
|--------------|---------------|---------------------------------------------|
| Cat_ID       | INT           | PRIMARY KEY, AUTO_INCREMENT                 |
| AdminID      | VARCHAR(20)   | FOREIGN KEY REFERENCES `admin`(UserID)      |
| Name         | VARCHAR(50)   | NOT NULL                                    |
| Season       | VARCHAR(20)   |                                             |
| NoOfProducts | INT           |                                             |
| Description  | TEXT          |                                             |

### `product` 🌱

| Column      | Type          | Constraints                                 |
|-------------|---------------|---------------------------------------------|
| ProductID   | VARCHAR(20)   | PRIMARY KEY                                 |
| Cat_ID      | INT           | FOREIGN KEY REFERENCES `category`(Cat_ID)   |
| SellerID    | VARCHAR(20)   | FOREIGN KEY REFERENCES `seller`(UserID)     |
| PName       | VARCHAR(100)  | NOT NULL                                    |
| Price       | DECIMAL(10, 2)|                                             |
| Size        | VARCHAR(20)   |                                             |
| Description | TEXT          |                                             |
| Image       | VARCHAR(255)  |                                             |

### `orders` 📋

| Column     | Type         | Constraints                                 |
|------------|--------------|---------------------------------------------|
| OrderID    | INT          | PRIMARY KEY, AUTO_INCREMENT                 |
| CustomerID | VARCHAR(20)  | FOREIGN KEY REFERENCES `customer`(UserID)   |
| OrderDate  | DATE         | NOT NULL                                    |
| PaymentID  | INT          | NOT NULL                                    |
| TrackingID | INT          | NOT NULL, UNIQUE                            |

### `order_product` 📦

| Column    | Type         | Constraints                                 |
|-----------|--------------|---------------------------------------------|
| OrderID   | INT          | PRIMARY KEY, FOREIGN KEY REFERENCES `orders`(OrderID) |
| ProductID | VARCHAR(20)  | PRIMARY KEY, FOREIGN KEY REFERENCES `product`(ProductID) |

### `trackingdetails` 🚚

| Column        | Type         | Constraints                                 |
|---------------|--------------|---------------------------------------------|
| TrackingID    | INT          | PRIMARY KEY                                 |
| OrderID       | INT          | FOREIGN KEY REFERENCES `orders`(OrderID)    |
| CourierID     | VARCHAR(20)  | FOREIGN KEY REFERENCES `courier`(UserID)    |
| DeliveryStatus| ENUM         | ('In Transit', 'Out for Delivery', 'Delivered') |
| TrackingNumber| VARCHAR(50)  | NOT NULL                                    |

### `paymentdetails` 💳

| Column        | Type         | Constraints                                 |
|---------------|--------------|---------------------------------------------|
| PaymentID     | INT          | PRIMARY KEY                                 |
| Amount        | DECIMAL(10, 2)| NOT NULL                                    |
| PaymentMethod | ENUM         | ('Credit Card', 'Debit Card', 'PayPal', 'Cash') |
| PaymentStatus | ENUM         | ('Paid','Unpaid','Pending')                 |
| PaymentDate   | DATE         | NOT NULL                                    |

## 📊 Sample Data

The database includes sample data to illustrate various functionalities:

- **Users**: 10 each of Admins, Customers, Sellers, and Couriers
- **Categories**: Indoor Plants, Outdoor Plants, Flowering Plants, Cacti, Herbs, Fruit Trees, Shrubs, Bamboo Plants, Aquatic Plants, Air Purifying Plants
- **Products**: Various products under each category
- **Orders**: Sample orders with products
- **Tracking Details**: Tracking info for each order
- **Payment Details**: Payment information for processed orders

## 🔍 Queries

 It contains all queries (creation, selection, updation, and deletion.)

## ⚙️ Setup Instructions
Clone the Repository:

## Bash
### Copy code
git clone https://github.com/yourusername/plantshop-management-system.git
Navigate to the Project Directory:

## bash
### Copy code
cd plantshop-management-system

## Set Up the Database:

Import the provided SQL schema into your database.
Insert sample data if needed.
Configure Database Connection:

##Update your database configuration file with your database credentials.
Run the Application:

Follow specific instructions for running the application depending on the technology stack.
## 🤝 Contributing
We welcome contributions! To contribute:

### Fork the repository.
Create a new branch for your feature or bugfix.
Make your changes.
Submit a pull request with a description of your changes.


___________________________________________________________________________________________________________________________________________________________________________________________________________________
                                                                             🌱 Happy planting and coding! 🌟
