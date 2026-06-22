USE master
GO

USE LaboratorioEnsayosElectricos;
GO

-- VISTA DE MARCAS --

CREATE VIEW VW_Marcas
AS
SELECT
	Nombre,
	Descripcion
FROM MARCAS;
GO

-- VISTA DE HERRAMIENTAS --

CREATE VIEW VW_Herramientas
AS
SELECT
	h.Modelo,
	h.Clase,
	m.Nombre,
	th.Nombre as 'Tipo de herramienta',
	th.Descripcion as 'Descripcion de herramienta'
FROM
	HERRAMIENTAS h
	INNER JOIN MARCAS m ON h.IdMarca = m.IdMarca
	INNER JOIN TIPOS_HERRAMIENTAS th ON h.IdTipoHerramienta = th.IdTipoHerramienta;
GO

-- VISTA DE CLIENTES --

CREATE VIEW VW_Clientes
AS
SELECT
	Nombre,
	RazonSocial,
	Cuit,
	Email,
	Telefono,
	Direccion,
	Observaciones
FROM CLIENTES;
GO

-- VISTA DE PEDIDOS --

CREATE VIEW VW_Pedidos
AS
SELECT
	p.Pedido AS 'Numero de pedido',
	c.Nombre AS Cliente,
	c.RazonSocial as 'Razon social',
	c.Email,
	(SELECT th.Nombre FROM HERRAMIENTAS h INNER JOIN TIPOS_HERRAMIENTAS th ON h.IdTipoHerramienta = th.IdTipoHerramienta) AS 'Tipo de herramienta',
	h.Clase,
	p.Cantidad,
	p.FechaEmision AS 'Fechad de emision',
	p.FechaEntrega AS 'Fecha de entrega'
FROM
	PEDIDOS P
	INNER JOIN CLIENTES c ON p.IdCliente = c.IdCliente
	INNER JOIN HERRAMIENTAS h ON p.IdHerramienta = h.IdHerramienta
GO

-- VISTA DE EMPLEADOS --

CREATE VIEW VW_Empleados
AS
SELECT
	e.Legajo,
	e.DNI,
	e.Apellido + ', ' + e.Nombre AS 'Nombre',
	CASE WHEN n.Nivel = 0 THEN 'Pasante'
		 WHEN n.Nivel = 1 THEN 'Empleado'
		 WHEN n.Nivel = 2 THEN 'Supervisor'
		 WHEN n.Nivel = 3 THEN 'Administrador'
		 END AS 'Rol'
FROM
	EMPLEADOS e
	INNER JOIN NIVELES n ON e.IdNivel = n.IdNivel
GO

-- VISTAS DE INGRESOS DE MATERIAL --

CREATE VIEW VW_Ingresos
AS
SELECT 
    c.Nombre AS Cliente, 
    c.RazonSocial AS Empresa,
    th.Nombre AS 'Tipo de herramienta'
FROM
	PEDIDOS p
	INNER JOIN CLIENTES c ON p.IdCliente = c.IdCliente
	INNER JOIN HERRAMIENTAS h ON p.IdHerramienta = h.IdHerramienta
	INNER JOIN TIPOS_HERRAMIENTAS th ON h.IdTipoHerramienta = th.IdTipoHerramienta;
GO

-- VISTAS DE REGISTROS --

CREATE VIEW VW_Registros
AS
SELECT
	i.Serie AS 'Numero de serie',
	i.Precinto AS 'Numero Interno',
	h.Modelo,
	m.Nombre AS Marca,
	th.Nombre AS 'Tipo de Herramienta',
	h.Clase,
	c.RazonSocial AS Cliente,
	p.Pedido AS 'N° Pedido',
	r.Resultado,
	r.FechaEnsayo AS 'Fecha de ensayo',
	r.Humedad AS 'Humedad (HR%)',
	r.Temperatura AS 'Temperatura (°C)',
	r.Observaciones,
	e.Legajo AS 'Legajo del Empleado'
FROM
	REGISTROS r
	INNER JOIN INGRESOS i ON r.IdIngreso = i.IdIngreso
	INNER JOIN PEDIDOS p ON i.IdPedido = p.IdPedido
	INNER JOIN CLIENTES c ON  p.IdCliente = c.IdCliente
	INNER JOIN HERRAMIENTAS h ON p.IdHerramienta = h.IdHerramienta
	INNER JOIN TIPOS_HERRAMIENTAS th ON h.IdTipoHerramienta = th.IdTipoHerramienta
	INNER JOIN MARCAS m ON h.IdMarca = m.IdMarca
	INNER JOIN EMPLEADOS E ON r.IdEmpleado = e.IdEmpleado
GO