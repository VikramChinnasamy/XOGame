-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 30, 2024 at 11:36 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vkdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `dresults`
--

CREATE TABLE `dresults` (
  `Matches` varchar(60) NOT NULL,
  `WinPlayer1` varchar(60) NOT NULL,
  `WinPlayer2` varchar(60) NOT NULL,
  `losses1` varchar(60) NOT NULL,
  `losses2` varchar(60) NOT NULL,
  `draws1` varchar(60) NOT NULL,
  `draws2` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dresults`
--

INSERT INTO `dresults` (`Matches`, `WinPlayer1`, `WinPlayer2`, `losses1`, `losses2`, `draws1`, `draws2`) VALUES
('2', '1', '0', '0', '1', '1', '1'),
('3', '1', '1', '1', '1', '1', '1');

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

CREATE TABLE `matches` (
  `total` int(50) NOT NULL,
  `winX` int(50) NOT NULL,
  `winY` int(50) NOT NULL,
  `lossX` int(50) NOT NULL,
  `lossY` int(50) NOT NULL,
  `drawX` int(50) NOT NULL,
  `drawY` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `matches`
--

INSERT INTO `matches` (`total`, `winX`, `winY`, `lossX`, `lossY`, `drawX`, `drawY`) VALUES
(1, 1, 0, 0, 1, 0, 0),
(2, 2, 0, 0, 2, 0, 0),
(0, 0, 0, 0, 0, 0, 0),
(1, 1, 0, 0, 1, 0, 0),
(1, 1, 0, 0, 1, 0, 0),
(4, 2, 1, 0, 3, 1, 1),
(1, 0, 1, 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `student_table`
--

CREATE TABLE `student_table` (
  `id` varchar(50) NOT NULL,
  `name` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_table`
--

INSERT INTO `student_table` (`id`, `name`, `password`, `email`, `phone`) VALUES
('1', 'Vikram', '12345', 'vikram@gmail.com', '9025762447'),
('1', 'Vikram', '12345', 'vikram@gmail.com', '9025762447'),
('1', 'Vikram', '12345', 'vikram@gmail.com', '9025762447'),
('5', 'jeeva', '123', 'jeeva@gmail.com', '7708662557'),
('6', 'jee', '123', 'jeeva@gmail.com', '8765'),
('10', 'Vikram', '1234567890', 'vikram@gmail.com', '7708662557');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
