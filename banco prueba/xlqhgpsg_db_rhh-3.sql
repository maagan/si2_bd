-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2018 at 04:32 PM
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
-- Database: `xlqhgpsg_db_rhh`
--

-- --------------------------------------------------------

--
-- Table structure for table `analisis`
--

CREATE TABLE `analisis` (
  `cod` int(11) NOT NULL,
  `cod_diagnostico` int(11) NOT NULL,
  `ci_paciente_diagnostico` int(10) UNSIGNED NOT NULL,
  `fecha_orden` date NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `fecha_realizado` date NOT NULL,
  `resultado` text NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cargo`
--

CREATE TABLE `cargo` (
  `id_hostpital` int(10) UNSIGNED NOT NULL,
  `ci_enfermera` int(10) UNSIGNED NOT NULL,
  `funcion` varchar(50) NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cirugia`
--

CREATE TABLE `cirugia` (
  `cod` int(11) NOT NULL,
  `cod_diagnostico` int(11) NOT NULL,
  `ci_paciente_diagnostico` int(10) UNSIGNED NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `fecha` date NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `consultorio`
--

CREATE TABLE `consultorio` (
  `id_hostpital` int(10) UNSIGNED NOT NULL,
  `ci_doctor` int(10) UNSIGNED NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `numero` int(11) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `diagnostico`
--

CREATE TABLE `diagnostico` (
  `cod` int(11) NOT NULL,
  `ci_paciente` int(10) UNSIGNED NOT NULL,
  `ci_doctor` int(10) UNSIGNED DEFAULT NULL,
  `descripcion` varchar(50) NOT NULL,
  `fecha` date NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `ci_persona` int(10) UNSIGNED NOT NULL,
  `especialidad` varchar(50) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `empresa`
--

CREATE TABLE `empresa` (
  `cod` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `empresa_hospital`
--

CREATE TABLE `empresa_hospital` (
  `id_hostpital` int(10) UNSIGNED NOT NULL,
  `cod_empresa` int(10) UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `enfermera`
--

CREATE TABLE `enfermera` (
  `ci_persona` int(10) UNSIGNED NOT NULL,
  `especialidad` varchar(50) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hospital`
--

CREATE TABLE `hospital` (
  `id` int(10) UNSIGNED NOT NULL,
  `cod` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `intervencion`
--

CREATE TABLE `intervencion` (
  `ci_doctor` int(10) UNSIGNED NOT NULL,
  `cod_cirugia` int(11) NOT NULL,
  `cod_diagnostico_cirugia` int(11) NOT NULL,
  `ci_paciente_diagnostico_cirugia` int(10) UNSIGNED NOT NULL,
  `funcion` varchar(50) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `medicacion`
--

CREATE TABLE `medicacion` (
  `cod` int(11) NOT NULL,
  `cod_padecimiento` int(11) NOT NULL,
  `cod_diagnostico_padecimiento` int(11) NOT NULL,
  `ci_paciente_diagnostico_padecimiento` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `indicacion` text,
  `tratamiento` text,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_11_05_061844_entrust_setup_tables', 2);

-- --------------------------------------------------------

--
-- Table structure for table `paciente`
--

CREATE TABLE `paciente` (
  `ci_persona` int(10) UNSIGNED NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `padecimiento`
--

CREATE TABLE `padecimiento` (
  `cod` int(11) NOT NULL,
  `cod_diagnostico` int(11) NOT NULL,
  `ci_paciente_diagnostico` int(10) UNSIGNED NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `riesgo` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text,
  `resultado` text NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'modulo-seguridad', 'modulo-seguridad', 'modulo-seguridad', '2018-11-05 04:00:00', '2018-11-05 04:00:00'),
(2, 'crear_rol', 'crear_rol', 'crear_rol', '2018-11-05 04:00:00', '2018-11-05 04:00:00'),
(3, 'editar_rol', 'editar_rol', 'editar_rol', '2018-11-05 04:00:00', '2018-11-05 04:00:00'),
(4, 'role-delete', 'role-delete', 'role-delete', '2018-11-05 04:00:00', '2018-11-05 04:00:00'),
(5, 'editar_usuario', 'editar_usuario', 'editar_usuario', '2018-11-05 04:00:00', '2018-11-05 04:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 3),
(2, 4),
(2, 5),
(3, 1),
(4, 1),
(5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `persona`
--

CREATE TABLE `persona` (
  `ci` int(10) UNSIGNED NOT NULL,
  `id_users` int(10) UNSIGNED DEFAULT NULL,
  `cod_empresa` int(10) UNSIGNED DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `direccion` text,
  `usuario` varchar(50) NOT NULL,
  `pass` varchar(50) NOT NULL DEFAULT '1234',
  `intento` tinyint(3) NOT NULL DEFAULT '0',
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `tipo` varchar(1) NOT NULL DEFAULT 'A',
  `c` tinyint(1) NOT NULL DEFAULT '0',
  `r` tinyint(1) NOT NULL DEFAULT '0',
  `u` tinyint(1) NOT NULL DEFAULT '0',
  `d` tinyint(1) NOT NULL DEFAULT '0',
  `css` varchar(50) DEFAULT NULL,
  `foto` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `receta`
--

CREATE TABLE `receta` (
  `cod` int(11) NOT NULL,
  `cod_diagnostico` int(11) NOT NULL,
  `ci_paciente_diagnostico` int(10) UNSIGNED NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `indicacion` text NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rol`
--

CREATE TABLE `rol` (
  `ci_enfermera` int(10) UNSIGNED NOT NULL,
  `cod_cirugia` int(11) NOT NULL,
  `cod_diagnostico_cirugia` int(11) NOT NULL,
  `ci_paciente_diagnostico_cirugia` int(10) UNSIGNED NOT NULL,
  `funcion` varchar(50) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'administrador', 'administrador', 'administrador', '2018-11-05 04:00:00', '2018-11-05 04:00:00'),
(3, 'Admin Aseguradora', 'Admin Aseguradora', 'Admin Aseguradora', '2018-11-05 18:20:14', '2018-11-05 18:20:14'),
(4, 'Medico', 'medico', 'Médico', '2018-11-05 18:22:32', '2018-11-05 18:22:32'),
(5, 'Rol demo', 'Rol demo', 'Rol demo', '2018-11-05 18:24:50', '2018-11-05 18:24:50');

-- --------------------------------------------------------

--
-- Table structure for table `role_user`
--

CREATE TABLE `role_user` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_user`
--

INSERT INTO `role_user` (`user_id`, `role_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tratamiento`
--

CREATE TABLE `tratamiento` (
  `cod` int(11) NOT NULL,
  `cod_receta` int(11) NOT NULL,
  `cod_diagnostico_receta` int(11) NOT NULL,
  `ci_paciente_diagnostico_receta` int(10) UNSIGNED NOT NULL,
  `inicio` date NOT NULL,
  `fin` date NOT NULL,
  `reconsulta` date DEFAULT NULL,
  `descripcion` text NOT NULL,
  `indicacion` text,
  `estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fondo` varchar(100) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `estilo` varchar(100) DEFAULT 'si',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `fondo`, `foto`, `estilo`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Eliot Humerez', 'demoweb@gmail.com', '$2y$10$t5VJoK5rOVybmm57bF/PHes0eQAvfTQ1t6WrpNVYkWFXa1os4LC8O', 'skin-yellow', NULL, 'si', 'OuvudMTCMt7Wp4LLARhtJ01rxMXofe60XG8CAFHLMqbfgWpcHVP57A1tLxLN', '2018-10-28 14:01:53', '2018-10-28 14:01:53'),
(2, 'macc', 'macc@gmail.com', '$2y$10$iWNpGowdKrtjmtClh.w20OIUmXYklKtyWJZnbX/N5OWA3Rwe1yNZy', 'skin-red', NULL, 'si', NULL, '2018-10-28 09:26:48', '2018-10-28 09:26:48'),
(3, 'Ismael Cáceres', 'ismael@gmail.com', '$2y$10$uwjvhbQivAUyAcyz5Y3i5e8CnnqkXddB5YAk/yaB47iyP9Ku14oii', 'skin-blue', NULL, 'si', NULL, '2018-11-05 18:40:41', '2018-11-05 18:40:41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `analisis`
--
ALTER TABLE `analisis`
  ADD PRIMARY KEY (`cod`,`cod_diagnostico`,`ci_paciente_diagnostico`),
  ADD KEY `ci_paciente_diagnostico` (`ci_paciente_diagnostico`),
  ADD KEY `cod_diagnostico` (`cod_diagnostico`);

--
-- Indexes for table `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id_hostpital`,`ci_enfermera`),
  ADD KEY `ci_enfermera` (`ci_enfermera`);

--
-- Indexes for table `cirugia`
--
ALTER TABLE `cirugia`
  ADD PRIMARY KEY (`cod`,`cod_diagnostico`,`ci_paciente_diagnostico`),
  ADD KEY `cod_diagnostico` (`cod_diagnostico`),
  ADD KEY `ci_paciente_diagnostico` (`ci_paciente_diagnostico`);

--
-- Indexes for table `consultorio`
--
ALTER TABLE `consultorio`
  ADD PRIMARY KEY (`id_hostpital`,`ci_doctor`),
  ADD KEY `ci_doctor` (`ci_doctor`);

--
-- Indexes for table `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD PRIMARY KEY (`cod`,`ci_paciente`),
  ADD KEY `ci_paciente` (`ci_paciente`),
  ADD KEY `ci_doctor` (`ci_doctor`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`ci_persona`);

--
-- Indexes for table `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`cod`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `empresa_hospital`
--
ALTER TABLE `empresa_hospital`
  ADD PRIMARY KEY (`id_hostpital`,`cod_empresa`),
  ADD KEY `cod_empresa` (`cod_empresa`);

--
-- Indexes for table `enfermera`
--
ALTER TABLE `enfermera`
  ADD PRIMARY KEY (`ci_persona`);

--
-- Indexes for table `hospital`
--
ALTER TABLE `hospital`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `intervencion`
--
ALTER TABLE `intervencion`
  ADD PRIMARY KEY (`ci_doctor`,`cod_cirugia`,`cod_diagnostico_cirugia`,`ci_paciente_diagnostico_cirugia`),
  ADD KEY `ci_paciente_diagnostico_cirugia` (`ci_paciente_diagnostico_cirugia`),
  ADD KEY `cod_diagnostico_cirugia` (`cod_diagnostico_cirugia`),
  ADD KEY `cod_cirugia` (`cod_cirugia`);

--
-- Indexes for table `medicacion`
--
ALTER TABLE `medicacion`
  ADD PRIMARY KEY (`cod`,`cod_padecimiento`,`cod_diagnostico_padecimiento`,`ci_paciente_diagnostico_padecimiento`),
  ADD KEY `ci_paciente_diagnostico_padecimiento` (`ci_paciente_diagnostico_padecimiento`),
  ADD KEY `cod_diagnostico_padecimiento` (`cod_diagnostico_padecimiento`),
  ADD KEY `cod_padecimiento` (`cod_padecimiento`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`ci_persona`);

--
-- Indexes for table `padecimiento`
--
ALTER TABLE `padecimiento`
  ADD PRIMARY KEY (`cod`,`cod_diagnostico`,`ci_paciente_diagnostico`),
  ADD KEY `ci_paciente_diagnostico` (`ci_paciente_diagnostico`),
  ADD KEY `cod_diagnostico` (`cod_diagnostico`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indexes for table `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`ci`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD KEY `cod_empresa` (`cod_empresa`),
  ADD KEY `id_users` (`id_users`);

--
-- Indexes for table `receta`
--
ALTER TABLE `receta`
  ADD PRIMARY KEY (`cod`,`cod_diagnostico`,`ci_paciente_diagnostico`),
  ADD KEY `ci_paciente_diagnostico` (`ci_paciente_diagnostico`),
  ADD KEY `cod_diagnostico` (`cod_diagnostico`);

--
-- Indexes for table `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`ci_enfermera`,`cod_cirugia`,`cod_diagnostico_cirugia`,`ci_paciente_diagnostico_cirugia`),
  ADD KEY `ci_paciente_diagnostico_cirugia` (`ci_paciente_diagnostico_cirugia`),
  ADD KEY `cod_diagnostico_cirugia` (`cod_diagnostico_cirugia`),
  ADD KEY `cod_cirugia` (`cod_cirugia`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_user_role_id_foreign` (`role_id`);

--
-- Indexes for table `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD PRIMARY KEY (`cod`,`cod_receta`,`cod_diagnostico_receta`,`ci_paciente_diagnostico_receta`),
  ADD KEY `ci_paciente_diagnostico_receta` (`ci_paciente_diagnostico_receta`),
  ADD KEY `cod_diagnostico_receta` (`cod_diagnostico_receta`),
  ADD KEY `cod_receta` (`cod_receta`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `analisis`
--
ALTER TABLE `analisis`
  MODIFY `cod` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cirugia`
--
ALTER TABLE `cirugia`
  MODIFY `cod` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `diagnostico`
--
ALTER TABLE `diagnostico`
  MODIFY `cod` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `empresa`
--
ALTER TABLE `empresa`
  MODIFY `cod` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hospital`
--
ALTER TABLE `hospital`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medicacion`
--
ALTER TABLE `medicacion`
  MODIFY `cod` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `padecimiento`
--
ALTER TABLE `padecimiento`
  MODIFY `cod` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `receta`
--
ALTER TABLE `receta`
  MODIFY `cod` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tratamiento`
--
ALTER TABLE `tratamiento`
  MODIFY `cod` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `analisis`
--
ALTER TABLE `analisis`
  ADD CONSTRAINT `analisis_ibfk_1` FOREIGN KEY (`ci_paciente_diagnostico`) REFERENCES `diagnostico` (`ci_paciente`),
  ADD CONSTRAINT `analisis_ibfk_2` FOREIGN KEY (`cod_diagnostico`) REFERENCES `diagnostico` (`cod`);

--
-- Constraints for table `cargo`
--
ALTER TABLE `cargo`
  ADD CONSTRAINT `cargo_ibfk_1` FOREIGN KEY (`id_hostpital`) REFERENCES `hospital` (`id`),
  ADD CONSTRAINT `cargo_ibfk_2` FOREIGN KEY (`ci_enfermera`) REFERENCES `enfermera` (`ci_persona`);

--
-- Constraints for table `cirugia`
--
ALTER TABLE `cirugia`
  ADD CONSTRAINT `cirugia_ibfk_1` FOREIGN KEY (`cod_diagnostico`) REFERENCES `diagnostico` (`cod`),
  ADD CONSTRAINT `cirugia_ibfk_2` FOREIGN KEY (`ci_paciente_diagnostico`) REFERENCES `diagnostico` (`ci_paciente`);

--
-- Constraints for table `consultorio`
--
ALTER TABLE `consultorio`
  ADD CONSTRAINT `consultorio_ibfk_1` FOREIGN KEY (`id_hostpital`) REFERENCES `hospital` (`id`),
  ADD CONSTRAINT `consultorio_ibfk_2` FOREIGN KEY (`ci_doctor`) REFERENCES `doctor` (`ci_persona`);

--
-- Constraints for table `diagnostico`
--
ALTER TABLE `diagnostico`
  ADD CONSTRAINT `diagnostico_ibfk_1` FOREIGN KEY (`ci_paciente`) REFERENCES `paciente` (`ci_persona`),
  ADD CONSTRAINT `diagnostico_ibfk_2` FOREIGN KEY (`ci_doctor`) REFERENCES `doctor` (`ci_persona`);

--
-- Constraints for table `doctor`
--
ALTER TABLE `doctor`
  ADD CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`ci_persona`) REFERENCES `persona` (`ci`);

--
-- Constraints for table `empresa_hospital`
--
ALTER TABLE `empresa_hospital`
  ADD CONSTRAINT `empresa_hospital_ibfk_1` FOREIGN KEY (`id_hostpital`) REFERENCES `hospital` (`id`),
  ADD CONSTRAINT `empresa_hospital_ibfk_2` FOREIGN KEY (`cod_empresa`) REFERENCES `empresa` (`cod`);

--
-- Constraints for table `enfermera`
--
ALTER TABLE `enfermera`
  ADD CONSTRAINT `enfermera_ibfk_1` FOREIGN KEY (`ci_persona`) REFERENCES `persona` (`ci`);

--
-- Constraints for table `intervencion`
--
ALTER TABLE `intervencion`
  ADD CONSTRAINT `intervencion_ibfk_1` FOREIGN KEY (`ci_paciente_diagnostico_cirugia`) REFERENCES `cirugia` (`ci_paciente_diagnostico`),
  ADD CONSTRAINT `intervencion_ibfk_2` FOREIGN KEY (`cod_diagnostico_cirugia`) REFERENCES `cirugia` (`cod_diagnostico`),
  ADD CONSTRAINT `intervencion_ibfk_3` FOREIGN KEY (`cod_cirugia`) REFERENCES `cirugia` (`cod`),
  ADD CONSTRAINT `intervencion_ibfk_4` FOREIGN KEY (`ci_doctor`) REFERENCES `doctor` (`ci_persona`);

--
-- Constraints for table `medicacion`
--
ALTER TABLE `medicacion`
  ADD CONSTRAINT `medicacion_ibfk_1` FOREIGN KEY (`ci_paciente_diagnostico_padecimiento`) REFERENCES `padecimiento` (`ci_paciente_diagnostico`),
  ADD CONSTRAINT `medicacion_ibfk_2` FOREIGN KEY (`cod_diagnostico_padecimiento`) REFERENCES `padecimiento` (`cod_diagnostico`),
  ADD CONSTRAINT `medicacion_ibfk_3` FOREIGN KEY (`cod_padecimiento`) REFERENCES `padecimiento` (`cod`);

--
-- Constraints for table `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `paciente_ibfk_1` FOREIGN KEY (`ci_persona`) REFERENCES `persona` (`ci`);

--
-- Constraints for table `padecimiento`
--
ALTER TABLE `padecimiento`
  ADD CONSTRAINT `padecimiento_ibfk_1` FOREIGN KEY (`ci_paciente_diagnostico`) REFERENCES `diagnostico` (`ci_paciente`),
  ADD CONSTRAINT `padecimiento_ibfk_2` FOREIGN KEY (`cod_diagnostico`) REFERENCES `diagnostico` (`cod`);

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`cod_empresa`) REFERENCES `empresa` (`cod`),
  ADD CONSTRAINT `persona_ibfk_2` FOREIGN KEY (`id_users`) REFERENCES `users` (`id`);

--
-- Constraints for table `receta`
--
ALTER TABLE `receta`
  ADD CONSTRAINT `receta_ibfk_1` FOREIGN KEY (`ci_paciente_diagnostico`) REFERENCES `diagnostico` (`ci_paciente`),
  ADD CONSTRAINT `receta_ibfk_2` FOREIGN KEY (`cod_diagnostico`) REFERENCES `diagnostico` (`cod`);

--
-- Constraints for table `rol`
--
ALTER TABLE `rol`
  ADD CONSTRAINT `rol_ibfk_1` FOREIGN KEY (`ci_paciente_diagnostico_cirugia`) REFERENCES `cirugia` (`ci_paciente_diagnostico`),
  ADD CONSTRAINT `rol_ibfk_2` FOREIGN KEY (`cod_diagnostico_cirugia`) REFERENCES `cirugia` (`cod_diagnostico`),
  ADD CONSTRAINT `rol_ibfk_3` FOREIGN KEY (`cod_cirugia`) REFERENCES `cirugia` (`cod`),
  ADD CONSTRAINT `rol_ibfk_4` FOREIGN KEY (`ci_enfermera`) REFERENCES `enfermera` (`ci_persona`);

--
-- Constraints for table `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tratamiento`
--
ALTER TABLE `tratamiento`
  ADD CONSTRAINT `tratamiento_ibfk_1` FOREIGN KEY (`ci_paciente_diagnostico_receta`) REFERENCES `receta` (`ci_paciente_diagnostico`),
  ADD CONSTRAINT `tratamiento_ibfk_2` FOREIGN KEY (`cod_diagnostico_receta`) REFERENCES `receta` (`cod_diagnostico`),
  ADD CONSTRAINT `tratamiento_ibfk_3` FOREIGN KEY (`cod_receta`) REFERENCES `receta` (`cod`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
