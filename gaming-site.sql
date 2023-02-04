-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 04, 2023 at 05:43 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gaming-site`
--

-- --------------------------------------------------------

--
-- Table structure for table `korisnik`
--

CREATE TABLE `korisnik` (
  `id` int(11) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `prezime` varchar(20) NOT NULL,
  `rola` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password_hash` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `korisnik`
--

INSERT INTO `korisnik` (`id`, `ime`, `prezime`, `rola`, `email`, `password_hash`) VALUES
(8, 'Aleksandar', 'Cvetkovic', 'user', 'slovnipo31@gmail.com', 'pbkdf2:sha256:260000$2wmwiwnOAXBuMrB0$477b1eb4c1a2a259f570eb8a2cb3fa1e693ee0d9a7bd7a9f1bc5e70326dcdfdd'),
(9, 'Nikola', 'Zivkovic', 'user', 'zile01@gmail.com', 'pbkdf2:sha256:260000$yzxJfbyNLf5pQJom$3c4d75c3589518aaf356c06d3618b74fa716cb752a9c22dbeea36ae8da8118ae');

-- --------------------------------------------------------

--
-- Table structure for table `produkti`
--

CREATE TABLE `produkti` (
  `id` int(11) NOT NULL,
  `ime` varchar(40) NOT NULL,
  `deskripcija` text NOT NULL,
  `cena` decimal(10,2) NOT NULL,
  `dostupnost` int(11) NOT NULL,
  `popularnost` int(11) NOT NULL,
  `popust` int(11) NOT NULL,
  `image_url` varchar(600) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produkti`
--

INSERT INTO `produkti` (`id`, `ime`, `deskripcija`, `cena`, `dostupnost`, `popularnost`, `popust`, `image_url`) VALUES
(1, 'Game name', 'Game description', '9.99', 10, 100, 0, 'https://drive.google.com/file/d/1IV9JemA_UDSIZICU0p3lEdc43XEiW-pD/view?usp=sharing'),
(2, 'Another game', 'Another game description', '14.99', 5, 200, 0, 'https://drive.google.com/file/d/1zftRpPOktERuaie0vQHd-YiCM5Tese5z/view?usp=sharing');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `korisnik`
--
ALTER TABLE `korisnik`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produkti`
--
ALTER TABLE `produkti`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `korisnik`
--
ALTER TABLE `korisnik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `produkti`
--
ALTER TABLE `produkti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
