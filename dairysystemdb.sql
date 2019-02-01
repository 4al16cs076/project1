-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2019 at 02:32 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dairysystemdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Session` (IN `AcuntN` INT, IN `Fat` VARCHAR(20), IN `Time` VARCHAR(20), IN `Litres` INT(11), IN `Remarks` VARCHAR(150))  NO SQL
BEGIN
DECLARE TotalPrize INT;
SET @prz := (SELECT Prize  from fatset where Fatrange=Fat);
SELECT @prz;
SET TotalPrize = Litres * @prz;
insert into sessiondata(AcuntNo,Date,Time,Litres,Fat,TotalPrize,Remarks) values(AcuntN,NOW(),Time,Litres,Fat,TotalPrize,Remarks);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `userdata` (IN `addre` VARCHAR(20), IN `mobile` VARCHAR(20), IN `cattle` VARCHAR(20), IN `AcuntNb` INT)  BEGIN
 IF addre <> '' THEN
	update userdata set Address=addre where AcuntNo=AcuntNb;
 END IF;
 IF mobile <> '' THEN 
	update userdata set MobileNo=mobile where AcuntNo=AcuntNb;
 END IF;
 IF cattle <> '' THEN
    update userdata set cattleType=cattle where           AcuntNo=AcuntNb;
 END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `addnewacunt`
--

CREATE TABLE `addnewacunt` (
  `AcuntNo` int(11) NOT NULL,
  `Fname` varchar(20) DEFAULT NULL,
  `Lname` varchar(20) DEFAULT NULL,
  `Passward` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `addnewacunt`
--

INSERT INTO `addnewacunt` (`AcuntNo`, `Fname`, `Lname`, `Passward`) VALUES
(20, 'Rakshith', 'R', '123456'),
(21, 'Prasanna', 'K L', '12345'),
(22, 'Manju', 'Y', '12345'),
(23, 'Vishal', 'M', '12345'),
(24, 'Ramesh', 'M', '12345'),
(25, 'Manoj', 'L', '123456'),
(26, 'Sanju', 'N', '123456'),
(27, 'Harish', 'k', '123456'),
(28, 'Vishnu', 'J', '123456');

--
-- Triggers `addnewacunt`
--
DELIMITER $$
CREATE TRIGGER `AFTER_AddnewAcunt_insert` AFTER INSERT ON `addnewacunt` FOR EACH ROW BEGIN
INSERT INTO UserData
SET action ='insert',
AcuntNo=NEW.AcuntNo,
Fname=NEW.Fname,
Lname=NEW.Lname;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admindb`
--

