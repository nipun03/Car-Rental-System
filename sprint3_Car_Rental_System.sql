-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2017 at 08:57 PM
-- Server version: 5.5.57-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sprint3_Car_Rental_System`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`nipun03`@`%` PROCEDURE `GetRentalAmount`(IN `p_reservation_id` INT(30), OUT `p_rental_amount` INT(30))
    SQL SECURITY INVOKER
begin
declare start date;
declare end date;
declare price int(50);
select start_date,end_date,price_per_day into start, end,  price
from Reservation inner join Car using(car_id) inner join CarType using(car_type)
where reservation_id=p_reservation_id;
set p_rental_amount =datediff(end,start)*price;
end$$

--
-- Functions
--
CREATE DEFINER=`nipun03`@`%` FUNCTION `GetPenaltyAmount`(`p_reservation_id` INT(30)) RETURNS int(30)
    DETERMINISTIC
    SQL SECURITY INVOKER
begin
declare end date;
declare actualend date;
declare price int(50);
declare penaltyamount int(50);
select end_date,actual_end_date,price_per_day into end, actualend,  price
from Reservation inner join Car using(car_id) inner join CarType using (car_type)
where reservation_id=p_reservation_id;
set penaltyamount =datediff(actualend,end)*price*0.5;
return(penaltyamount);
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Account`
--

