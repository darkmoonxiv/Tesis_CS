SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS PlaneacionSiembra;

USE PlaneacionSiembra;

CREATE TABLE IF NOT EXISTS Usuarios (
  IdUser INT AUTO_INCREMENT,
  NombreUser VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  ApellidoUser VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  CorreoElectronico VARCHAR(75) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  Contrasena VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  Estado ENUM('activo', 'inactivo') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (IdUser)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Roles (
  idRol INT AUTO_INCREMENT,
  NombreRol VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  codeRol VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (idRol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Permisos (
  IdPermisos INT AUTO_INCREMENT,
  NombrePermisos VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  Descripcion VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (IdPermisos)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS UsuariosRoles (
  IdUserRol INT AUTO_INCREMENT,
  idUser INT,
  idRol INT,
  PRIMARY KEY (IdUserRol),
  FOREIGN KEY (idUser) REFERENCES Usuarios(IdUser),
  FOREIGN KEY (idRol) REFERENCES Roles(idRol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS RolesPermisos (
  IdRolPermiso INT AUTO_INCREMENT,
  IdRol INT,
  IdPermiso INT,
  PRIMARY KEY (IdRolPermiso),
  FOREIGN KEY (IdRol) REFERENCES Roles(idRol),
  FOREIGN KEY (IdPermiso) REFERENCES Permisos(IdPermisos)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS PlanificacionSiembra1 (
  IdPlanSiembra1 INT AUTO_INCREMENT,
  CondicionClimatica VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  NombreSemillas VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  VariedadBanano VARCHAR(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  CantidadFertilizanteKG FLOAT,
  CantidadPesticidasKG FLOAT,
  FechaFumigacionArea DATETIME,
  Riego ENUM('Motores/Bombas', 'Electrico/Diesel') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  IdUsuarioOperativo INT,
  PRIMARY KEY (IdPlanSiembra1),
  FOREIGN KEY (IdUsuarioOperativo) REFERENCES Usuarios(IdUser)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS PlanificacionSiembra2 (
  IdPlanSiembra2 INT AUTO_INCREMENT,
  FechaSiembra DATETIME,
  FechaSiembraFin DATETIME,
  TiempoEstimadoSiembra INT,
  NumeroRacimos INT,
  NumeroRacimosRechazados INT,
  PesoPromedioRacimo FLOAT,
  NumeroLote INT,
  IdPlanSiembra1 INT,
  PRIMARY KEY (IdPlanSiembra2),
  FOREIGN KEY (IdPlanSiembra1) REFERENCES PlanificacionSiembra1(IdPlanSiembra1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Inventario (
  IdInventario INT AUTO_INCREMENT,
  FechaCompra DATETIME,
  Producto VARCHAR(45),
  Cantidad INT,
  PrecioUnitario FLOAT,
  PRIMARY KEY (IdInventario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS RegistroCostos (
  IdCostos INT AUTO_INCREMENT,
  FechaRegistro DATETIME,
  Descripcion VARCHAR(100),
  Insumo FLOAT,
  ManoObra FLOAT,
  Combustible FLOAT,
  Total FLOAT,
  IdInventario INT,
  IdUsuarioOperativo INT,
  PRIMARY KEY (IdCostos),
  FOREIGN KEY (IdInventario) REFERENCES Inventario(IdInventario),
  FOREIGN KEY (IdUsuarioOperativo) REFERENCES Usuarios(IdUser)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS Rentabilidad (
  IdRentabilidad INT AUTO_INCREMENT,
  IdPlanSiembra2 INT,
  IdRegistroCostos INT,
  PRIMARY KEY (IdRentabilidad),
  FOREIGN KEY (IdPlanSiembra2) REFERENCES PlanificacionSiembra2(IdPlanSiembra2),
  FOREIGN KEY (IdRegistroCostos) REFERENCES RegistroCostos(IdCostos)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS TipoReporte (
  IdTipoReporte INT AUTO_INCREMENT,
  NombreReporte VARCHAR(45),
  PRIMARY KEY (IdTipoReporte)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Reportes (
  IdReportes INT AUTO_INCREMENT,
  IdUsuarios INT,
  IdTipoReporte INT,
  Contenido VARCHAR(200),
  FechaCreacion DATETIME,
  PRIMARY KEY (IdReportes),
  FOREIGN KEY (IdUsuarios) REFERENCES Usuarios(IdUser),
  FOREIGN KEY (IdTipoReporte) REFERENCES TipoReporte(IdTipoReporte)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- INSERTS

INSERT INTO Permisos(NombrePermisos, Descripcion) VALUES
('user.create', 'Crear usuario'),
('user.edit', 'Editar usuario'),
('user.deactivate', 'Desactivar usuario'),
('user.delete', 'Eliminar usuario'),
('user.list', 'Listar usuarios'),
('user.get', 'Obtener usuario'),
('permissions.list', 'Listar permisos'),
('roles.list', 'Listar roles'),
('roles.assign', 'Asignar roles a usuarios'),
('roles.get_permissions', 'Listar permisos de rol'),
('roles.set_permissions', 'Configurar permisos para roles'),
('reports.create', 'Generar reportes'),
('reports.list', 'Listar reportes'),
('reports.get', 'Obtener reporte'),
('seeding.plan', 'Planificar siembras de banano'),
('seeding.edit', 'Editar planificación de siembra'),
('seeding.list', 'Listar planificaciones de siembra'),
('seeding.get', 'Obtener planificación de siembra'),
('inventory.register', 'Registrar inventario de productos, equipos e insumos'),
('inventory.edit', 'Editar inventario'),
('inventory.list', 'Listar inventario'),
('inventory.get_product', 'Obtener producto del inventario'),
('costs.record', 'Llevar registro detallado de costos'),
('costs.edit', 'Editar registro de costos'),
('costs.list', 'Listar registros de costos'),
('costs.get', 'Obtener registro de costos'),
('profitability.calculate', 'Calcular la rentabilidad a partir de los datos registrados'),
('profitability.list', 'Listar rentabilidades'),
('profitability.get', 'Obtener rentabilidad');

INSERT INTO Roles (NombreRol, codeRol) VALUES
('Administrador', '001'),
('Usuario operativo', '002');


-- Obtener Id de Roles
SET @idRolAdmin = (SELECT idRol FROM Roles WHERE codeRol = '001');
SET @idRolUsuario = (SELECT idRol FROM Roles WHERE codeRol = '002');


-- Obtener Id de Permisos
SET @crearUsuario = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'user.create');
SET @editarUsuario = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'user.edit');
SET @desactivarUsuario = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'user.deactivate');
SET @eliminarUsuario = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'user.delete');
SET @listarUsuarios = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'user.list');
SET @obtenerUsuario = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'user.get');
SET @listarPermisos = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'permissions.list');
SET @listarRoles = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'roles.list');
SET @asignarRoles = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'roles.assign');
SET @listarRolesPermisos = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'roles.get_permissions');
SET @configurarPermisos = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'roles.set_permissions');
SET @generarReportes = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'reports.create');
SET @listarReportes = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'reports.list');
SET @obtenerReporte = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'reports.get');
SET @planificarSiembra = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'seeding.plan');
SET @editarPlanificacionSiembra = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'seeding.edit');
SET @listarPlanificacionesSiembra = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'seeding.list');
SET @obtenerPlanificacionSiembra = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'seeding.get');
SET @registrarInventario = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'inventory.register');
SET @editarInventario = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'inventory.edit');
SET @listarInventario = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'inventory.list');
SET @obtenerProductoInventario = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'inventory.get_product');
SET @llevarRegistroCostos = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'costs.record');
SET @editarRegistroCostos = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'costs.edit');
SET @listarRegistrosCostos = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'costs.list');
SET @obtenerRegistroCostos = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'costs.get');
SET @calcularRentabilidad = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'profitability.calculate');
SET @listarRentabilidad = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'profitability.list');
SET @obtenerRentabilidad = (SELECT IdPermisos FROM Permisos WHERE NombrePermisos = 'profitability.get');


