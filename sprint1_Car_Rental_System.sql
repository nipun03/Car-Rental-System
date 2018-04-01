-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2017 at 01:33 AM
-- Server version: 5.5.57-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Car_Rental_System`
--

-- --------------------------------------------------------

--
-- Table structure for table `Account`
--

CREATE TABLE IF NOT EXISTS `Account` (
  `username` varchar(50) NOT NULL,
  `password` varchar(40) NOT NULL,
  `license_number` varchar(50) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `license_number` (`license_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Account`
--

INSERT INTO `Account` (`username`, `password`, `license_number`) VALUES
('beth12', 'Hello123', 'K23-434-2918'),
('emforyou', 'itsmeagain12', 'C89-384-1938'),
('han95', '221Bbakerstreet', 'FA7-827-0831'),
('helloaria3', 'rosewood7', 'lO9-993-9871'),
('Morgansar', 'dypbs77', 'MD4-456-4832');

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE IF NOT EXISTS `Admin` (
  `Username` varchar(50) NOT NULL,
  `Password` varchar(40) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`Username`, `Password`) VALUES
('Admin1', 'Password1'),
('Admin2', 'Password2'),
('Admin3', 'Password3');

-- --------------------------------------------------------

--
-- Table structure for table `Car`
--

CREATE TABLE IF NOT EXISTS `Car` (
  `car_id` varchar(20) NOT NULL,
  `model` varchar(50) DEFAULT NULL,
  `make` varchar(50) DEFAULT NULL,
  `color` varchar(20) NOT NULL,
  `manufacturing_year` int(20) NOT NULL,
  `mileage` int(20) NOT NULL,
  `seating_capacity` int(10) NOT NULL,
  `car_type` varchar(100) NOT NULL,
  `price_per_day` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `license_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`car_id`),
  KEY `fk_Admin` (`username`),
  KEY `fk_Customer` (`license_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Car`
--

INSERT INTO `Car` (`car_id`, `model`, `make`, `color`, `manufacturing_year`, `mileage`, `seating_capacity`, `car_type`, `price_per_day`, `status`, `username`, `license_number`) VALUES
('ABX1234', 'CIVIC', 'HONDA', 'Green', 2014, 40, 4, 'ECONOMY', '$50', 'Available', 'Admin1', NULL),
('CXZ2356', 'AVENGER', 'DODGE', 'Mustard', 2015, 28, 2, 'MID SIZE', '$70', 'Not Available', 'Admin2', 'FA7-827-0831'),
('FKD8202', 'GOLF', 'VOLKSWAGAN', 'White', 2016, 50, 4, 'COMPACT', '$35', 'Not Available', 'Admin2', 'MD4-456-4832'),
('GLS7625', 'FOCUS', 'FORD', 'Orange', 2014, 45, 4, 'COMPACT', '$38', 'Not Available', 'Admin2', 'K23-434-2918'),
('GLZ2376', 'COROLLA', 'TOYOTA', 'Grey', 2016, 40, 4, 'ECONOMY', '$52', 'Available', 'Admin3', NULL),
('HJK1234', 'CIVIC', 'HONDA', 'Black', 2015, 42, 4, 'ECONOMY', '$53', 'Not Available', 'Admin1', 'C89-384-1938'),
('HNX1890', 'PRIUS', 'TOYOTA', 'Silver', 2015, 60, 4, 'COMPACT', '$43', 'Not Available', 'Admin1', 'FA7-827-0831'),
('KJS1983', 'PRIUS', 'TOYOTA', 'Black', 2014, 58, 4, 'COMPACT', '$40', 'Not Available', 'Admin3', 'lO9-993-9871'),
('OTY7293', 'CRUZE', 'CHEVROLET', 'Purple', 2016, 38, 4, 'MID SIZE', '$60', 'Not Available', 'Admin1', 'K23-434-2918'),
('QWE4562', 'LEGACY', 'SUBARU', 'Green', 2012, 35, 2, 'MID SIZE', '$65', 'Not Available', 'Admin3', 'MD4-456-4832'),
('SDF4567', 'FIESTA', 'FORD', 'Blue', 2015, 45, 4, 'ECONOMY', '$45', 'Not Available', 'Admin2', 'MD4-456-4832'),
('SDL9356', 'FOCUS', 'FORD', 'Sky Blue', 2016, 42, 4, 'COMPACT', '$35', 'Not Available', 'Admin3', 'C89-384-1938'),
('WER3245', 'ACCENT', 'HYUNDAI', 'Silver', 2014, 45, 4, 'ECONOMY', '$38', 'Available', 'Admin2', NULL),
('XCZ2756', 'PRIUS', 'TOYOTA', 'Silver', 2015, 28, 2, 'MID SIZE', '$70', 'Available', 'Admin2', NULL),
('XZC2556', 'AVENGER', 'DODGE', 'Black', 2015, 28, 2, 'MID SIZE', '$70', 'Available', 'Admin2', NULL),
('ZCX5756', 'GOLF', 'VOLKSWAGAN', 'White', 2015, 28, 2, 'MID SIZE', '$70', 'Available', 'Admin2', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `CardDetails`
--

CREATE TABLE IF NOT EXISTS `CardDetails` (
  `username` varchar(50) NOT NULL,
  `card_number` bigint(30) NOT NULL,
  `name_on_card` varchar(50) NOT NULL,
  `date_of_expiration` date NOT NULL,
  `billing_address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`,`card_number`),
  UNIQUE KEY `card_number` (`card_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CardDetails`
--

INSERT INTO `CardDetails` (`username`, `card_number`, `name_on_card`, `date_of_expiration`, `billing_address`) VALUES
('beth12', 1234567890191837, 'Elizabeth Cameron', '2016-01-31', '9352 University Terrace Drive Mecklenburg County C'),
('emforyou', 6767416716371631, 'Emily Fields', '2015-05-31', '10755 Scripps Poway Parkway San Diego California 9'),
('han95', 6574868614361892, 'Hanna Marin', '2014-10-31', '44 Shirley Ave. Kirk Drive Seattle Washington 6534'),
('helloaria3', 8372783829184728, 'Aria Montgomery', '2016-03-31', '71 Pilgrim Avenue Chevy Chase Columbus Ohio 28103'),
('Morgansar', 3726482748274827, 'Sarah Morgan', '2015-08-31', '514 S. Magnolia St. Orlando Florida 32806');

-- --------------------------------------------------------

--
-- Table structure for table `Customer`
--

CREATE TABLE IF NOT EXISTS `Customer` (
  `license_number` varchar(30) NOT NULL,
  `email_id` varchar(50) NOT NULL,
  `mobile_number` int(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `address_line_1` varchar(50) NOT NULL,
  `address_line_2` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `zip_code` int(20) NOT NULL,
  PRIMARY KEY (`license_number`),
  UNIQUE KEY `license_number` (`license_number`),
  UNIQUE KEY `email_id` (`email_id`),
  UNIQUE KEY `mobile_number` (`mobile_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Customer`
--

INSERT INTO `Customer` (`license_number`, `email_id`, `mobile_number`, `first_name`, `middle_name`, `last_name`, `date_of_birth`, `address_line_1`, `address_line_2`, `city`, `state`, `zip_code`) VALUES
('C89-384-1938', 'fieldsemily@gmail.com', 2107934562, 'Emily', 'G', 'Fields', '1991-05-20', '10755 Scripps', 'Poway Parkway', 'San Diego', 'California', 92131),
('FA7-827-0831', 'hannamarin@gmail.com', 1234567896, 'Hanna', 'J', 'Marin', '1995-05-03', '44 Shirley Ave.', 'Kirk Drive', 'Seattle', 'Washington', 65347),
('K23-434-2918', 'ecameron@gmail.com', 2147483647, 'Elizabeth', 'M', 'Cameron', '0000-00-00', '9352 University Terrace Drive', 'Mecklenburg County', 'Charlotte', 'North Carolina', 28262),
('lO9-993-9871', 'montaria@gmail.com', 1982736450, 'Aria', 'E', 'Montgomery', '1993-03-22', '71 Pilgrim Avenue', 'Chevy Chase', 'Columbus', 'Ohio', 28103),
('MD4-456-4832', 'sarahm@gmail.com', 1293628286, 'Sarah', 'K', 'Morgan', '1992-06-03', '514 S. Magnolia St.', 'null', 'Orlando', 'Florida', 32806);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Account`
--
ALTER TABLE `Account`
  ADD CONSTRAINT `Account_ibfk_1` FOREIGN KEY (`license_number`) REFERENCES `Customer` (`license_number`);

--
-- Constraints for table `Car`
--
ALTER TABLE `Car`
  ADD CONSTRAINT `Car_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Admin` (`Username`),
  ADD CONSTRAINT `Car_ibfk_2` FOREIGN KEY (`license_number`) REFERENCES `Customer` (`license_number`);

--
-- Constraints for table `CardDetails`
--
ALTER TABLE `CardDetails`
  ADD CONSTRAINT `CardDetails_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Account` (`username`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
