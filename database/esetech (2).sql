-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2025 at 10:38 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `esetech`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` int(11) NOT NULL DEFAULT 1 COMMENT '1=admin, 2=staff, 3=super admin',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=active, 2=inactive',
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `suffix` varchar(32) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `birthday` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `is_archived` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=not archived, 1=archived'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `user_type`, `status`, `first_name`, `middle_name`, `last_name`, `suffix`, `email`, `contact_number`, `birthday`, `position`, `is_archived`) VALUES
(4, 'admin', '$2y$10$30kJpHW0K6n2GqVM7YMBwuyjtIvCWThJmCGhyObUOpEtR3VPhr.GC', 1, 1, 'John', NULL, 'mark', NULL, 'dccsamaniego@bpsu.edu.ph', '909233422131', NULL, NULL, 0),
(5, 'superadmin', '$2y$10$30kJpHW0K6n2GqVM7YMBwuyjtIvCWThJmCGhyObUOpEtR3VPhr.GC', 3, 1, 'Super', NULL, 'Admin', NULL, NULL, NULL, NULL, NULL, 0),
(8, 'Akali132', '$2y$10$BhJAcTbFz60cDbIPImFhpe/VI4N8KzBp/EKlEC6I5creuG66SzV5.', 1, 1, 'Marrk', NULL, 'Caguiea1', NULL, 'markcaguia@gmail.com', '09093556323', NULL, NULL, 1),
(9, 'aya13', '$2y$10$WTUlvSq.Gi5kx/z0ZhCk6e5dlp.43NWd2/.753TiDfDoSjlqh2DaK', 1, 1, 'Jeremiah', NULL, 'Nava', NULL, 'aiahnava5@gmail.com', '09155434721', NULL, NULL, 0),
(13, 'aya', '$2y$10$kwLh0OacIB9bzg1CgsJkr./CY/o0NhvcwhM36yYa85pYWYkxuxU42', 1, 1, 'Jeremiah', 'Garay', 'Nava', '', 'aiahnava5@gmail.com', '09155434721', '2025-02-28', 'Computer Programmer I', 0);

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `attendance_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `clock_in_time` time DEFAULT NULL,
  `clock_out_time` time DEFAULT NULL,
  `total_hours` text DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attrition_forecasting`
--

CREATE TABLE `attrition_forecasting` (
  `forecast_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `prediction_date` date NOT NULL,
  `attrition_probability` decimal(5,2) NOT NULL,
  `factors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`factors`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attrition_forecasting`
--