-- Insertar permisos para administrador
INSERT INTO RolesPermisos (idRol, idPermiso)
VALUES
(@idRolAdmin, @crearUsuario),
(@idRolAdmin, @editarUsuario),
(@idRolAdmin, @desactivarUsuario),
(@idRolAdmin, @eliminarUsuario),
(@idRolAdmin, @asignarRoles),
(@idRolAdmin, @listarPermisos),
(@idRolAdmin, @listarRoles),
(@idRolAdmin, @listarRolesPermisos),
(@idRolAdmin, @configurarPermisos),
(@idRolAdmin, @listarUsuarios),
(@idRolAdmin, @obtenerUsuario),
(@idRolAdmin, @generarReportes),
(@idRolAdmin, @listarReportes),
(@idRolAdmin, @obtenerReporte),
(@idRolAdmin, @listarPlanificacionesSiembra),
(@idRolAdmin, @obtenerPlanificacionSiembra),
(@idRolAdmin, @listarInventario),
(@idRolAdmin, @obtenerProductoInventario),
(@idRolAdmin, @obtenerRegistroCostos),
(@idRolAdmin, @listarRentabilidad),
(@idRolAdmin, @obtenerRentabilidad);

-- Insertar permisos para Usuario operativo
INSERT INTO RolesPermisos (idRol, idPermiso)
VALUES
(@idRolUsuario, @planificarSiembra),
(@idRolUsuario, @editarPlanificacionSiembra),
(@idRolUsuario, @listarPlanificacionesSiembra),
(@idRolUsuario, @obtenerPlanificacionSiembra),
(@idRolUsuario, @registrarInventario),
(@idRolUsuario, @editarInventario),
(@idRolUsuario, @listarInventario),
(@idRolUsuario, @obtenerProductoInventario),
(@idRolUsuario, @llevarRegistroCostos),
(@idRolUsuario, @editarRegistroCostos),
(@idRolUsuario, @listarRegistrosCostos),
(@idRolUsuario, @obtenerRegistroCostos),
(@idRolUsuario, @generarReportes),
(@idRolUsuario, @listarReportes),
(@idRolUsuario, @obtenerReporte);

COMMIT;
