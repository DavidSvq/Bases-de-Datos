-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-01-2023 a las 09:11:34
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `oficina`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centrostrabajo`
--

CREATE TABLE `centrostrabajo` (
  `idCentroTrabajo` int(11) NOT NULL,
  `nombreCentroTrabajo` varchar(255) DEFAULT NULL,
  `direccionCentroTrabajo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `centrostrabajo`
--

INSERT INTO `centrostrabajo` (`idCentroTrabajo`, `nombreCentroTrabajo`, `direccionCentroTrabajo`) VALUES
(10, 'SEDE CENTRAL', 'C/ ALCALA, 820, MADRID'),
(20, 'RELACION CON CLIENTES', 'C/ ATOCHA, 405, MADRID');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `idDepartamento` int(11) NOT NULL,
  `idCentroTrabajoFK` int(11) DEFAULT NULL,
  `idEmpleadoFk` int(11) DEFAULT NULL,
  `tipoDirectorDepartamento` varchar(255) DEFAULT NULL,
  `presupuestosDepartamento` float DEFAULT NULL,
  `idDepartamentoFK` int(11) DEFAULT NULL,
  `nombreDepartamento` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`idDepartamento`, `idCentroTrabajoFK`, `idEmpleadoFk`, `tipoDirectorDepartamento`, `presupuestosDepartamento`, `idDepartamentoFK`, `nombreDepartamento`) VALUES
(100, 10, 260, 'P', 12, NULL, 'DIRECCIÓN GENERAL'),
(110, 20, 180, 'P', 15, 100, 'DIRECCIÓN'),
(111, 20, 180, 'F', 11, 110, 'SECTOR INDUSTRIAL'),
(112, 20, 270, 'P', 9, 110, 'SECTOR SERVICIOS'),
(120, 10, 150, 'F', 3, 100, 'ORGANIZACIÓN'),
(121, 10, 150, 'P', 2, 120, 'PERSONAL'),
(122, 10, 350, 'P', 6, 120, 'PROCESO DE DATOS'),
(130, 10, 310, 'P', 2, 100, 'FINANZAS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `idEmpleado` int(11) NOT NULL,
  `idDepartamentoFK` int(11) DEFAULT NULL,
  `extensionEmpleado` int(11) DEFAULT NULL,
  `fechaNacimientoEmpleado` date DEFAULT NULL,
  `fechaIngresoEmpleado` date DEFAULT NULL,
  `salarioEmpleado` float DEFAULT NULL,
  `comisionEmpleado` float DEFAULT NULL,
  `hijosEmpleado` int(11) DEFAULT NULL,
  `nombreEmpleado` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`idEmpleado`, `idDepartamentoFK`, `extensionEmpleado`, `fechaNacimientoEmpleado`, `fechaIngresoEmpleado`, `salarioEmpleado`, `comisionEmpleado`, `hijosEmpleado`, `nombreEmpleado`) VALUES