CREATE TABLE IF NOT EXISTS `Account` (
  `username` varchar(50) NOT NULL,
  `password` varchar(40) NOT NULL,
  `license_number` varchar(50) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `license_number` (`license_number`),
  KEY `Account_Index` (`username`),
  KEY `Username_Index` (`username`)
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
-- Table structure for table `AdditionalDriver`
--

CREATE TABLE IF NOT EXISTS `AdditionalDriver` (
  `name` varchar(20) DEFAULT NULL,
  `license_number` varchar(20) NOT NULL DEFAULT '',
  `reservation_id` int(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`license_number`,`reservation_id`),
  KEY `Add_Driver_Index` (`license_number`,`reservation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AdditionalDriver`
--

INSERT INTO `AdditionalDriver` (`name`, `license_number`, `reservation_id`) VALUES
('Liam Hemsworth', 'A89759798', 2),
('Alex Zane', 'S530460964420', 5);

-- --------------------------------------------------------

--
-- Table structure for table `Address`
--

CREATE TABLE IF NOT EXISTS `Address` (
  `address_id` int(30) NOT NULL AUTO_INCREMENT,
  `address_line_1` varchar(50) NOT NULL,
  `address_line_2` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `zip_code` int(20) NOT NULL,
  PRIMARY KEY (`address_id`),
  KEY `Address_id_Index` (`address_id`),
  KEY `City_Index` (`city`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `Address`
--

INSERT INTO `Address` (`address_id`, `address_line_1`, `address_line_2`, `city`, `state`, `zip_code`) VALUES
(1, '9352 University Terrace Drive', 'Mecklenburg County', 'Charlotte', 'North Carolina', 28262),
(2, '514 S. Magnolia St.', 'null', 'Orlando', 'Florida', 32806),
(3, '44 Shirley Ave.', 'Kirk Drive', 'Seattle', 'Washington', 65347),
(4, '71 Pilgrim Avenue', 'Chevy Chase', 'Columbus', 'Ohio', 28103),
(5, '10755 Scripps', 'Poway Parkway', 'San Diego', 'California', 92131),
(6, 'DALLAS LOVE FIELD AIRPORT', 'Herb Kelleher Way', 'Dallas', 'Texas', 75235),
(7, 'LOS ANGELES INTL AIRPORT', 'World Way', 'Los Angeles', 'California', 90045),
(8, 'FORT WORTH INTL AIRPORT', 'International Pkwy', 'Dallas', 'Texas', 75261),
(9, 'WEST HOUSTON AIRPORT', 'Groschke Rd', 'Houston', 'Texas', 77094),
(10, 'WASHINGTON DULLES INTL AIRPORT', 'Saarinen Cir', 'Dulles', 'Virginia', 20166),
(11, 'NEWARK LIBERTY INTL AIRPORT', 'Brewster Rd', 'Newark', 'New Jersey', 7114),
(12, 'NEWARK LIBERTY INTL AIRPORT', 'Brewster Rd', 'Newark', 'New Jersey', 7114),
(13, 'SALT LAKE CITY INTL AIRPORT', 'N Terminal Dr', 'Salt Lake City', 'Utah', 84122);

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
  `model` varchar(40) NOT NULL,
  `make` varchar(40) NOT NULL,
  `color` varchar(20) NOT NULL,
  `manufacturing_year` int(20) NOT NULL,
  `mileage` int(20) NOT NULL,
  `seating_capacity` int(10) NOT NULL,
  `car_type` varchar(100) NOT NULL,
  `status` enum('Not Available','Available') NOT NULL,
  `username` varchar(50) NOT NULL,
  `location_id` int(30) DEFAULT NULL,
  PRIMARY KEY (`car_id`),
  KEY `fk_Admin` (`username`),
  KEY `Car_ibfk_2` (`car_type`),
  KEY `location_id` (`location_id`),
  KEY `Carid_Index` (`car_id`),
  KEY `Status_Index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Car`
--

INSERT INTO `Car` (`car_id`, `model`, `make`, `color`, `manufacturing_year`, `mileage`, `seating_capacity`, `car_type`, `status`, `username`, `location_id`) VALUES
('ABX1234', 'CIVIC', 'HONDA', 'Green', 2014, 40, 4, 'FULL SIZE', 'Available', 'Admin1', 4),
('CXZ2356', 'AVENGER', 'DODGE', 'Mustard', 2015, 28, 2, 'LUXURY', 'Available', 'Admin2', 4),
('FKD8202', 'GOLF', 'VOLKSWAGAN', 'White', 2016, 50, 4, 'ECONOMY', 'Available', 'Admin2', 2),
('GLS7625', 'FOCUS', 'FORD', 'Orange', 2014, 45, 4, 'ECONOMY', 'Available', 'Admin2', 1),
('GLZ2376', 'COROLLA', 'TOYOTA', 'Grey', 2016, 40, 4, 'FULL SIZE', 'Available', 'Admin3', 4),
('HJK1234', 'CIVIC', 'HONDA', 'Black', 2015, 42, 4, 'FULL SIZE', 'Available', 'Admin1', 2),
('HNX1890', 'PRIUS', 'TOYOTA', 'Silver', 2015, 60, 4, 'ECONOMY', 'Available', 'Admin1', 5),
('KJS1983', 'PRIUS', 'TOYOTA', 'Black', 2014, 58, 4, 'ECONOMY', 'Available', 'Admin3', 4),
('OTY7293', 'CRUZE', 'CHEVROLET', 'Purple', 2016, 38, 4, 'FULL SIZE', 'Available', 'Admin1', 1),
('QWE4562', 'LEGACY', 'SUBARU', 'Green', 2012, 35, 2, 'FULL SIZE', 'Available', 'Admin3', 5),
('SDF4567', 'FIESTA', 'FORD', 'Blue', 2015, 45, 4, 'MID SIZE', 'Available', 'Admin2', 2),
('SDL9356', 'FOCUS', 'FORD', 'Sky Blue', 2016, 42, 4, 'MID SIZE', 'Available', 'Admin3', 2),
('WER3245', 'ACCENT', 'HYUNDAI', 'Silver', 2014, 45, 4, 'MID SIZE', 'Available', 'Admin2', 3),
('XCZ2756', 'PRIUS', 'TOYOTA', 'Silver', 2015, 28, 2, 'ECONOMY', 'Available', 'Admin2', 1),
('XZC2556', 'AVENGER', 'DODGE', 'Black', 2015, 28, 2, 'LUXURY', 'Available', 'Admin2', 4),
('ZCX5756', 'GOLF', 'VOLKSWAGAN', 'White', 2015, 28, 2, 'ECONOMY', 'Available', 'Admin2', 3);

-- --------------------------------------------------------

--
-- Table structure for table `CarModel`
--

CREATE TABLE IF NOT EXISTS `CarModel` (
  `model_id` int(20) NOT NULL AUTO_INCREMENT,
  `model` varchar(40) NOT NULL,
  `make` varchar(40) NOT NULL,
  `color` varchar(20) NOT NULL,
  `manufacturing_year` int(20) NOT NULL,
  `mileage` int(20) NOT NULL,
  `seating_capacity` int(10) NOT NULL,
  PRIMARY KEY (`model_id`),
  KEY `Model_id_Index` (`model_id`),
  KEY `Modelid_Index` (`model_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `CarModel`
--

INSERT INTO `CarModel` (`model_id`, `model`, `make`, `color`, `manufacturing_year`, `mileage`, `seating_capacity`) VALUES
(1, 'CIVIC', 'HONDA', 'Green', 2014, 40, 4),
(2, 'AVENGER', 'DODGE', 'Mustard', 2015, 28, 2),
(3, 'GOLF', 'VOLKSWAGAN', 'White', 2016, 50, 4),
(4, 'FOCUS', 'FORD', 'Orange', 2014, 45, 4),
(5, 'COROLLA', 'TOYOTA', 'Grey', 2016, 40, 4),
(6, 'CIVIC', 'HONDA', 'Black', 2015, 42, 4),
(7, 'PRIUS', 'TOYOTA', 'Silver', 2015, 60, 4),
(8, 'PRIUS', 'TOYOTA', 'Black', 2014, 58, 4),
(9, 'CRUZE', 'CHEVROLET', 'Purple', 2016, 38, 4),
(10, 'LEGACY', 'SUBARU', 'Green', 2012, 35, 2),
(11, 'FIESTA', 'FORD', 'Blue', 2015, 45, 4),
(12, 'FOCUS', 'FORD', 'Sky Blue', 2016, 42, 4),
(13, 'ACCENT', 'HYUNDAI', 'Silver', 2014, 45, 4),
(14, 'PRIUS', 'TOYOTA', 'Silver', 2015, 28, 2),
(15, 'AVENGER', 'DODGE', 'Black', 2015, 28, 2),
(16, 'GOLF', 'VOLKSWAGAN', 'White', 2015, 28, 2);

-- --------------------------------------------------------

--
-- Table structure for table `CarType`
--

CREATE TABLE IF NOT EXISTS `CarType` (
  `car_type` varchar(100) NOT NULL,
  `price_per_day` int(30) NOT NULL,
  PRIMARY KEY (`car_type`),
  KEY `Car_type_Index` (`car_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CarType`
--

INSERT INTO `CarType` (`car_type`, `price_per_day`) VALUES
('ECONOMY', 45),
('FULL SIZE', 65),
('LUXURY', 90),
('MID SIZE', 55),
('SUV', 80);

-- --------------------------------------------------------

--
-- Table structure for table `CreditCard`
--

CREATE TABLE IF NOT EXISTS `CreditCard` (
  `username` varchar(50) NOT NULL,
  `card_number` bigint(30) NOT NULL,
  `name_on_card` varchar(50) NOT NULL,
  `date_of_expiration` date NOT NULL,
  `billing_address` int(30) DEFAULT NULL,
  PRIMARY KEY (`username`,`card_number`),
  UNIQUE KEY `card_number` (`card_number`),
  KEY `billing_address` (`billing_address`),
  KEY `Credit_Card_Index` (`username`,`card_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CreditCard`
--

INSERT INTO `CreditCard` (`username`, `card_number`, `name_on_card`, `date_of_expiration`, `billing_address`) VALUES
('beth12', 1234567890191837, 'Elizabeth Cameron', '2016-01-31', 1),
('emforyou', 6767416716371631, 'Emily Fields', '2015-05-31', 4),
('han95', 6574868614361892, 'Hanna Marin', '2014-10-31', 3),
('helloaria3', 8372783829184728, 'Aria Montgomery', '2016-03-31', 5),
('Morgansar', 3726482748274827, 'Sarah Morgan', '2015-08-31', 2);

-- --------------------------------------------------------

--
-- Table structure for table `Customer`
--

CREATE TABLE IF NOT EXISTS `Customer` (
  `license_number` varchar(30) NOT NULL,
  `email_id` varchar(50) NOT NULL,
  `mobile_number` int(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `residential_address` int(30) NOT NULL,
  PRIMARY KEY (`license_number`),
  UNIQUE KEY `license_number` (`license_number`),
  UNIQUE KEY `email_id` (`email_id`),
  UNIQUE KEY `mobile_number` (`mobile_number`),
  KEY `residential_address` (`residential_address`),
  KEY `License_Index` (`license_number`),
  KEY `Name_Index` (`first_name`,`last_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Customer`
--

INSERT INTO `Customer` (`license_number`, `email_id`, `mobile_number`, `first_name`, `middle_name`, `last_name`, `date_of_birth`, `residential_address`) VALUES
('C89-384-1938', 'fieldsemily@gmail.com', 2107934562, 'Emily', 'G', 'Fields', '1991-05-20', 1),
('FA7-827-0831', 'hannamarin@gmail.com', 1234567896, 'Hanna', 'J', 'Marin', '1995-05-03', 2),
('K23-434-2918', 'ecameron@gmail.com', 2147483647, 'Elizabeth', 'M', 'Cameron', '1993-12-04', 3),
('lO9-993-9871', 'montaria@gmail.com', 1982736450, 'Aria', 'E', 'Montgomery', '1993-03-22', 4),
('MD4-456-4832', 'sarahm@gmail.com', 1293628286, 'Sarah', 'K', 'Morgan', '1992-06-03', 5);

-- --------------------------------------------------------

--
-- Table structure for table `Insurance`
--

CREATE TABLE IF NOT EXISTS `Insurance` (
  `insurance_type` varchar(30) DEFAULT NULL,
  `bodily_coverage` int(20) DEFAULT NULL,
  `medical_coverage` int(20) DEFAULT NULL,
  `collision_coverage` int(20) DEFAULT NULL,
  `insurance_price` int(10) DEFAULT NULL,
  KEY `Insurance_Index` (`insurance_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Insurance`
--

INSERT INTO `Insurance` (`insurance_type`, `bodily_coverage`, `medical_coverage`, `collision_coverage`, `insurance_price`) VALUES
('Liability coverage', 25000, 50000, 20000, 20),
('Comprehensive coverage', 50000, 50000, 50000, 30),
('Auto Insurance', 25000, 25000, 25000, 25);

-- --------------------------------------------------------

--
-- Table structure for table `Location`
--

CREATE TABLE IF NOT EXISTS `Location` (
  `location_id` int(30) NOT NULL AUTO_INCREMENT,
  `phone_number` int(10) DEFAULT NULL,
  `address` int(30) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `address` (`address`),
  KEY `Loc_Index` (`location_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `Location`
--

INSERT INTO `Location` (`location_id`, `phone_number`, `address`) VALUES
(1, 2025550184, 6),
(2, 2025550117, 9),
(3, 2025550155, 7),
(4, 2025550171, 11),
(5, 2025550112, 10);

-- --------------------------------------------------------

--
-- Table structure for table `Offers`
--

CREATE TABLE IF NOT EXISTS `Offers` (
  `promo_code` varchar(20) NOT NULL DEFAULT '',
  `description` varchar(50) DEFAULT NULL,
  `promo_type` varchar(20) DEFAULT NULL,
  `percentage` int(20) DEFAULT NULL,
  `discounted_amount` int(20) DEFAULT NULL,
  `status` enum('Available','Expired') NOT NULL,
  PRIMARY KEY (`promo_code`),
  KEY `Offer_Index` (`promo_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Offers`
--

INSERT INTO `Offers` (`promo_code`, `description`, `promo_type`, `percentage`, `discounted_amount`, `status`) VALUES
('LabourDay', 'Labour day $5 offer', 'Discounted amount', NULL, 5, 'Expired'),
('NewYear', 'New year 10% offer', 'percentage', 10, NULL, 'Available'),
('VeteranDay', 'Veteran day $10 offer', 'percentage', 10, NULL, 'Available'),
('XMAS15', 'Christmas 15% offer', 'Discounted amount', NULL, 15, 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `Payment`
--

CREATE TABLE IF NOT EXISTS `Payment` (
  `payment_id` int(30) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `card_number` bigint(30) DEFAULT NULL,
  `amount_paid` int(30) DEFAULT '0',
  `reservation_id` int(30) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `card_number` (`card_number`),
  KEY `username` (`username`),
  KEY `reservation_id` (`reservation_id`),
  KEY `Pyament_Index` (`payment_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

--
-- Dumping data for table `Payment`
--

INSERT INTO `Payment` (`payment_id`, `username`, `card_number`, `amount_paid`, `reservation_id`) VALUES
(1, 'beth12', 1234567890191837, 195, 1),
(2, 'Morgansar', 3726482748274827, 90, 2),
(3, 'helloaria3', 8372783829184728, 90, 4),
(4, 'emforyou', 6767416716371631, 220, 5),
(6, 'han95', 6574868614361892, 45, 9),
(9, 'beth12', 1234567890191837, 520, 7),
(23, 'helloaria3', 8372783829184728, NULL, 10),
(33, 'Morgansar', 3726482748274827, 142, 8);

-- --------------------------------------------------------

--
-- Stand-in structure for view `Rentalinfo`
--
CREATE TABLE IF NOT EXISTS `Rentalinfo` (
`reservation_id` int(30)
,`license_number` varchar(50)
,`FullName` varchar(152)
,`car_type` varchar(100)
,`Pickup Location` varchar(50)
,`Drop Location` varchar(50)
,`rental_amount` int(30)
);
-- --------------------------------------------------------

--
-- Table structure for table `Reservation`
--

CREATE TABLE IF NOT EXISTS `Reservation` (
  `reservation_id` int(30) NOT NULL AUTO_INCREMENT,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `actual_end_date` date DEFAULT NULL,
  `penalty_amount` int(30) DEFAULT NULL,
  `rental_amount` int(30) DEFAULT NULL,
  `status` enum('Booked','Cancelled','Returned') NOT NULL DEFAULT 'Booked',
  `license_number` varchar(50) DEFAULT NULL,
  `car_id` varchar(20) DEFAULT NULL,
  `pickup_location_id` int(30) DEFAULT NULL,
  `drop_location_id` int(30) DEFAULT NULL,
  `insurance_type` varchar(30) DEFAULT NULL,
  `promo_code` varchar(20) DEFAULT NULL,
  `final_amount` int(10) DEFAULT NULL,
  PRIMARY KEY (`reservation_id`),
  KEY `license_number` (`license_number`),
  KEY `car_id` (`car_id`),
  KEY `pickup_location_id` (`pickup_location_id`),
  KEY `drop_location_id` (`drop_location_id`),
  KEY `Reservation_id_Index` (`reservation_id`),
  KEY `Status_Index` (`status`),
  KEY `insurance_type` (`insurance_type`),
  KEY `promo_code` (`promo_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `Reservation`
--

INSERT INTO `Reservation` (`reservation_id`, `start_date`, `end_date`, `actual_end_date`, `penalty_amount`, `rental_amount`, `status`, `license_number`, `car_id`, `pickup_location_id`, `drop_location_id`, `insurance_type`, `promo_code`, `final_amount`) VALUES
(1, '2017-10-05', '2017-10-07', '2017-10-09', 65, 130, 'Returned', 'K23-434-2918', 'ABX1234', 1, 2, 'Liability coverage', NULL, NULL),
(2, '2017-11-12', '2017-11-13', '2017-11-13', 0, 90, 'Returned', 'MD4-456-4832', 'XZC2556', 1, 4, 'Comprehensive coverage', NULL, NULL),
(3, '2018-01-28', '2018-01-31', NULL, NULL, NULL, 'Cancelled', 'FA7-827-0831', 'ZCX5756', 2, 5, 'Comprehensive coverage', NULL, NULL),
(4, '2017-10-03', '2017-10-06', '2017-10-04', 0, 90, 'Returned', 'lO9-993-9871', 'CXZ2356', 4, 4, 'Liability coverage', NULL, NULL),
(5, '2017-11-10', '2017-11-13', '2017-11-15', 55, 165, 'Returned', 'C89-384-1938', 'SDL9356', 3, 2, 'Comprehensive coverage', NULL, NULL),
(7, '2017-11-11', '2017-11-16', '2017-11-18', 65, 455, 'Returned', 'K23-434-2918', 'ABX1234', 2, 4, NULL, NULL, 520),
(8, '2018-01-01', '2018-01-03', '2018-01-03', 0, 130, 'Returned', 'MD4-456-4832', 'HJK1234', 4, 2, 'Auto Insurance', 'NewYear', 142),
(9, '2017-11-11', '2017-11-14', NULL, NULL, NULL, 'Booked', 'FA7-827-0831', 'HNX1890', 2, 5, 'Auto Insurance', 'VeteranDay', NULL),
(10, '2017-12-25', '2017-12-28', NULL, NULL, NULL, 'Booked', 'lO9-993-9871', 'ZCX5756', 2, 3, 'Comprehensive coverage', 'XMAS15', NULL);

--
-- Triggers `Reservation`
--
DROP TRIGGER IF EXISTS `after_reservation_insert`;
DELIMITER //
CREATE TRIGGER `after_reservation_insert` AFTER INSERT ON `Reservation`
 FOR EACH ROW BEGIN
UPDATE Car set status='Not Available' where car_id=new.car_id;

END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `before_reservation_insert`;
DELIMITER //
CREATE TRIGGER `before_reservation_insert` BEFORE INSERT ON `Reservation`
 FOR EACH ROW BEGIN
declare location int(30);
select location_id into location from Car where car_id=new.car_id;
set new.pickup_location_id= location;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `before_reservation_update`;
DELIMITER //
CREATE TRIGGER `before_reservation_update` BEFORE UPDATE ON `Reservation`
 FOR EACH ROW BEGIN
declare p_username varchar(50);
declare p_cardno bigint(30);
declare price int(30);
declare insurance int(30);
declare perpromoprice int(30);
declare dispromoprice int(30);
declare stat varchar(20);
select status into stat from Offers where promo_code=new.promo_code;
if old.actual_end_date is null && new.actual_end_date is not null && old.status="Booked" then
set new.status = "Returned";
UPDATE Car set status='Available',location_id=new.drop_location_id where car_id=new.car_id;
select price_per_day into price from Car inner join CarType using (car_type) where car_id=new.car_id;
set new.rental_amount=DATEDIFF(new.actual_end_date,new.start_date)*price;
if new.actual_end_date >= new.end_date then
set new.penalty_amount= DATEDIFF(new.actual_end_date,new.end_date)*price*0.5;
else 
set new.penalty_amount=0;
end if;
if new.insurance_type is NULL then
set insurance=0;
else
select insurance_price into insurance from Insurance where insurance_type=new.insurance_type;
end if;
set new.final_amount=new.rental_amount+new.penalty_amount+insurance;

select discounted_amount into dispromoprice from Offers where promo_code=new.promo_code;
select percentage into perpromoprice from Offers where promo_code=new.promo_code;

if new.promo_code is not NULL && stat = "Available" then
if dispromoprice is null then
set new.final_amount=((1-perpromoprice/100)*new.rental_amount)+new.penalty_amount+insurance;
else
set new.final_amount=new.rental_amount+new.penalty_amount+insurance-dispromoprice;
end if;
end if;

select username, card_number into p_username, p_cardno from Account inner join CreditCard using (username) where license_number= new.license_number;
insert into Payment(username,card_number,reservation_id,amount_paid ) values(p_username,p_cardno,new.reservation_id,new.final_amount);
end if;

if new.status='Cancelled' then
UPDATE Car set status='Available',location_id=new.pickup_location_id where car_id=new.car_id;
end if;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `Rentalinfo`
--
DROP TABLE IF EXISTS `Rentalinfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`nipun03`@`%` SQL SECURITY DEFINER VIEW `Rentalinfo` AS select `r`.`reservation_id` AS `reservation_id`,`r`.`license_number` AS `license_number`,concat_ws(',',`Customer`.`first_name`,`Customer`.`middle_name`,`Customer`.`last_name`) AS `FullName`,`c`.`car_type` AS `car_type`,`a`.`city` AS `Pickup Location`,`ad`.`city` AS `Drop Location`,`r`.`rental_amount` AS `rental_amount` from ((((((`Reservation` `r` join `Car` `c` on((`r`.`car_id` = `c`.`car_id`))) join `Customer` on((`r`.`license_number` = `Customer`.`license_number`))) join `Location` `l` on((`l`.`location_id` = `c`.`location_id`))) join `Location` `lc` on((`lc`.`location_id` = `r`.`pickup_location_id`))) join `Address` `a` on((`a`.`address_id` = `l`.`address`))) join `Address` `ad` on((`ad`.`address_id` = `lc`.`address`)));

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
  ADD CONSTRAINT `Car_ibfk_2` FOREIGN KEY (`car_type`) REFERENCES `CarType` (`car_type`),
  ADD CONSTRAINT `Car_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `Location` (`location_id`),
  ADD CONSTRAINT `Car_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `Location` (`location_id`);

--
-- Constraints for table `CreditCard`
--
ALTER TABLE `CreditCard`
  ADD CONSTRAINT `CreditCard_ibfk_1` FOREIGN KEY (`username`) REFERENCES `Account` (`username`),
  ADD CONSTRAINT `CreditCard_ibfk_2` FOREIGN KEY (`billing_address`) REFERENCES `Address` (`address_id`),
  ADD CONSTRAINT `fk_address` FOREIGN KEY (`billing_address`) REFERENCES `Address` (`address_id`);

--
-- Constraints for table `Customer`
--
ALTER TABLE `Customer`
  ADD CONSTRAINT `Customer_ibfk_1` FOREIGN KEY (`residential_address`) REFERENCES `Address` (`address_id`);

--
-- Constraints for table `Location`
--
ALTER TABLE `Location`
  ADD CONSTRAINT `Location_ibfk_1` FOREIGN KEY (`address`) REFERENCES `Address` (`address_id`);

--
-- Constraints for table `Payment`
--
ALTER TABLE `Payment`
  ADD CONSTRAINT `Payment_ibfk_1` FOREIGN KEY (`card_number`) REFERENCES `CreditCard` (`card_number`),
  ADD CONSTRAINT `Payment_ibfk_2` FOREIGN KEY (`username`) REFERENCES `CreditCard` (`username`),
  ADD CONSTRAINT `Payment_ibfk_3` FOREIGN KEY (`reservation_id`) REFERENCES `Reservation` (`reservation_id`);

--
-- Constraints for table `Reservation`
--
ALTER TABLE `Reservation`
  ADD CONSTRAINT `Reservation_ibfk_1` FOREIGN KEY (`license_number`) REFERENCES `Account` (`license_number`),
  ADD CONSTRAINT `Reservation_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `Car` (`car_id`),
  ADD CONSTRAINT `Reservation_ibfk_3` FOREIGN KEY (`pickup_location_id`) REFERENCES `Location` (`location_id`),
  ADD CONSTRAINT `Reservation_ibfk_4` FOREIGN KEY (`drop_location_id`) REFERENCES `Location` (`location_id`),
  ADD CONSTRAINT `Reservation_ibfk_5` FOREIGN KEY (`insurance_type`) REFERENCES `Insurance` (`insurance_type`),
  ADD CONSTRAINT `Reservation_ibfk_6` FOREIGN KEY (`promo_code`) REFERENCES `Offers` (`promo_code`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`nipun03`@`%` EVENT `Count_cars_event` ON SCHEDULE EVERY '0 20' DAY_HOUR STARTS '2017-11-15 22:54:28' ON COMPLETION NOT PRESERVE ENABLE DO SELECT status, COUNT(status)
FROM Car
GROUP BY status$$

CREATE DEFINER=`nipun03`@`%` EVENT `Daily_Income` ON SCHEDULE EVERY '0 20' DAY_HOUR STARTS '2017-11-15 23:18:36' ON COMPLETION NOT PRESERVE ENABLE DO select sum(amount_paid)
from Payment
inner join Reservation using(reservation_id)
where curdate()=actual_end_date$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
