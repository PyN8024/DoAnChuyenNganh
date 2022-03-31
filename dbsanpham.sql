-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 18, 2022 at 09:27 AM
-- Server version: 5.7.31
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsanpham`
--

-- --------------------------------------------------------

--
-- Table structure for table `catalog`
--

DROP TABLE IF EXISTS `catalog`;
CREATE TABLE IF NOT EXISTS `catalog` (
  `catalog_id` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`catalog_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `catalog`
--

INSERT INTO `catalog` (`catalog_id`, `name`) VALUES
('AO', 'Áo'),
('QA', 'Quần'),
('TS', 'Trang sức');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `catalog_id` varchar(10) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `price` decimal(15,4) NOT NULL,
  `discount` tinyint(3) NOT NULL DEFAULT '0',
  `image` blob,
  PRIMARY KEY (`id`),
  KEY `product_ibfk_1` (`catalog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `catalog_id`, `name`, `price`, `discount`, `image`) VALUES
(3, 'AO', 'Áo khoác jean', '200000.0000', 0, NULL),
(4, 'QA', 'Quần jean', '800000.0000', 10, NULL),
(5, 'AO', 'Áo thun', '123.0000', 10, NULL),
(6, 'QA', 'Quần tây', '2000.0000', 50, NULL),
(8, 'TS', 'Vòng tay', '123456.0000', 0, NULL),
(9, 'TS', 'Đồng hồ', '700000.0000', 0, NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`catalog_id`) REFERENCES `catalog` (`catalog_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
