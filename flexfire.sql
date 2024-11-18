-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 11, 2024 at 08:07 AM
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
-- Database: `flexfire`
--

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `id` int(11) NOT NULL,
  `class_title` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `start_date` date NOT NULL,
  `time_period` enum('Less Than One Month','One Month','Two Month','Three Month','Four Month','Five Month','Six Month','More Than Six Month') NOT NULL,
  `no_of_sessions` int(11) NOT NULL,
  `class_date` varchar(255) NOT NULL,
  `trainerId` int(11) DEFAULT NULL,
  `status` varchar(10) DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`id`, `class_title`, `amount`, `start_date`, `time_period`, `no_of_sessions`, `class_date`, `trainerId`, `status`) VALUES
(15, 'yoga training', 12000.00, '2024-08-12', 'One Month', 12, 'every sunday from 8.00 am', 10, 'pending'),
(16, 'mental health', 12000.00, '2024-08-12', 'Three Month', 20, 'Monday 4.00pm', 11, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `subscribedsessions`
--

CREATE TABLE `subscribedsessions` (
  `subId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `trainerId` int(11) DEFAULT NULL,
  `session_title` varchar(255) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscribedsessions`
--

INSERT INTO `subscribedsessions` (`subId`, `userId`, `trainerId`, `session_title`, `payment_date`) VALUES
(5, 9, 10, 'yoga training', '2024-08-11 03:25:34'),
(6, 9, 10, 'yoga training', '2024-08-11 05:41:26');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL,
  `accountStatus` enum('active','inactive') NOT NULL,
  `password` varchar(255) NOT NULL,
  `availability` enum('yes','no') DEFAULT 'no',
  `expertise` varchar(255) DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstName`, `lastName`, `email`, `role`, `accountStatus`, `password`, `availability`, `expertise`) VALUES
(3, 'admin', 'admin', 'admin@gmail.com', 'admin', 'active', 'ecd00aa1acd325ba7575cb0f638b04a5', 'yes', 'none'),
(9, 'yeran', 'lakvidu', 'yeran@gmail.com', 'member', 'active', '9751a21bcec190d1327372eba44a5b16', 'no', 'none'),
(10, 'sathil', 'lakvidu', 'sathil@gmail.com', 'trainer', 'active', 'b8dda46a1bdf603857164ba2a4b62db7', 'yes', 'yoga'),
(11, 'yeran', 'bimsara', 'designs.yeran@gmail.com', 'trainer', 'active', '28bb7f05cf9fff2981f994b1a91a238b', 'yes', 'nutrition_coaching');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trainerId` (`trainerId`);

--
-- Indexes for table `subscribedsessions`
--
ALTER TABLE `subscribedsessions`
  ADD PRIMARY KEY (`subId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `trainerId` (`trainerId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `subscribedsessions`
--
ALTER TABLE `subscribedsessions`
  MODIFY `subId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`trainerId`) REFERENCES `users` (`id`);

--
-- Constraints for table `subscribedsessions`
--
ALTER TABLE `subscribedsessions`
  ADD CONSTRAINT `subscribedsessions_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscribedsessions_ibfk_2` FOREIGN KEY (`trainerId`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
