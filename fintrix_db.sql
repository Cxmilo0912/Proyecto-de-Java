-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-12-2025 a las 22:54:31
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `fintrix_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `usuario_id`, `nombre`, `tipo`, `created_at`) VALUES
(1, 1, 'Salario', 'ingreso', '2025-12-15 17:36:46'),
(2, 1, 'Supermercado', 'gasto', '2025-12-15 17:36:46'),
(3, 1, 'Transporte', 'gasto', '2025-12-15 17:36:46'),
(4, 1, 'Servicios públicos', 'Gasto', '2025-12-15 18:36:07'),
(5, 1, 'Salud', 'Gasto', '2025-12-15 18:36:07'),
(6, 1, 'Educación', 'Gasto', '2025-12-15 18:36:07'),
(7, 1, 'Vivienda', 'Gasto', '2025-12-15 18:36:07'),
(8, 1, 'Ocio', 'Gasto', '2025-12-15 18:36:07'),
(9, 1, 'Impuestos', 'Gasto', '2025-12-15 18:36:07'),
(10, 1, 'Seguro', 'Gasto', '2025-12-15 18:36:07'),
(11, 1, 'Entretenimiento', 'Gasto', '2025-12-15 18:36:07'),
(12, 1, 'Compras', 'Gasto', '2025-12-15 18:36:07'),
(13, 1, 'Restaurantes', 'Gasto', '2025-12-15 18:36:07'),
(14, 1, 'Ropa', 'Gasto', '2025-12-15 18:36:07'),
(15, 1, 'Hogar', 'Gasto', '2025-12-15 18:36:07'),
(16, 1, 'Internet', 'Gasto', '2025-12-15 18:36:07'),
(17, 1, 'Teléfono', 'Gasto', '2025-12-15 18:36:07'),
(18, 1, 'Beca', 'Ingreso', '2025-12-16 18:48:54'),
(19, 1, 'Intereses', 'Ingreso', '2025-12-16 18:48:54'),
(20, 1, 'Ventas', 'Ingreso', '2025-12-16 18:48:54'),
(21, 1, 'Reembolsos', 'Ingreso', '2025-12-16 18:48:54'),
(22, 1, 'Regalos', 'Ingreso', '2025-12-16 18:48:54'),
(23, 1, 'Freelance', 'Ingreso', '2025-12-16 18:48:54'),
(24, 1, 'Dividendos', 'Ingreso', '2025-12-16 18:48:54'),
(25, 1, 'Alquiler', 'Ingreso', '2025-12-16 18:48:54'),
(26, 1, 'Otros ingresos', 'Ingreso', '2025-12-16 18:48:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nombre_cuenta` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL DEFAULT 'Ahorros',
  `saldo_inicial` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `saldo_actual` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id`, `usuario_id`, `nombre_cuenta`, `tipo`, `saldo_inicial`, `created_at`, `saldo_actual`) VALUES
(1, 4, 'cuenta ahorros', 'Ahorros', 30000.00, '2025-12-16 20:05:46', 0),
(2, 4, 'cuenta corriente', 'Corriente', 30000.00, '2025-12-16 20:05:56', 0),
(3, 5, 'bancolombia', 'Ahorros', 300000.00, '2025-12-16 20:52:59', 510000),
(4, 8, 'daviplata', 'Ahorros', 1000000.00, '2025-12-16 21:51:12', 11950000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preferencias_usuario`
--

CREATE TABLE `preferencias_usuario` (
  `usuario_id` int(11) NOT NULL,
  `moneda` varchar(8) NOT NULL,
  `tema` varchar(16) NOT NULL,
  `notificaciones` tinyint(1) NOT NULL,
  `face_id` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `preferencias_usuario`
--

INSERT INTO `preferencias_usuario` (`usuario_id`, `moneda`, `tema`, `notificaciones`, `face_id`) VALUES
(2, 'COP', 'dark', 1, 0),
(3, 'COP', 'dark', 1, 0),
(4, 'COP', 'dark', 1, 0),
(5, 'COP', 'dark', 1, 0),
(6, 'COP', 'dark', 1, 0),
(7, 'COP', 'dark', 1, 0),
(8, 'USD', 'dark', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transacciones`
--

CREATE TABLE `transacciones` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `cuenta_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `monto` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `transacciones`
--

INSERT INTO `transacciones` (`id`, `usuario_id`, `cuenta_id`, `categoria_id`, `fecha`, `tipo`, `descripcion`, `monto`, `created_at`) VALUES
(1, 4, 1, 23, '2025-12-16', 'Ingreso', 'stake', 10000.00, '2025-12-16 21:19:32'),
(2, 4, 2, 18, '2025-12-16', 'Ingreso', 'stake', 10000.00, '2025-12-16 21:20:06'),
(3, 4, 1, 18, '2025-12-16', 'Ingreso', 'beca', 10000.00, '2025-12-16 21:20:30'),
(4, 4, 1, 23, '2025-12-16', 'Ingreso', 'stake', 2000.00, '2025-12-16 21:24:31'),
(5, 4, 1, 18, '2025-12-16', 'Ingreso', 'beca', 1000.00, '2025-12-16 21:24:45'),
(6, 5, 3, 11, '2025-12-16', 'Gasto', 'stake', 10000.00, '2025-12-16 21:34:06'),
(7, 5, 3, 5, '2025-12-16', 'Gasto', '555', 300000.00, '2025-12-16 21:34:33'),
(8, 5, 3, 23, '2025-12-16', 'Ingreso', 'ncasibo', 100000.00, '2025-12-16 21:35:06'),
(9, 8, 4, 6, '2025-12-16', 'Gasto', 'stake', 700000.00, '2025-12-16 21:51:36'),
(10, 8, 4, 9, '2025-12-16', 'Gasto', 'stake', 250000.00, '2025-12-16 21:51:59'),
(11, 8, 4, 18, '2025-12-16', 'Ingreso', 'stake', 5000000.00, '2025-12-16 21:52:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `clave` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `proveedor` enum('LOCAL','GOOGLE') NOT NULL DEFAULT 'LOCAL'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `clave`, `created_at`, `proveedor`) VALUES
(1, 'Juan Pérez', 'juan@example.com', '1234', '2025-12-15 17:36:46', 'LOCAL'),
(2, 'Carlos Alberto Valderrama Palacios', 'carlos@hotmail.com', '123456', '2025-12-15 18:03:41', 'LOCAL'),
(3, 'Carlos Valderrama', 'carlos.valderrama@email.com', '123456', '2025-12-15 18:42:12', 'LOCAL'),
(4, 'Julián López', 'julilo09123452@gmail.com', NULL, '2025-12-16 17:58:35', 'GOOGLE'),
(5, 'Castiblanco Perez Andrés Felipe', 'castiblancoperezfelipe@gmail.com', NULL, '2025-12-16 20:52:19', 'GOOGLE'),
(6, 'Jonathan Samuel Rincón Figueredo', 'jrinconfigueredo85@gmail.com', NULL, '2025-12-16 21:36:56', 'GOOGLE'),
(7, 'Jhon alejandro', 'alejandrotareas029@gmail.com', NULL, '2025-12-16 21:49:24', 'GOOGLE'),
(8, 'santiago chaparro', 'santiagochaparrotorres13@gmail.com', NULL, '2025-12-16 21:50:09', 'GOOGLE');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `preferencias_usuario`
--
ALTER TABLE `preferencias_usuario`
  ADD PRIMARY KEY (`usuario_id`);

--
-- Indices de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD CONSTRAINT `categorias_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
