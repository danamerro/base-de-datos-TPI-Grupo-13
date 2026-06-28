USE LaboratorioEnsayosElectricos;
GO

DROP VIEW IF EXISTS VW_Marcas;
GO

DROP VIEW IF EXISTS VW_Herramientas;
GO

DROP VIEW IF EXISTS VW_Clientes;
GO

DROP VIEW IF EXISTS VW_Pedidos;
GO

DROP VIEW IF EXISTS VW_Empleados;
GO

DROP VIEW IF EXISTS VW_Ingresos;
GO

DROP VIEW IF EXISTS VW_Registros;
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
	m.Nombre AS 'Marca',
	th.Nombre AS 'Tipo de herramienta',
	h.Nombre AS 'Herramienta',
	th.Descripcion AS 'Descripcion de herramienta'
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
	h.Nombre AS 'Herramienta',
	h.Clase,
	p.Cantidad,
	p.FechaEmision AS 'Fecha de emision',
	p.FechaEntrega AS 'Fecha de entrega'
FROM
	PEDIDOS p
	INNER JOIN CLIENTES c ON p.IdCliente = c.IdCliente
	INNER JOIN HERRAMIENTAS h ON p.IdHerramienta = h.IdHerramienta;
GO

-- VISTA DE EMPLEADOS --

CREATE VIEW VW_Empleados
AS
SELECT
	e.Legajo,
	e.DNI,
	e.Apellido + ', ' + e.Nombre AS 'Empleado',
	n.Nivel,
	n.Permiso
FROM
	EMPLEADOS e
	INNER JOIN NIVELES n ON e.IdNivel = n.IdNivel;
GO

-- VISTAS DE INGRESOS DE MATERIAL --

CREATE VIEW VW_Ingresos
AS
SELECT 
    i.Serie AS 'Numero de serie',
    i.Precinto AS 'Numero interno',
    p.Pedido AS 'Numero de pedido', 
    c.RazonSocial AS 'Cliente',
    th.Nombre AS 'Tipo de herramienta',
    h.Nombre AS 'Herramienta',
    h.Modelo,
    h.Clase
FROM
	INGRESOS i
    INNER JOIN PEDIDOS p ON i.IdPedido = p.IdPedido 
	INNER JOIN CLIENTES c ON p.IdCliente = c.IdCliente
	INNER JOIN HERRAMIENTAS h ON p.IdHerramienta = h.IdHerramienta
	INNER JOIN TIPOS_HERRAMIENTAS th ON h.IdTipoHerramienta = th.IdTipoHerramienta;
GO

-- VISTAS DE REGISTROS --

CREATE VIEW VW_Registros
AS
SELECT
	i.Serie AS 'Numero de serie',
	i.Precinto AS 'Numero interno',
	h.Modelo,
	m.Nombre AS Marca,
	th.Nombre AS 'Tipo de herramienta',
	h.Nombre AS 'Herramienta',
	h.Clase,
	c.RazonSocial AS Cliente,
	p.Pedido AS 'Numero de pedido',
	te.Nombre AS 'Tipo de ensayo',
	r.Resultado,
	r.FechaEnsayo AS 'Fecha de ensayo',
	r.Humedad AS 'Humedad (HR%)',
	r.Temperatura AS 'Temperatura (°C)',
	r.Observaciones,
	e.Apellido + ', ' + e.Nombre AS 'Empleado',
	e.Legajo AS 'Legajo del Empleado'
FROM
	REGISTROS r
	INNER JOIN INGRESOS i ON r.IdIngreso = i.IdIngreso
	INNER JOIN PEDIDOS p ON i.IdPedido = p.IdPedido
	INNER JOIN CLIENTES c ON  p.IdCliente = c.IdCliente
	INNER JOIN HERRAMIENTAS h ON p.IdHerramienta = h.IdHerramienta
	INNER JOIN TIPOS_HERRAMIENTAS th ON h.IdTipoHerramienta = th.IdTipoHerramienta
	INNER JOIN MARCAS m ON h.IdMarca = m.IdMarca
	INNER JOIN EMPLEADOS e ON r.IdEmpleado = e.IdEmpleado
	INNER JOIN TIPOS_ENSAYO te ON r.IdTipoEnsayo = te.IdTipoEnsayo;
GO