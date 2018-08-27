-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-08-2018 a las 19:46:52
-- Versión del servidor: 10.1.34-MariaDB
-- Versión de PHP: 7.1.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `colcief_db`
--
CREATE DATABASE IF NOT EXISTS `colcief_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `colcief_db`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acudiente`
--

CREATE TABLE IF NOT EXISTS `acudiente` (
  `pk_acudiente` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre_acu_1` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion_acu_1` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_acu_1` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_acu_2` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion_acu_2` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono_acu_2` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_acudiente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `boletin`
--

CREATE TABLE IF NOT EXISTS `boletin` (
  `pk_boletin` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_curso` int(10) UNSIGNED NOT NULL,
  `fk_estudiante` int(10) UNSIGNED NOT NULL,
  `estado` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ano` year(4) NOT NULL,
  `nota_final` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_boletin`),
  KEY `boletin_fk_curso_foreign` (`fk_curso`),
  KEY `boletin_fk_estudiante_foreign` (`fk_estudiante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE IF NOT EXISTS `curso` (
  `pk_curso` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `division`
--

CREATE TABLE IF NOT EXISTS `division` (
  `pk_division` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `ano` year(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_division`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE IF NOT EXISTS `empleado` (
  `pk_empleado` int(10) UNSIGNED NOT NULL,
  `cedula` int(11) NOT NULL,
  `nombre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clave` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titulo` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tiempo_extra` int(11) NOT NULL,
  `director` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE IF NOT EXISTS `estudiante` (
  `pk_estudiante` int(10) UNSIGNED NOT NULL,
  `fk_acudiente` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `clave` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `grado` int(11) NOT NULL,
  `discapacidad` tinyint(1) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_estudiante`),
  KEY `estudiante_fk_acudiente_foreign` (`fk_acudiente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE IF NOT EXISTS `horario` (
  `pk_horario` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_materia_pc` int(10) UNSIGNED NOT NULL,
  `dia` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_horario`),
  KEY `horario_fk_materia_pc_foreign` (`fk_materia_pc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE IF NOT EXISTS `materia` (
  `pk_materia` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenido` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logros_custom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_materia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia_boletin`
--

CREATE TABLE IF NOT EXISTS `materia_boletin` (
  `pk_materia_boletin` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_materia_pc` int(10) UNSIGNED NOT NULL,
  `fk_boletin` int(10) UNSIGNED NOT NULL,
  `nota_materia` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_materia_boletin`),
  KEY `materia_boletin_fk_materia_pc_foreign` (`fk_materia_pc`),
  KEY `materia_boletin_fk_boletin_foreign` (`fk_boletin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia_pc`
--

CREATE TABLE IF NOT EXISTS `materia_pc` (
  `pk_materia_pc` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_empleado` int(10) UNSIGNED NOT NULL,
  `fk_curso` int(10) UNSIGNED NOT NULL,
  `fk_materia` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salon` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logros_custom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_materia_pc`),
  KEY `materia_pc_fk_curso_foreign` (`fk_curso`),
  KEY `materia_pc_fk_materia_foreign` (`fk_materia`),
  KEY `materia_pc_fk_empleado_foreign` (`fk_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2018_08_24_000707_todo', 1),
(2, '2018_08_24_001806_fks', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota`
--

CREATE TABLE IF NOT EXISTS `nota` (
  `pk_nota` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_division` int(10) UNSIGNED NOT NULL,
  `fk_materia_pc` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_nota`),
  KEY `nota_fk_division_foreign` (`fk_division`),
  KEY `nota_fk_materia_pc_foreign` (`fk_materia_pc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota_estudiante`
--

CREATE TABLE IF NOT EXISTS `nota_estudiante` (
  `pk_nota_estudiante` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_estudiante` int(10) UNSIGNED NOT NULL,
  `fk_nota` int(10) UNSIGNED NOT NULL,
  `fk_nota_periodo` int(10) UNSIGNED NOT NULL,
  `nota` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_nota_estudiante`),
  KEY `nota_estudiante_fk_estudiante_foreign` (`fk_estudiante`),
  KEY `nota_estudiante_fk_nota_foreign` (`fk_nota`),
  KEY `nota_estudiante_fk_nota_periodo_foreign` (`fk_nota_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota_periodo`
--

CREATE TABLE IF NOT EXISTS `nota_periodo` (
  `pk_nota_periodo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_periodo` int(10) UNSIGNED NOT NULL,
  `fk_materia_boletin` int(10) UNSIGNED NOT NULL,
  `nota_final` int(11) NOT NULL,
  `habilidad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_nota_periodo`),
  KEY `nota_periodo_fk_periodo_foreign` (`fk_periodo`),
  KEY `nota_periodo_fk_materia_boletin_foreign` (`fk_materia_boletin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodo`
--

CREATE TABLE IF NOT EXISTS `periodo` (
  `pk_periodo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date NOT NULL,
  `fecha_limite` datetime NOT NULL,
  `ano` year(4) NOT NULL,
  `nro_periodo` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`pk_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `boletin`
--
ALTER TABLE `boletin`
  ADD CONSTRAINT `boletin_fk_curso_foreign` FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`pk_curso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `boletin_fk_estudiante_foreign` FOREIGN KEY (`fk_estudiante`) REFERENCES `estudiante` (`pk_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD CONSTRAINT `estudiante_fk_acudiente_foreign` FOREIGN KEY (`fk_acudiente`) REFERENCES `acudiente` (`pk_acudiente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `horario`
--
ALTER TABLE `horario`
  ADD CONSTRAINT `horario_fk_materia_pc_foreign` FOREIGN KEY (`fk_materia_pc`) REFERENCES `materia_pc` (`pk_materia_pc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `materia_boletin`
--
ALTER TABLE `materia_boletin`
  ADD CONSTRAINT `materia_boletin_fk_boletin_foreign` FOREIGN KEY (`fk_boletin`) REFERENCES `boletin` (`pk_boletin`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `materia_boletin_fk_materia_pc_foreign` FOREIGN KEY (`fk_materia_pc`) REFERENCES `materia_pc` (`pk_materia_pc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `materia_pc`
--
ALTER TABLE `materia_pc`
  ADD CONSTRAINT `materia_pc_fk_curso_foreign` FOREIGN KEY (`fk_curso`) REFERENCES `curso` (`pk_curso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `materia_pc_fk_empleado_foreign` FOREIGN KEY (`fk_empleado`) REFERENCES `empleado` (`pk_empleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `materia_pc_fk_materia_foreign` FOREIGN KEY (`fk_materia`) REFERENCES `materia` (`pk_materia`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `nota`
--
ALTER TABLE `nota`
  ADD CONSTRAINT `nota_fk_division_foreign` FOREIGN KEY (`fk_division`) REFERENCES `division` (`pk_division`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nota_fk_materia_pc_foreign` FOREIGN KEY (`fk_materia_pc`) REFERENCES `materia_pc` (`pk_materia_pc`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `nota_estudiante`
--
ALTER TABLE `nota_estudiante`
  ADD CONSTRAINT `nota_estudiante_fk_estudiante_foreign` FOREIGN KEY (`fk_estudiante`) REFERENCES `estudiante` (`pk_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nota_estudiante_fk_nota_foreign` FOREIGN KEY (`fk_nota`) REFERENCES `nota` (`pk_nota`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nota_estudiante_fk_nota_periodo_foreign` FOREIGN KEY (`fk_nota_periodo`) REFERENCES `nota_periodo` (`pk_nota_periodo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `nota_periodo`
--
ALTER TABLE `nota_periodo`
  ADD CONSTRAINT `nota_periodo_fk_materia_boletin_foreign` FOREIGN KEY (`fk_materia_boletin`) REFERENCES `materia_boletin` (`pk_materia_boletin`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nota_periodo_fk_periodo_foreign` FOREIGN KEY (`fk_periodo`) REFERENCES `periodo` (`pk_periodo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
