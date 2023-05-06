SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


CREATE DATABASE IF NOT EXISTS `sql_project` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `sql_project`;

CREATE TABLE `warehouse` (
  `WarehouseID` int NOT NULL AUTO_INCREMENT,
  `WarehouseManager` varchar(30) NOT NULL,
  `WarehouseName` varchar(30) NOT NULL,
  `WarehouseEmail` varchar(30) NOT NULL,
  `WarehouseNumber` varchar(30) NOT NULL,
  `Address` TEXT NOT NULL,
  `StreetAddress` TEXT NOT NULL,
  `Address2` TEXT NULL,
  `State` TEXT NOT NULL,
  `City` TEXT NOT NULL,
  `Zipcode` varchar(10) NOT NULL,
  PRIMARY KEY (warehouseID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `category` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(30) NOT NULL,
  PRIMARY KEY (CategoryID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `delivery` (
  `DeliveryID` int NOT NULL AUTO_INCREMENT,
  `DeliveryType` varchar(30) NOT NULL,
  `DeliveryPrice` int NOT NULL,
  PRIMARY KEY (DeliveryID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `customers` (
  `CustomersID` int NOT NULL AUTO_INCREMENT,
  `CustomersName` varchar(30) NOT NULL,
  `CustomersEmail` varchar(30) NOT NULL,
  `CustomersNumber` varchar(30) NOT NULL,
  `CustomerAddress` varchar(30) NOT NULL,
  PRIMARY KEY (CustomersID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `WarehouseID` int NOT NULL,
  `UserFirstName` varchar(30) NOT NULL,
  `UserLastName` varchar(30) NOT NULL,
  `UserAccount` varchar(30) NOT NULL,
  `UserPassword` varchar(30) NOT NULL,
  `UserEmail` varchar(30) NOT NULL,
  `UserPhone` varchar(30) NOT NULL,
  `UserRole` varchar(30) NOT NULL,
  PRIMARY KEY (UserID),
  FOREIGN KEY (WarehouseID) REFERENCES warehouse(WarehouseID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `incomingorder` (
  `IncomingOrderID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `IncomingOrderDate` datetime NOT NULL,
  PRIMARY KEY (IncomingOrderID),
  FOREIGN KEY (UserID) REFERENCES user(UserID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `product` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `WarehouseID` int NOT NULL,
  `CategoryID` int NOT NULL,
  `ProductName` varchar(30) NOT NULL,
  `ProductPrice` int NOT NULL,
  `ProductSellingCost` int NOT NULL,
  `ProductQuantity` int NOT NULL,
  `ProductDescription` varchar(30) NOT NULL,
  PRIMARY KEY (ProductID),
  FOREIGN KEY (WarehouseID) REFERENCES warehouse(WarehouseID),
  FOREIGN KEY (CategoryID) REFERENCES category(CategoryID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `incomingitems` (
  `IncomingItemsID` int NOT NULL AUTO_INCREMENT,
  `IncomingOrderID` int NOT NULL,
  `ProductID` int NOT NULL,
  `IncomingItemQuantity` int NOT NULL,
  PRIMARY KEY (IncomingItemsID),
  FOREIGN KEY (IncomingOrderID) REFERENCES incomingorder(IncomingOrderID),
  FOREIGN KEY (ProductID) REFERENCES product(ProductID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `outgoingorders` (
  `OutgoingOrderID` int NOT NULL AUTO_INCREMENT,
  `CustomersID` int NOT NULL,
  `DeliveryID` int NOT NULL,
  `OutgoingOrderDate` datetime NOT NULL,
  PRIMARY KEY (OutgoingOrderID),
  FOREIGN KEY (CustomersID) REFERENCES customers(CustomersID),
  FOREIGN KEY (DeliveryID) REFERENCES delivery(DeliveryID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `outgoingitems` (
  `OutgoingItemsID` int NOT NULL AUTO_INCREMENT,
  `OutgoingOrderID` int NOT NULL,
  `ProductID` int NOT NULL,
  `OutgoingItemQuantity` int NOT NULL,
  PRIMARY KEY (OutgoingItemsID),
  FOREIGN KEY (OutgoingOrderID) REFERENCES outgoingorders(OutgoingOrderID),
  FOREIGN KEY (ProductID) REFERENCES product(ProductID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `return` (
  `ReturnID` int NOT NULL AUTO_INCREMENT,
  `CustomersID` int NOT NULL,
  `ProductID` int NOT NULL,
  `OutgoingOrderID` int NOT NULL,
  `ReturnDate` datetime NOT NULL,
  `ReturnQuantity` int NOT NULL,
  `ReturnResons` varchar(200) NOT NULL,
  PRIMARY KEY (ReturnID),
  FOREIGN KEY (CustomersID) REFERENCES customers(CustomersID),
  FOREIGN KEY (ProductID) REFERENCES product(ProductID),
  FOREIGN KEY (OutgoingOrderID) REFERENCES outgoingorders(OutgoingOrderID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;