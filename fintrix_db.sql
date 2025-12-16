-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-12-2025 a las 20:37:49
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
(17, 1, 'Teléfono', 'Gasto', '2025-12-15 18:36:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nombre_cuenta` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `saldo_inicial` decimal(12,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id`, `usuario_id`, `nombre_cuenta`, `tipo`, `saldo_inicial`, `created_at`) VALUES
(1, 1, 'Cuenta de Ahorros', 'Ahorros', 500000.00, '2025-12-15 17:36:46');

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
(2, 'COP', 'light', 1, 0),
(3, 'COP', 'dark', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transacciones`
--

CREATE TABLE `transacciones` (
  `id` int(11) NOT NULL,
  `cuenta_id` int(11) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `fecha` date NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `monto` decimal(12,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `transacciones`
--

INSERT INTO `transacciones` (`id`, `cuenta_id`, `categoria_id`, `fecha`, `tipo`, `descripcion`, `monto`, `created_at`) VALUES
(1, 1, 1, '2025-01-01', 'ingreso', 'Pago mensual', 2000000.00, '2025-12-15 17:36:46'),
(2, 1, 2, '2025-01-05', 'gasto', 'Compra supermercado', 85000.00, '2025-12-15 17:36:46'),
(3, 1, 3, '2025-01-07', 'gasto', 'Bus urbano', 12000.00, '2025-12-15 17:36:46'),
(4, 1, 3, '2025-12-15', 'Ingreso', 'servocios', 100000.00, '2025-12-15 18:16:54'),
(5, 1, 1, '2025-12-15', 'Ingreso', 'Salario', 2500000.00, '2025-12-15 18:29:56'),
(6, 1, 16, '2025-12-15', 'Gasto', 'pago internet', 100000.00, '2025-12-15 18:36:29'),
(7, 1, 4, '2025-12-15', 'Gasto', 'luz', 110000.00, '2025-12-15 18:37:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `clave`, `created_at`) VALUES
(1, 'Juan Pérez', 'juan@example.com', '1234', '2025-12-15 17:36:46'),
(2, 'Carlos Alberto Valderrama Palacios', 'carlos@hotmail.com', '123456', '2025-12-15 18:03:41'),
(3, 'Carlos Valderrama', 'carlos.valderrama@email.com', '123456', '2025-12-15 18:42:12');

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuenta_id` (`cuenta_id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `transacciones`
--
ALTER TABLE `transacciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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

--
-- Filtros para la tabla `transacciones`
--
ALTER TABLE `transacciones`
  ADD CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`cuenta_id`) REFERENCES `cuentas` (`id`),
  ADD CONSTRAINT `transacciones_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
