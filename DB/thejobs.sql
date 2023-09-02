-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 02, 2023 at 08:37 PM
-- Server version: 8.0.27
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `thejobs`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `userId` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telephone` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`userId`, `name`, `address`, `email`, `telephone`) VALUES
(1, 'Manjitha Binod', 'no 19/61', 'manjithabinod@gmail.com', '+94776068848'),
(2, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `applicant`
--

CREATE TABLE `applicant` (
  `aplId` int UNSIGNED NOT NULL,
  `userId` int DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telephone` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `applicant`
--

INSERT INTO `applicant` (`aplId`, `userId`, `name`, `address`, `email`, `telephone`) VALUES
(1, 18, 'applicant1', 'no 19/61', 'manjithabinod@gmail.com', '+94776068848'),
(2, 20, 'applicant2', 'no 19/61', 'applicant2@gmail.com', '+94776068848');

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `id` int NOT NULL,
  `aplId` int DEFAULT NULL,
  `consId` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`id`, `aplId`, `consId`, `date`, `time`) VALUES
(28, 1, 9, '2023-09-03', '15:00:00'),
(27, 1, 9, '2023-09-03', '15:00:00'),
(3, 1, 9, '2023-08-28', '11:00:00'),
(30, 2, 12, '2023-09-03', '11:00:00'),
(29, 2, 9, '2023-09-03', '15:00:00'),
(26, 1, 9, '2023-09-24', '09:00:00'),
(25, 1, 9, '2023-09-02', '11:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `availabilityslot`
--

CREATE TABLE `availabilityslot` (
  `slotId` int NOT NULL,
  `consId` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `isBooked` int DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `availabilityslot`
--

INSERT INTO `availabilityslot` (`slotId`, `consId`, `date`, `startTime`, `endTime`, `isBooked`) VALUES
(1, 9, '2023-09-03', '14:00:00', '15:00:00', 0),
(2, 9, '2023-09-03', '15:00:00', '16:00:00', 1),
(3, 9, '2023-09-05', '14:00:00', '15:00:00', 0),
(4, 9, '2023-09-05', '15:00:00', '16:00:00', 0),
(5, 9, '2023-09-05', '16:00:00', '17:00:00', 0),
(6, 12, '2023-09-03', '08:00:00', '09:00:00', 0),
(7, 12, '2023-09-03', '09:00:00', '10:00:00', 0),
(8, 12, '2023-09-03', '10:00:00', '11:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `consultant`
--

CREATE TABLE `consultant` (
  `consId` int NOT NULL,
  `userId` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telephone` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `jobType` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `consultant`
--

INSERT INTO `consultant` (`consId`, `userId`, `name`, `address`, `email`, `telephone`, `country`, `jobType`) VALUES
(9, 11, 'consultant7', 'no 19/61', 'consultant7@gmail.com', '+94776068848', 'USA', 'ICT'),
(12, 19, 'consultant8', 'no 19/61', 'consultant8@gmail.com', '+94776068848', 'Sri Lanka', 'ICT');

-- --------------------------------------------------------

--
-- Table structure for table `receptionist`
--

CREATE TABLE `receptionist` (
  `repId` int UNSIGNED NOT NULL,
  `userId` int DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telephone` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `receptionist`
--

INSERT INTO `receptionist` (`repId`, `userId`, `name`, `address`, `email`, `telephone`) VALUES
(3, 16, 'receptionist1', 'no 19/61', 'receptionist1@gmail.com', '+94776068848'),
(4, 17, 'receptionist2', 'no 19/61', 'manjithabinod@gmail.com', '+94776068848');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `roleId` int NOT NULL,
  `roleName` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`roleId`, `roleName`) VALUES
(1, 'Admin'),
(2, 'Consultants'),
(3, 'Receptionist');

-- --------------------------------------------------------

--
-- Table structure for table `seekers`
--

CREATE TABLE `seekers` (
  `skId` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telephone` varchar(45) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `seekers`
--

INSERT INTO `seekers` (`skId`, `name`, `address`, `email`, `telephone`) VALUES
(1, 'applicant1 edit', 'no 19/61', 'manjithabinod@gmail.com', '0776068848');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userId` int NOT NULL,
  `userName` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `roleId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userId`, `userName`, `password`, `roleId`) VALUES
(1, 'manjithabinod@gmail.com', '$2a$10$jh7jAM3zOyjXwgTIxXDEKeVMX2s1rPCikkA4SrPHhBECfpJWOmGi.', 1),
(2, '', '$2a$10$T1YnVl2VXZhtxlZe6xXvVeT1C7.srqjym9GKXxdSqeknPO0omWXKC', 1),
(11, 'consultant7', '$2a$10$YOiPbrdTzo6bKUFwWN4t1.piMySh5TGsiUAkNU/ESYAmwJJYfl4LO', 2),
(16, 'receptionist1', '$2a$10$CKgEJbODYoydmUalVwDlSujR9ecr9jRV..jBfcuVH1jStYP117ZYC', 3),
(17, 'receptionist2', '$2a$10$628NuYmw/uDGLzH0Q/Y/4eSYiIkAbwlXg83rYG9rr5De1lmmhfqkO', 3),
(18, 'applicant1', '$2a$10$xXhVLEppaB/J3OX4udrE5.HczyDFREJbtGyg5tQ4oaYvyGhhBKjQK', 3),
(19, 'consultant8', '$2a$10$dRvTmey5Ut8zKAea9cfydOYFjTk3YKK/oMHVUVa5nW2jKCiyIy6qS', 2),
(20, 'applicant2', '$2a$10$WL5asbEVICjPsZqQbuerSuuxY8.uskeQGpB.NVGYp51Cu9gVSmKLK', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`userId`);

--
-- Indexes for table `applicant`
--
ALTER TABLE `applicant`
  ADD PRIMARY KEY (`aplId`),
  ADD KEY `userId_idx` (`userId`);

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `availabilityslot`
--
ALTER TABLE `availabilityslot`
  ADD PRIMARY KEY (`slotId`),
  ADD KEY `consId_idx` (`consId`);

--
-- Indexes for table `consultant`
--
ALTER TABLE `consultant`
  ADD PRIMARY KEY (`consId`),
  ADD UNIQUE KEY `userId_UNIQUE` (`userId`),
  ADD UNIQUE KEY `consId_UNIQUE` (`consId`);

--
-- Indexes for table `receptionist`
--
ALTER TABLE `receptionist`
  ADD PRIMARY KEY (`repId`),
  ADD KEY `useId_idx` (`userId`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`roleId`);

--
-- Indexes for table `seekers`
--
ALTER TABLE `seekers`
  ADD PRIMARY KEY (`skId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applicant`
--
ALTER TABLE `applicant`
  MODIFY `aplId` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `availabilityslot`
--
ALTER TABLE `availabilityslot`
  MODIFY `slotId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `consultant`
--
ALTER TABLE `consultant`
  MODIFY `consId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `receptionist`
--
ALTER TABLE `receptionist`
  MODIFY `repId` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `roleId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `seekers`
--
ALTER TABLE `seekers`
  MODIFY `skId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userId` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