CREATE TABLE `admindb` (
  `Adminid` varchar(20) NOT NULL,
  `Adname` varchar(20) DEFAULT NULL,
  `passward` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admindb`
--

INSERT INTO `admindb` (`Adminid`, `Adname`, `passward`) VALUES
('A1', 'Ravi', '9731612058'),
('A2', 'Karthick', '9731612058');

-- --------------------------------------------------------

--
-- Table structure for table `fatset`
--

CREATE TABLE `fatset` (
  `Fatrange` varchar(20) DEFAULT NULL,
  `Prize` int(11) DEFAULT NULL,
  `Time` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fatset`
--

INSERT INTO `fatset` (`Fatrange`, `Prize`, `Time`) VALUES
('7to10', 25, 'Morning'),
('11to14', 30, 'Afternoon'),
('15to18', 35, 'Evening');

-- --------------------------------------------------------

--
-- Table structure for table `sessiondata`
--

CREATE TABLE `sessiondata` (
  `AcuntNo` int(11) NOT NULL,
  `Date` date DEFAULT NULL,
  `Time` varchar(20) NOT NULL,
  `Litres` int(11) NOT NULL,
  `Fat` int(11) NOT NULL,
  `TotalPrize` varchar(20) NOT NULL,
  `Remarks` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessiondata`
--

INSERT INTO `sessiondata` (`AcuntNo`, `Date`, `Time`, `Litres`, `Fat`, `TotalPrize`, `Remarks`) VALUES
(20, '2018-11-30', 'Morning', 15, 11, '450', 'NotHygiene'),
(20, '2018-11-30', 'Evening', 13, 15, '455', 'NotHygiene'),
(20, '2018-12-01', 'Morning', 15, 11, '450', 'Hygiene'),
(20, '2018-12-01', 'Morning', 15, 11, '450', 'NotHygiene'),
(20, '2018-12-01', 'Evening', 14, 7, '350', 'Hygiene'),
(20, '2018-12-01', 'Evening', 12, 15, '420', 'NotHygiene'),
(20, '2018-12-01', 'Morning', 16, 11, '480', 'NotHygiene'),
(20, '2018-12-01', 'Morning', 15, 7, '375', 'Hygiene'),
(20, '2018-12-01', 'Evening', 11, 7, '275', 'NotHygiene'),
(20, '2018-12-01', 'Evening', 10, 15, '350', 'NotHygiene'),
(20, '2018-12-01', 'Morning', 12, 7, '300', 'Hygiene'),
(25, '2018-12-04', 'Morning', 15, 11, '450', 'NotHygiene'),
(26, '2018-12-06', 'Morning', 15, 11, '450', 'Hygiene'),
(27, '2018-12-07', 'Evening', 15, 11, '450', 'Hygiene'),
(28, '2018-12-07', 'Morning', 15, 7, '375', 'Remarks');

-- --------------------------------------------------------

--
-- Table structure for table `userdata`
--

CREATE TABLE `userdata` (
  `AcuntNo` int(11) NOT NULL,
  `Fname` varchar(20) NOT NULL,
  `Lname` varchar(20) NOT NULL,
  `Address` varchar(20) NOT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `cattleType` varchar(20) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userdata`
--

INSERT INTO `userdata` (`AcuntNo`, `Fname`, `Lname`, `Address`, `MobileNo`, `cattleType`, `action`) VALUES
(20, 'Rakshith', 'R', 'Siddapura', '8022124473', 'cow', 'insert'),
(21, 'Prasanna', 'K L', 'Udupi', '8012453665', 'Buffalo', 'insert'),
(22, 'Manju', 'Y', 'Mijar', '9912456326', 'cow', 'insert'),
(23, 'Vishal', 'M', 'Moodabidre', '9632156480', 'Buffalo', 'insert'),
(24, 'Ramesh', 'M', 'Thodar', '4564556525', 'Buffalo', 'insert'),
(25, 'Manoj', 'L', 'Banglore', '7338471604', 'Buffelo', 'insert'),
(26, 'Sanju', 'N', 'Mudradi', '8823152026', 'cow', 'insert'),
(27, 'Harish', 'k', 'Mijar', '562315423', 'Buffelo', 'insert'),
(28, 'Vishnu', 'J', 'Mijar', '9543152623', 'Cow', 'insert');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addnewacunt`
--
ALTER TABLE `addnewacunt`
  ADD PRIMARY KEY (`AcuntNo`);

--
-- Indexes for table `admindb`
--
ALTER TABLE `admindb`
  ADD PRIMARY KEY (`Adminid`);

--
-- Indexes for table `sessiondata`
--
ALTER TABLE `sessiondata`
  ADD KEY `AcuntNo` (`AcuntNo`);

--
-- Indexes for table `userdata`
--
ALTER TABLE `userdata`
  ADD KEY `AcuntNo` (`AcuntNo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addnewacunt`
--
ALTER TABLE `addnewacunt`
  MODIFY `AcuntNo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sessiondata`
--
ALTER TABLE `sessiondata`
  ADD CONSTRAINT `sessiondata_ibfk_1` FOREIGN KEY (`AcuntNo`) REFERENCES `addnewacunt` (`AcuntNo`) ON DELETE CASCADE;

--
-- Constraints for table `userdata`
--
ALTER TABLE `userdata`
  ADD CONSTRAINT `userdata_ibfk_1` FOREIGN KEY (`AcuntNo`) REFERENCES `addnewacunt` (`AcuntNo`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