INSERT INTO `attrition_forecasting` (`forecast_id`, `employee_id`, `prediction_date`, `attrition_probability`, `factors`) VALUES
(1, 11111, '2025-02-08', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0247}'),
(2, 22222, '2025-02-08', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0247}'),
(3, 11111, '2025-02-08', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0247}'),
(4, 22222, '2025-02-08', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0247}'),
(5, 11111, '2025-02-09', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0274}'),
(6, 22222, '2025-02-09', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0274}'),
(7, 11111, '2025-02-09', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0274}'),
(8, 22222, '2025-02-09', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0274}'),
(9, 11111, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(11, 22222, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(12, 11111, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(13, 22222, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(14, 34234, '2025-02-10', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0219}'),
(15, 11111, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(16, 22222, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(17, 34234, '2025-02-10', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0219}'),
(18, 11111, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(19, 22222, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(20, 34234, '2025-02-10', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0219}'),
(21, 11111, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(22, 22222, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(23, 34234, '2025-02-10', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0219}'),
(24, 11111, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(25, 22222, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(26, 34234, '2025-02-10', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0219}'),
(27, 11111, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(28, 22222, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(29, 34234, '2025-02-10', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0219}'),
(30, 11111, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(31, 22222, '2025-02-10', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0301}'),
(32, 34234, '2025-02-10', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0219}'),
(33, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(34, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(35, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(36, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(37, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(38, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(39, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(40, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(41, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(42, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(43, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(44, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(45, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(46, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(47, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(48, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(49, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(50, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(51, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(52, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(53, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(54, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(55, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(56, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(57, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(58, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(59, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(60, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(61, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(62, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(63, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(64, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(65, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(66, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(67, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(68, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(69, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(70, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(71, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(72, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(73, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(74, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(75, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(76, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(77, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(78, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(79, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(80, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(81, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(82, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(83, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(84, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(85, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(86, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(87, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(88, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(89, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(90, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(91, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(92, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(93, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(94, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(95, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(96, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(97, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(98, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(99, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(100, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(101, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(102, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(103, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(104, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(105, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(106, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(107, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(108, 11111, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(109, 22222, '2025-02-11', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0329}'),
(110, 34234, '2025-02-11', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0192}'),
(111, 11111, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(112, 22222, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(113, 34234, '2025-02-12', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0164}'),
(114, 11111, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(115, 22222, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(116, 34234, '2025-02-12', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0164}'),
(117, 11111, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(118, 22222, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(119, 34234, '2025-02-12', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0164}'),
(120, 11111, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(121, 22222, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(122, 34234, '2025-02-12', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0164}'),
(123, 11111, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(124, 22222, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(125, 34234, '2025-02-12', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0164}'),
(126, 11111, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(127, 21313, '2025-02-12', 0.78, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":2.0521}'),
(128, 22222, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(129, 34234, '2025-02-12', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0164}'),
(130, 11111, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(131, 21313, '2025-02-12', 0.78, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":2.0521}'),
(132, 22222, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(133, 34234, '2025-02-12', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0164}'),
(134, 11111, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(135, 21313, '2025-02-12', 0.78, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":2.0521}'),
(136, 22222, '2025-02-12', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0356}'),
(137, 34234, '2025-02-12', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0164}'),
(138, 11111, '2025-02-13', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0384}'),
(139, 21313, '2025-02-13', 0.78, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":2.0548}'),
(140, 22222, '2025-02-13', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0384}'),
(141, 34234, '2025-02-13', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":-0.0137}'),
(142, 25001, '2025-02-25', 0.72, '{\"attendance_score\":0.25,\"satisfaction_score\":0.5,\"years_of_service\":0.0082}'),
(143, 25002, '2025-02-25', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0.0082}'),
(144, 25001, '2025-02-22', 0.53, '{\"attendance_score\":0.25,\"satisfaction_score\":1,\"years_of_service\":0}'),
(145, 25002, '2025-02-22', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0}'),
(146, 25001, '2025-02-22', 0.53, '{\"attendance_score\":0.25,\"satisfaction_score\":1,\"years_of_service\":0}'),
(147, 25002, '2025-02-22', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0}'),
(148, 25001, '2025-02-22', 0.53, '{\"attendance_score\":0.25,\"satisfaction_score\":1,\"years_of_service\":0}'),
(149, 25002, '2025-02-22', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0}'),
(150, 25001, '2025-02-22', 0.53, '{\"attendance_score\":0.25,\"satisfaction_score\":1,\"years_of_service\":0}'),
(151, 25002, '2025-02-22', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0}'),
(152, 25001, '2025-02-22', 0.53, '{\"attendance_score\":0.25,\"satisfaction_score\":1,\"years_of_service\":0}'),
(153, 25002, '2025-02-22', 0.65, '{\"attendance_score\":0.5,\"satisfaction_score\":0.5,\"years_of_service\":0}'),
(154, 24002, '2025-02-27', 0.79, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.074}'),
(155, 25001, '2025-02-27', 0.56, '{\"attendance_score\":0.125,\"satisfaction_score\":1,\"years_of_service\":0.0137}'),
(156, 24002, '2025-02-27', 0.79, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.074}'),
(157, 25001, '2025-02-27', 0.56, '{\"attendance_score\":0.125,\"satisfaction_score\":1,\"years_of_service\":0.0137}'),
(158, 24002, '2025-02-27', 0.79, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.074}'),
(159, 25001, '2025-02-27', 0.56, '{\"attendance_score\":0.125,\"satisfaction_score\":1,\"years_of_service\":0.0137}'),
(160, 25003, '2025-02-27', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":0}'),
(161, 23004, '2025-02-28', 0.78, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.7479}'),
(162, 24002, '2025-02-28', 0.79, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.0767}'),
(163, 25001, '2025-02-28', 0.55, '{\"attendance_score\":0.16667,\"satisfaction_score\":1,\"years_of_service\":0.0164}'),
(164, 25003, '2025-02-28', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":0.0027}'),
(165, 23004, '2025-02-28', 0.78, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.7479}'),
(166, 24002, '2025-02-28', 0.79, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.0767}'),
(167, 25001, '2025-02-28', 0.55, '{\"attendance_score\":0.16667,\"satisfaction_score\":1,\"years_of_service\":0.0164}'),
(168, 25003, '2025-02-28', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":0.0027}'),
(169, 24002, '2025-02-28', 0.79, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.0767}'),
(170, 25001, '2025-02-28', 0.55, '{\"attendance_score\":0.16667,\"satisfaction_score\":1,\"years_of_service\":0.0164}'),
(171, 25003, '2025-02-28', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":0.0027}'),
(172, 24002, '2025-02-28', 0.79, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.0767}'),
(173, 25001, '2025-02-28', 0.55, '{\"attendance_score\":0.16667,\"satisfaction_score\":1,\"years_of_service\":0.0164}'),
(174, 25003, '2025-02-28', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":0.0027}'),
(175, 24002, '2025-02-28', 0.79, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.0767}'),
(176, 25001, '2025-02-28', 0.55, '{\"attendance_score\":0.16667,\"satisfaction_score\":1,\"years_of_service\":0.0164}'),
(177, 25003, '2025-02-28', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":0.0027}'),
(178, 24002, '2025-02-28', 0.79, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":1.0767}'),
(179, 25001, '2025-02-28', 0.55, '{\"attendance_score\":0.16667,\"satisfaction_score\":1,\"years_of_service\":0.0164}'),
(180, 25003, '2025-02-28', 0.80, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"years_of_service\":0.0027}'),
(181, 24002, '2025-02-28', 0.87, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"performance_score\":0,\"years_of_service\":1.0767}'),
(182, 25001, '2025-02-28', 0.70, '{\"attendance_score\":0.16667,\"satisfaction_score\":1,\"performance_score\":0.05,\"years_of_service\":0.0164}'),
(183, 25003, '2025-02-28', 0.87, '{\"attendance_score\":0,\"satisfaction_score\":0.5,\"performance_score\":0,\"years_of_service\":0.0027}');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `dept_name` varchar(50) NOT NULL,
  `colors` varchar(32) NOT NULL,
  `is_archived` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `dept_name`, `colors`, `is_archived`) VALUES
(2, 'Chemical', '#ff8787', 1),
(3, 'Procurement', '#f783ac', 1),
(4, 'Sales', '#da77f2', 1),
(5, 'Sales & Marketing', '#9775fa', 0),
(6, 'Technical', '#748ffc', 0),
(7, 'Technical Sales', '#4dabf7', 0),
(14, 'Admin', '#3bc9db', 0);

-- --------------------------------------------------------

--
-- Table structure for table `educational_backgrounds`
--

CREATE TABLE `educational_backgrounds` (
  `id` int(11) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) NOT NULL,
  `suffix` varchar(255) NOT NULL,
  `gender` varchar(32) NOT NULL,
  `email` varchar(100) NOT NULL,
  `position` varchar(255) NOT NULL,
  `hire_date` date NOT NULL,
  `department` varchar(255) NOT NULL,
  `employment_status` varchar(255) NOT NULL,
  `employee_id` int(20) NOT NULL,
  `user_type` int(11) NOT NULL DEFAULT 2 COMMENT '1=admin, 2=staff, 3=super admin',
  `password` varchar(255) NOT NULL,
  `e_status` int(11) NOT NULL DEFAULT 1,
  `date_of_birth` date DEFAULT NULL,
  `age` varchar(32) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `perma_address` text DEFAULT NULL,
  `civil_status` varchar(10) DEFAULT NULL,
  `sss_number` varchar(15) DEFAULT NULL,
  `philhealth_number` varchar(15) DEFAULT NULL,
  `pagibig_number` varchar(15) DEFAULT NULL,
  `tin_number` varchar(15) DEFAULT NULL,
  `emergency_contact_name` varchar(50) DEFAULT NULL,
  `emergency_contact_number` varchar(15) DEFAULT NULL,
  `educational_background` enum('Technical-Vocational Program graduate','College graduate','Master''s degree graduate','Doctorate degree graduate') DEFAULT NULL,
  `skills` text DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `sick_leave` int(11) NOT NULL DEFAULT 0,
  `vacation_leave` int(11) NOT NULL DEFAULT 0,
  `maternity_leave` int(11) NOT NULL DEFAULT 0,
  `paternity_leave` int(11) NOT NULL DEFAULT 0,
  `medical` varchar(32) DEFAULT NULL,
  `tor` varchar(32) DEFAULT NULL,
  `nbi_clearance` varchar(32) DEFAULT NULL,
  `resume` varchar(32) DEFAULT NULL,
  `prc` varchar(32) DEFAULT NULL,
  `others` varchar(32) DEFAULT NULL,
  `medical_type` varchar(32) DEFAULT NULL,
  `tor_type` varchar(32) DEFAULT NULL,
  `police_type` varchar(32) DEFAULT NULL,
  `resume_type` varchar(32) DEFAULT NULL,
  `prc_type` varchar(32) DEFAULT NULL,
  `others_type` varchar(32) DEFAULT NULL,
  `is_archived` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `e_recommendations`
--

CREATE TABLE `e_recommendations` (
  `recommendation_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `recommendation_type` enum('Promotion','Demotion','Retrenchment') NOT NULL,
  `reason` text DEFAULT NULL,
  `effective_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_satisfaction_form_status`
--

CREATE TABLE `job_satisfaction_form_status` (
  `status_id` int(11) NOT NULL,
  `status` enum('Open','Closed') NOT NULL DEFAULT 'Closed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_satisfaction_form_status`
--

INSERT INTO `job_satisfaction_form_status` (`status_id`, `status`) VALUES
(1, 'Open');

-- --------------------------------------------------------

--
-- Table structure for table `job_satisfaction_surveys`
--

CREATE TABLE `job_satisfaction_surveys` (
  `survey_id` int(11) NOT NULL,
  `employee_id` int(20) NOT NULL,
  `survey_date` date NOT NULL,
  `questions` longtext NOT NULL CHECK (json_valid(`questions`)),
  `overall_rating` decimal(5,2) NOT NULL,
  `rating_description` varchar(50) GENERATED ALWAYS AS (case when `overall_rating` between 4.00 and 5.00 then 'Very Satisfied' when `overall_rating` between 3.00 and 3.99 then 'Neutral' when `overall_rating` between 1.00 and 2.99 then 'Very Dissatisfied' else 'Undefined' end) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_satisfaction_surveys`
--

INSERT INTO `job_satisfaction_surveys` (`survey_id`, `employee_id`, `survey_date`, `questions`, `overall_rating`) VALUES
(6, 25001, '2025-02-22', '{\"clarity_of_responsibilities\":\"5\",\"work_environment\":\"5\",\"work_life_balance\":\"5\",\"manager_support\":\"5\",\"team_collaboration\":\"5\",\"compensation\":\"5\",\"career_growth\":\"5\"}', 5.00);

-- --------------------------------------------------------

--
-- Table structure for table `leave_applications`
--

CREATE TABLE `leave_applications` (
  `leave_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `leave_type` enum('Sick','Vacation','Paternity','Maternity') NOT NULL,
  `file_date` varchar(32) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `number_of_days` varchar(32) NOT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `monthly_attendance`
--

CREATE TABLE `monthly_attendance` (
  `monthly_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `month_year` date NOT NULL,
  `days_present` int(11) NOT NULL DEFAULT 0,
  `days_absent` int(11) NOT NULL DEFAULT 0,
  `days_late` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `performance_criteria`
--

CREATE TABLE `performance_criteria` (
  `id` int(11) NOT NULL,
  `description` varchar(150) NOT NULL,
  `is_archived` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `performance_criteria`
--

INSERT INTO `performance_criteria` (`id`, `description`, `is_archived`) VALUES
(1, 'Attitude', 0),
(2, 'Performance', 0),
(3, 'try', 0);

-- --------------------------------------------------------

--
-- Table structure for table `performance_evaluations`
--

CREATE TABLE `performance_evaluations` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `evaluation_date` date NOT NULL,
  `criteria` text NOT NULL,
  `comments` text DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `overall_score` decimal(5,2) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `performance_evaluations`
--

INSERT INTO `performance_evaluations` (`id`, `employee_id`, `admin_id`, `evaluation_date`, `criteria`, `comments`, `remarks`, `overall_score`, `status`) VALUES
(1, 25001, 1, '2025-02-27', '{\"Attitude\":5,\"Performance\":5,\"try\":5}', 'Good job', 'Very Effective', 5.00, 'Completed');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `report_id` int(11) NOT NULL,
  `report_type` varchar(50) NOT NULL,
  `generated_date` date NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`attendance_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `attrition_forecasting`
--
ALTER TABLE `attrition_forecasting`
  ADD PRIMARY KEY (`forecast_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `educational_backgrounds`
--
ALTER TABLE `educational_backgrounds`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_id_unique` (`employee_id`),
  ADD UNIQUE KEY `e_username` (`username`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `e_recommendations`
--
ALTER TABLE `e_recommendations`
  ADD PRIMARY KEY (`recommendation_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `job_satisfaction_form_status`
--
ALTER TABLE `job_satisfaction_form_status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `job_satisfaction_surveys`
--
ALTER TABLE `job_satisfaction_surveys`
  ADD PRIMARY KEY (`survey_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `leave_applications`
--
ALTER TABLE `leave_applications`
  ADD PRIMARY KEY (`leave_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `monthly_attendance`
--
ALTER TABLE `monthly_attendance`
  ADD PRIMARY KEY (`monthly_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `performance_criteria`
--
ALTER TABLE `performance_criteria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `performance_evaluations`
--
ALTER TABLE `performance_evaluations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`report_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attrition_forecasting`
--
ALTER TABLE `attrition_forecasting`
  MODIFY `forecast_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `educational_backgrounds`
--
ALTER TABLE `educational_backgrounds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `e_recommendations`
--
ALTER TABLE `e_recommendations`
  MODIFY `recommendation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_satisfaction_form_status`
--
ALTER TABLE `job_satisfaction_form_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `job_satisfaction_surveys`
--
ALTER TABLE `job_satisfaction_surveys`
  MODIFY `survey_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `leave_applications`
--
ALTER TABLE `leave_applications`
  MODIFY `leave_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `monthly_attendance`
--
ALTER TABLE `monthly_attendance`
  MODIFY `monthly_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `performance_criteria`
--
ALTER TABLE `performance_criteria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `performance_evaluations`
--
ALTER TABLE `performance_evaluations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `job_satisfaction_surveys`
--
ALTER TABLE `job_satisfaction_surveys`
  ADD CONSTRAINT `job_satisfaction_surveys_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