(110, 121, 350, '1969-05-02', '1990-05-02', 2100, 0, 3, 'PONS, CESAR'),
(120, 112, 840, '1975-05-30', '2008-09-30', 2500, 1100, 1, 'LASA, MARIO'),
(130, 112, 810, '1985-08-30', '2009-01-22', 1900, 1100, 2, 'TEROL, LUCIANO'),
(150, 112, 340, '1970-07-31', '1988-01-05', 3400, 0, 0, 'PEREZ, JULIO'),
(160, 111, 740, '1979-06-29', '2008-11-01', 2100, 1100, 2, 'AGUIRRE, AUREO'),
(180, 110, 508, '1974-10-08', '1996-03-08', 3800, 500, 2, 'PEREZ, MARCOS'),
(190, 121, 350, '1972-05-02', '2002-02-01', 2000, 0, 4, 'VEIGA, JULIANA'),
(210, 100, 200, '1980-09-18', '1999-01-12', 2800, 0, 2, 'GALVEZ, PILAR'),
(240, 111, 760, '1982-02-16', '2006-02-14', 1800, 1000, 3, 'SANZ, LAVINIA'),
(250, 100, 250, '1986-10-17', '2007-02-19', 3500, 0, 0, 'ALBA, ADRIANA'),
(260, 100, 220, '1983-09-23', '2008-07-02', 5200, 0, 6, 'LOPEZ, ANTONIO'),
(270, 112, 800, '1985-05-11', '2006-08-31', 2800, 800, 3, 'GARCIA, OCTAVIO'),
(280, 130, 410, '1948-01-01', '1968-09-28', 1900, 0, 5, 'FLOR, DOROTEA'),
(285, 122, 620, '1989-10-15', '2009-02-05', 2800, 0, 0, 'POLO, OTILIA'),
(290, 120, 910, '1947-11-20', '1968-02-04', 1700, 0, 3, 'GIL, GLORIA'),
(310, 130, 480, '1986-11-11', '2011-01-05', 3200, 0, 0, 'GARCIA, AUGUSTO'),
(320, 122, 620, '1947-12-18', '1968-01-29', 3050, 0, 2, 'SANZ, CORNELIO'),
(330, 112, 850, '1948-08-09', '1972-02-20', 1800, 900, 0, 'DIEZ, AMELIA'),
(350, 112, 610, '1969-04-08', '2004-09-05', 3500, 0, 1, 'CAMPS, AURELIO'),
(360, 111, 750, '1998-10-19', '2008-09-30', 1500, 1000, 2, 'LARA, DORINA'),
(370, 121, 360, '1987-06-17', '2007-01-15', 900, 0, 1, 'RUIZ, FABIOLA'),
(380, 112, 880, '1948-03-25', '1967-12-27', 800, 0, 0, 'MARTIN, MICAELA'),
(390, 110, 500, '1946-02-14', '1966-10-03', 1150, 0, 1, 'MORAN, CARMEN'),
(400, 111, 780, '1989-08-13', '2007-10-27', 850, 0, 0, 'LARA, LUCRECIA'),
(410, 122, 660, '1988-07-09', '2008-10-08', 750, 0, 0, 'MUNOZ, AZUCENA'),
(420, 130, 450, '1986-10-17', '2008-11-11', 3000, 0, 0, 'FIERRO, CLAUDIA'),
(430, 122, 650, '1947-02-21', '1978-11-14', 1100, 0, 1, 'MORA, VALERIANA'),
(440, 111, 760, '1986-09-21', '2006-02-03', 1100, 1000, 0, 'DURAN, LIVIA'),
(450, 112, 880, '1986-10-16', '2006-02-23', 1100, 1000, 0, 'PEREZ, SABINA'),
(480, 111, 760, '1985-03-30', '2006-02-23', 1100, 1000, 1, 'PINO, DIANA'),
(490, 112, 880, '1984-06-01', '2007-12-27', 800, 1000, 0, 'TORRES, HORACIO'),
(500, 111, 750, '1985-10-03', '2006-12-27', 1000, 1000, 0, 'VAZQUEZ, HONORIA'),
(510, 110, 550, '1986-04-26', '2006-10-27', 1000, 0, 1, 'CAMPOS, ROMULO'),
(550, 111, 780, '1990-01-05', '2008-01-16', 900, 1200, 0, 'SANTOS, SANCHO');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `centrostrabajo`
--
ALTER TABLE `centrostrabajo`
  ADD PRIMARY KEY (`idCentroTrabajo`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`idDepartamento`),
  ADD KEY `idCentroTrabajoFK` (`idCentroTrabajoFK`),
  ADD KEY `idEmpleadoFk` (`idEmpleadoFk`),
  ADD KEY `idDepartamentoFK` (`idDepartamentoFK`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`idEmpleado`),
  ADD KEY `idDepartamentoFK` (`idDepartamentoFK`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD CONSTRAINT `departamentos_ibfk_1` FOREIGN KEY (`idCentroTrabajoFK`) REFERENCES `centrostrabajo` (`idCentroTrabajo`),
  ADD CONSTRAINT `departamentos_ibfk_2` FOREIGN KEY (`idEmpleadoFk`) REFERENCES `empleados` (`idEmpleado`),
  ADD CONSTRAINT `departamentos_ibfk_3` FOREIGN KEY (`idDepartamentoFK`) REFERENCES `departamentos` (`idDepartamento`);

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`idDepartamentoFK`) REFERENCES `departamentos` (`idDepartamento`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
