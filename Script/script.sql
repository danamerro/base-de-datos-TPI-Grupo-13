USE master
GO
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'LaboratorioEnsayosElectricos')
BEGIN
    CREATE DATABASE LaboratorioEnsayosElectricos;
END
GO

USE LaboratorioEnsayosElectricos;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MARCAS]') AND type in (N'U'))
BEGIN
    CREATE TABLE MARCAS (
        IdMarca INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(50) UNIQUE NOT NULL,
        Descripcion VARCHAR(100) NOT NULL,

        PRIMARY KEY (IdMarca)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPOS_HERRAMIENTAS]') AND type in (N'U'))
BEGIN
    CREATE TABLE TIPOS_HERRAMIENTAS(
        IdTipoHerramienta INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(100) UNIQUE NOT NULL,
        Descripcion VARCHAR(255) NULL,

        PRIMARY KEY (IdTipoHerramienta)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TIPOS_ENSAYO]') AND type in (N'U'))
BEGIN
    CREATE TABLE TIPOS_ENSAYO(
        IdTipoEnsayo INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(100) UNIQUE NOT NULL,
        Descripcion VARCHAR(255) NULL,
        Procedimiento VARCHAR(255) NOT NULL,

        PRIMARY KEY (IdTipoEnsayo)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HERRAMIENTAS]') AND type in (N'U'))
BEGIN
    CREATE TABLE HERRAMIENTAS (
        IdHerramienta INT IDENTITY(1,1) NOT NULL,
        Modelo VARCHAR(100) UNIQUE NULL,
        Clase VARCHAR(10) NOT NULL,
        IdMarca INT NOT NULL,
        IdTipoHerramienta INT NOT NULL,

        PRIMARY KEY (IdHerramienta),
        FOREIGN KEY (IdMarca) REFERENCES [dbo].[MARCAS](IdMarca),
        FOREIGN KEY (IdTipoHerramienta) REFERENCES [dbo].[TIPOS_HERRAMIENTAS](IdTipoHerramienta)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLIENTES]') AND type in (N'U'))
BEGIN
    CREATE TABLE CLIENTES (
        IdCliente INT IDENTITY(1,1) NOT NULL,
        Nombre VARCHAR(100) NOT NULL,
        RazonSocial VARCHAR(100) NOT NULL,
        Cuit VARCHAR(20) NOT NULL,
        Email VARCHAR(100) UNIQUE NOT NULL,
        Telefono VARCHAR(20) UNIQUE NOT NULL,
        Direccion VARCHAR(100) NOT NULL,
        Observaciones VARCHAR(255) NOT NULL,

        PRIMARY KEY (IdCliente)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PEDIDOS]') AND type in (N'U'))
BEGIN
    CREATE TABLE PEDIDOS(
        IdPedido INT IDENTITY(1,1) NOT NULL,
        Pedido VARCHAR(50) UNIQUE NOT NULL,
        IdCliente INT NOT NULL,
        IdHerramienta INT NOT NULL,
        Cantidad INT NOT NULL CHECK (Cantidad > 0),
        FechaEntrega DATE NOT NULL,
        FechaEmision DATE NOT NULL DEFAULT GETDATE(),

        PRIMARY KEY (IdPedido),
        FOREIGN KEY (IdCliente) REFERENCES [dbo].[CLIENTES](IdCliente),
        FOREIGN KEY (IdHerramienta) REFERENCES [dbo].[HERRAMIENTAS](IdHerramienta)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[INGRESOS]') AND type in (N'U'))
BEGIN
    CREATE TABLE INGRESOS (
        IdIngreso INT IDENTITY(1,1) NOT NULL,
        Serie VARCHAR(100) NULL DEFAULT '--',
        Precinto VARCHAR(100) NOT NULL,
        IdPedido INT NOT NULL,

        PRIMARY KEY (IdIngreso),
        FOREIGN KEY (IdPedido) REFERENCES [dbo].[PEDIDOS](IdPedido)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NIVELES]') AND type in (N'U'))
BEGIN
    CREATE TABLE NIVELES(
        IdNivel INT IDENTITY(1,1) NOT NULL,
        Nivel VARCHAR(100) UNIQUE NOT NULL,
        IdTipoEnsayo INT NULL,
        Permiso VARCHAR(50) NOT NULL,

        PRIMARY KEY (IdNivel),
        FOREIGN KEY (IdTipoEnsayo) REFERENCES [dbo].[TIPOS_ENSAYO](IdTipoEnsayo)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EMPLEADOS]') AND type in (N'U'))
BEGIN
    CREATE TABLE EMPLEADOS(
        IdEmpleado INT IDENTITY(1,1) NOT NULL,
        DNI VARCHAR(20) UNIQUE NOT NULL,
        Legajo VARCHAR(20) UNIQUE NOT NULL,
        Nombre VARCHAR(100) NOT NULL,
        Apellido VARCHAR(100) NOT NULL,
        IdNivel INT NOT NULL,

        PRIMARY KEY (IdEmpleado),
        FOREIGN KEY (IdNivel) REFERENCES [dbo].[NIVELES](IdNivel)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[REGISTROS]') AND type in (N'U'))
BEGIN
    CREATE TABLE REGISTROS(
        IdRegistro INT IDENTITY(1,1) NOT NULL,
        IdIngreso INT UNIQUE NOT NULL,
        IdTipoEnsayo INT NOT NULL,
        Resultado VARCHAR(100) NOT NULL,
        FechaEnsayo DATE NOT NULL DEFAULT GETDATE(),
        Humedad INT NOT NULL CHECK (Humedad >= 0 AND Humedad <= 100),
        Temperatura FLOAT NOT NULL,
        Observaciones VARCHAR(255) NOT NULL,
        IdEmpleado INT NOT NULL,

        PRIMARY KEY (IdRegistro),
        FOREIGN KEY (IdIngreso) REFERENCES [dbo].[INGRESOS](IdIngreso),
        FOREIGN KEY (IdTipoEnsayo) REFERENCES [dbo].[TIPOS_ENSAYO](IdTipoEnsayo),
        FOREIGN KEY (IdEmpleado) REFERENCES [dbo].[EMPLEADOS](IdEmpleado)
    );
END
GO