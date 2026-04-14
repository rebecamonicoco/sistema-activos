CREATE DATABASE sistema_activos;
USE sistema_activos;

-- =========================
-- TABLA DEPARTAMENTOS
-- =========================
CREATE TABLE departamentos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

-- =========================
-- TABLA EMPLEADOS
-- =========================
CREATE TABLE empleados (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(20) NULL,
    cargo VARCHAR(100) NULL,
    departamento_id BIGINT UNSIGNED NOT NULL,
    estado ENUM('activo','inactivo') DEFAULT 'activo',
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_empleado_departamento
        FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

-- =========================
-- TABLA CATEGORIAS
-- =========================
CREATE TABLE categorias (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

-- =========================
-- TABLA ACTIVOS
-- =========================
CREATE TABLE activos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT NULL,
    categoria_id BIGINT UNSIGNED NOT NULL,
    marca VARCHAR(100) NULL,
    modelo VARCHAR(100) NULL,
    numero_serie VARCHAR(100) NULL UNIQUE,
    fecha_compra DATE NULL,
    costo_compra DECIMAL(10,2) NULL,
    estado ENUM('disponible','asignado','mantenimiento','baja') DEFAULT 'disponible',
    ubicacion VARCHAR(150) NULL,
    foto VARCHAR(255) NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_activo_categoria
        FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- =========================
-- TABLA ASIGNACIONES DE ACTIVOS
-- =========================
CREATE TABLE asignaciones_activos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    activo_id BIGINT UNSIGNED NOT NULL,
    empleado_id BIGINT UNSIGNED NOT NULL,
    fecha_asignacion DATE NOT NULL,
    fecha_devolucion DATE NULL,
    estado ENUM('asignado','devuelto') DEFAULT 'asignado',
    observaciones TEXT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_asignacion_activo
        FOREIGN KEY (activo_id) REFERENCES activos(id),
    CONSTRAINT fk_asignacion_empleado
        FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);

-- =========================
-- TABLA MANTENIMIENTOS
-- =========================
CREATE TABLE mantenimientos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    activo_id BIGINT UNSIGNED NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_mantenimiento DATE NOT NULL,
    costo DECIMAL(10,2) DEFAULT 0.00,
    tecnico VARCHAR(150) NULL,
    estado ENUM('pendiente','en_proceso','finalizado') DEFAULT 'pendiente',
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    CONSTRAINT fk_mantenimiento_activo
        FOREIGN KEY (activo_id) REFERENCES activos(id)
);