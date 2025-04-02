-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2024 at 12:50 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soalpedia`
--

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `id_mapel` int(11) NOT NULL DEFAULT 0,
  `kategori` varchar(50) DEFAULT NULL,
  `kelas` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `id_mapel`, `kategori`, `kelas`) VALUES
(1, 1, 'Matriks', '11');

-- --------------------------------------------------------

--
-- Table structure for table `komentar`
--

CREATE TABLE `komentar` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `komentar` text DEFAULT NULL,
  `id_kategori` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `krisan`
--

CREATE TABLE `krisan` (
  `id` int(11) NOT NULL,
  `kritik` text DEFAULT NULL,
  `saran` text DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mapel`
--

CREATE TABLE `mapel` (
  `id` int(11) NOT NULL,
  `pelajaran` varchar(50) NOT NULL,
  `img` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mapel`
--

INSERT INTO `mapel` (`id`, `pelajaran`, `img`) VALUES
(1, 'Matematika', 'matematika.svg'),
(2, 'Bahasa Indonesia', 'bindo.svg'),
(3, 'Pendidikan Agama Islam', 'pai.svg'),
(4, 'Pendidikan Pancasila', 'pancasila.svg'),
(5, 'Ilmu Pengetahuan Alam', 'mipa.svg'),
(6, 'Pendidikan Jasmani', 'olahraga.svg'),
(7, 'Seni Budaya', 'senbud.svg'),
(8, 'Ilmu Pengetahuan Sosial', 'geografi.svg');

-- --------------------------------------------------------

--
-- Table structure for table `master_soal`
--

CREATE TABLE `master_soal` (
  `id` int(11) NOT NULL,
  `id_kategori` int(11) DEFAULT NULL,
  `nama_file` varchar(255) DEFAULT NULL,
  `id_pemilik` int(11) DEFAULT NULL,
  `tgl` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_soal`
--

INSERT INTO `master_soal` (`id`, `id_kategori`, `nama_file`, `id_pemilik`, `tgl`) VALUES
(1, 1, 'Ruang Vektor 1.pdf', 2, '2023-12-24');

-- --------------------------------------------------------

--
-- Table structure for table `pelaporan`
--

CREATE TABLE `pelaporan` (
  `id` int(11) NOT NULL,
  `id_soal` int(11) DEFAULT NULL,
  `masalah` text DEFAULT NULL,
  `id_file` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelaporan`
--

INSERT INTO `pelaporan` (`id`, `id_soal`, `masalah`, `id_file`) VALUES
(1, 1, 'Kesalahan Teknis', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pilihan`
--

CREATE TABLE `pilihan` (
  `id` int(11) NOT NULL,
  `id_soal` int(11) DEFAULT NULL,
  `teks_pilihan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pilihan`
--

INSERT INTO `pilihan` (`id`, `id_soal`, `teks_pilihan`) VALUES
(1, 1, '1'),
(2, 1, '2'),
(3, 1, '3'),
(4, 1, '4');

-- --------------------------------------------------------

--
-- Table structure for table `soal`
--

CREATE TABLE `soal` (
  `id` int(11) NOT NULL,
  `pertanyaan` text DEFAULT NULL,
  `id_kategori` int(11) DEFAULT NULL,
  `kesulitan` enum('mudah','sulit') DEFAULT 'mudah',
  `jawaban` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `soal`
--

INSERT INTO `soal` (`id`, `pertanyaan`, `id_kategori`, `kesulitan`, `jawaban`) VALUES
(1, '2*2', 1, 'mudah', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('siswa','guru','admin','editor') NOT NULL DEFAULT 'siswa',
  `username` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `nama`, `password`, `role`, `username`) VALUES
(1, 'luthfi@gmail.com', 'Luthfi', '$2y$10$2xN6p3LGJtYCRFvErNxaj.x/kt/NjWRnkJ29AO3vwllzrZ//PTrMa', 'siswa', 'luthfi'),
(2, 'seblak@gmail.com', 'Seblak', '$2y$10$ExwAj8P4YQFZRmYhGH04Su5fkgeaSqMAzsYYi2rqx5z8Wnh3mYjtW', 'guru', 'seblak'),
(3, 'admin@gmail.com', 'admin', '$2y$10$0/BTk7Fo2RwBk1fLspScSO7Vh4deAxODEjVHHFM6bqi/CNG73LHQG', 'admin', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_kategori_mapel` (`id_mapel`);

--
-- Indexes for table `komentar`
--
ALTER TABLE `komentar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_komentar_user` (`id_user`),
  ADD KEY `FK_komentar_kategori` (`id_kategori`);

--
-- Indexes for table `krisan`
--
ALTER TABLE `krisan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mapel`
--
ALTER TABLE `mapel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_soal`
--
ALTER TABLE `master_soal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_file_soal_kategori` (`id_kategori`),
  ADD KEY `FK_master_soal_user` (`id_pemilik`);

--
-- Indexes for table `pelaporan`
--
ALTER TABLE `pelaporan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_pelaporan_soal` (`id_soal`),
  ADD KEY `FK_pelaporan_master_soal` (`id_file`);

--
-- Indexes for table `pilihan`
--
ALTER TABLE `pilihan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_pilihan_soal` (`id_soal`);

--
-- Indexes for table `soal`
--
ALTER TABLE `soal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_soal_kategori` (`id_kategori`),
  ADD KEY `FK_soal_pilihan` (`jawaban`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `komentar`
--
ALTER TABLE `komentar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `krisan`
--
ALTER TABLE `krisan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mapel`
--
ALTER TABLE `mapel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `master_soal`
--
ALTER TABLE `master_soal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pelaporan`
--
ALTER TABLE `pelaporan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pilihan`
--
ALTER TABLE `pilihan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `soal`
--
ALTER TABLE `soal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kategori`
--
ALTER TABLE `kategori`
  ADD CONSTRAINT `FK_kategori_mapel` FOREIGN KEY (`id_mapel`) REFERENCES `mapel` (`id`);

--
-- Constraints for table `komentar`
--
ALTER TABLE `komentar`
  ADD CONSTRAINT `FK_komentar_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`),
  ADD CONSTRAINT `FK_komentar_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `master_soal`
--
ALTER TABLE `master_soal`
  ADD CONSTRAINT `FK_file_soal_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`),
  ADD CONSTRAINT `FK_master_soal_user` FOREIGN KEY (`id_pemilik`) REFERENCES `user` (`id`);

--
-- Constraints for table `pelaporan`
--
ALTER TABLE `pelaporan`
  ADD CONSTRAINT `FK_pelaporan_master_soal` FOREIGN KEY (`id_file`) REFERENCES `master_soal` (`id`),
  ADD CONSTRAINT `FK_pelaporan_soal` FOREIGN KEY (`id_soal`) REFERENCES `soal` (`id`);

--
-- Constraints for table `pilihan`
--
ALTER TABLE `pilihan`
  ADD CONSTRAINT `FK_pilihan_soal` FOREIGN KEY (`id_soal`) REFERENCES `soal` (`id`);

--
-- Constraints for table `soal`
--
ALTER TABLE `soal`
  ADD CONSTRAINT `FK_soal_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`),
  ADD CONSTRAINT `FK_soal_pilihan` FOREIGN KEY (`jawaban`) REFERENCES `pilihan` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
