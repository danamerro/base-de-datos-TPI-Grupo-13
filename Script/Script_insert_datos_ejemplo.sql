USE LaboratorioEnsayosElectricos;
GO

SET NOCOUNT ON;


-- DATOS DE EJEMPLO - MARCAS


IF NOT EXISTS (SELECT 1 FROM MARCAS WHERE Nombre = 'ELECTROSAFE')
BEGIN
INSERT INTO MARCAS (Nombre, Descripcion)
VALUES ('ELECTROSAFE', 'Marca especializada en elementos de proteccion electrica.');
END;

IF NOT EXISTS (SELECT 1 FROM MARCAS WHERE Nombre = 'MEGATEST')
BEGIN
INSERT INTO MARCAS (Nombre, Descripcion)
VALUES ('MEGATEST', 'Marca de instrumentos de medicion y ensayo electrico.');
END;

IF NOT EXISTS (SELECT 1 FROM MARCAS WHERE Nombre = 'PROTECTA')
BEGIN
INSERT INTO MARCAS (Nombre, Descripcion)
VALUES ('PROTECTA', 'Marca de herramientas aisladas para trabajos electricos.');
END;


-- DATOS DE EJEMPLO - TIPOS DE HERRAMIENTAS


IF NOT EXISTS (SELECT 1 FROM TIPOS_HERRAMIENTAS WHERE Nombre = 'Guantes dielectricos')
BEGIN
INSERT INTO TIPOS_HERRAMIENTAS (Nombre, Descripcion)
VALUES ('Guantes dielectricos', 'Guantes aislantes utilizados para trabajos con tension.');
END;

IF NOT EXISTS (SELECT 1 FROM TIPOS_HERRAMIENTAS WHERE Nombre = 'Pertigas aislantes')
BEGIN
INSERT INTO TIPOS_HERRAMIENTAS (Nombre, Descripcion)
VALUES ('Pertigas aislantes', 'Herramientas aislantes utilizadas para maniobras electricas.');
END;

IF NOT EXISTS (SELECT 1 FROM TIPOS_HERRAMIENTAS WHERE Nombre = 'Detector de tension')
BEGIN
INSERT INTO TIPOS_HERRAMIENTAS (Nombre, Descripcion)
VALUES ('Detector de tension', 'Equipo utilizado para detectar presencia de tension electrica.');
END;


-- DATOS DE EJEMPLO - TIPOS DE ENSAYO


IF NOT EXISTS (SELECT 1 FROM TIPOS_ENSAYO WHERE Nombre = 'Ensayo de rigidez dielectrica')
BEGIN
INSERT INTO TIPOS_ENSAYO (Nombre, Descripcion, Procedimiento)
VALUES (
'Ensayo de rigidez dielectrica',
'Verifica la capacidad aislante del elemento frente a tension aplicada.',
'Aplicar tension controlada durante el tiempo establecido por norma.'
);
END;

IF NOT EXISTS (SELECT 1 FROM TIPOS_ENSAYO WHERE Nombre = 'Ensayo de continuidad')
BEGIN
INSERT INTO TIPOS_ENSAYO (Nombre, Descripcion, Procedimiento)
VALUES (
'Ensayo de continuidad',
'Verifica continuidad electrica en equipos o herramientas de medicion.',
'Medir continuidad con instrumental calibrado y registrar resultado.'
);
END;

IF NOT EXISTS (SELECT 1 FROM TIPOS_ENSAYO WHERE Nombre = 'Calibracion de detector')
BEGIN
INSERT INTO TIPOS_ENSAYO (Nombre, Descripcion, Procedimiento)
VALUES (
'Calibracion de detector',
'Controla la respuesta operativa del detector de tension.',
'Comparar lectura del detector contra patron de referencia.'
);
END;


-- DATOS DE EJEMPLO - CLIENTES


IF NOT EXISTS (SELECT 1 FROM CLIENTES WHERE Cuit = '30-71234567-8')
BEGIN
INSERT INTO CLIENTES (Nombre, RazonSocial, Cuit, Email, Telefono, Direccion, Observaciones)
VALUES (
'Energia Cordoba',
'Energia Cordoba S.A.',
'30-71234567-8',
'[contacto@energiacordoba.com](mailto:contacto@energiacordoba.com)',
'3514567890',
'Av Colon 1200, Cordoba',
NULL
);
END;

IF NOT EXISTS (SELECT 1 FROM CLIENTES WHERE Cuit = '30-70999888-1')
BEGIN
INSERT INTO CLIENTES (Nombre, RazonSocial, Cuit, Email, Telefono, Direccion, Observaciones)
VALUES (
'Servicios Electricos del Sur',
'Servicios Electricos del Sur S.R.L.',
'30-70999888-1',
'[administracion@sesur.com](mailto:administracion@sesur.com)',
'2994455667',
'San Martin 450, Neuquen',
'Cliente con prioridad en ensayos de alta tension.'
);
END;

IF NOT EXISTS (SELECT 1 FROM CLIENTES WHERE Cuit = '30-70111222-5')
BEGIN
INSERT INTO CLIENTES (Nombre, RazonSocial, Cuit, Email, Telefono, Direccion, Observaciones)
VALUES (
'Mantenimiento Industrial Norte',
'Mantenimiento Industrial Norte S.A.',
'30-70111222-5',
'[info@minorte.com](mailto:info@minorte.com)',
'1144456677',
'Av Belgrano 890, CABA',
NULL
);
END;


-- DATOS DE EJEMPLO - HERRAMIENTAS


IF NOT EXISTS (SELECT 1 FROM HERRAMIENTAS WHERE Nombre = 'Guante aislante BT')
BEGIN
INSERT INTO HERRAMIENTAS (Nombre, Modelo, Clase, IdMarca, IdTipoHerramienta)
SELECT
'Guante aislante BT',
'GD-BT-100',
'Clase 00',
m.IdMarca,
th.IdTipoHerramienta
FROM MARCAS m
INNER JOIN TIPOS_HERRAMIENTAS th ON th.Nombre = 'Guantes dielectricos'
WHERE m.Nombre = 'ELECTROSAFE';
END;

IF NOT EXISTS (SELECT 1 FROM HERRAMIENTAS WHERE Nombre = 'Guante aislante MT')
BEGIN
INSERT INTO HERRAMIENTAS (Nombre, Modelo, Clase, IdMarca, IdTipoHerramienta)
SELECT
'Guante aislante MT',
'GD-MT-200',
'Clase 2',
m.IdMarca,
th.IdTipoHerramienta
FROM MARCAS m
INNER JOIN TIPOS_HERRAMIENTAS th ON th.Nombre = 'Guantes dielectricos'
WHERE m.Nombre = 'ELECTROSAFE';
END;

IF NOT EXISTS (SELECT 1 FROM HERRAMIENTAS WHERE Nombre = 'Pertiga telescopica')
BEGIN
INSERT INTO HERRAMIENTAS (Nombre, Modelo, Clase, IdMarca, IdTipoHerramienta)
SELECT
'Pertiga telescopica',
'PT-500',
'',
m.IdMarca,
th.IdTipoHerramienta
FROM MARCAS m
INNER JOIN TIPOS_HERRAMIENTAS th ON th.Nombre = 'Pertigas aislantes'
WHERE m.Nombre = 'PROTECTA';
END;

IF NOT EXISTS (SELECT 1 FROM HERRAMIENTAS WHERE Nombre = 'Detector digital de tension')
BEGIN
INSERT INTO HERRAMIENTAS (Nombre, Modelo, Clase, IdMarca, IdTipoHerramienta)
SELECT
'Detector digital de tension',
'DT-900',
'',
m.IdMarca,
th.IdTipoHerramienta
FROM MARCAS m
INNER JOIN TIPOS_HERRAMIENTAS th ON th.Nombre = 'Detector de tension'
WHERE m.Nombre = 'MEGATEST';
END;


-- DATOS DE EJEMPLO - PEDIDOS


IF NOT EXISTS (SELECT 1 FROM PEDIDOS WHERE Pedido = 'PED-0001')
BEGIN
INSERT INTO PEDIDOS (Pedido, IdCliente, IdHerramienta, Cantidad, FechaEntrega, FechaEmision)
SELECT
'PED-0001',
c.IdCliente,
h.IdHerramienta,
2,
'2026-06-30',
'2026-06-20'
FROM CLIENTES c
INNER JOIN HERRAMIENTAS h ON h.Nombre = 'Guante aislante BT'
WHERE c.Cuit = '30-71234567-8';
END;

IF NOT EXISTS (SELECT 1 FROM PEDIDOS WHERE Pedido = 'PED-0002')
BEGIN
INSERT INTO PEDIDOS (Pedido, IdCliente, IdHerramienta, Cantidad, FechaEntrega, FechaEmision)
SELECT
'PED-0002',
c.IdCliente,
h.IdHerramienta,
1,
'2026-07-05',
'2026-06-21'
FROM CLIENTES c
INNER JOIN HERRAMIENTAS h ON h.Nombre = 'Pertiga telescopica'
WHERE c.Cuit = '30-70999888-1';
END;

IF NOT EXISTS (SELECT 1 FROM PEDIDOS WHERE Pedido = 'PED-0003')
BEGIN
INSERT INTO PEDIDOS (Pedido, IdCliente, IdHerramienta, Cantidad, FechaEntrega, FechaEmision)
SELECT
'PED-0003',
c.IdCliente,
h.IdHerramienta,
1,
'2026-07-10',
'2026-06-22'
FROM CLIENTES c
INNER JOIN HERRAMIENTAS h ON h.Nombre = 'Detector digital de tension'
WHERE c.Cuit = '30-70111222-5';
END;

IF NOT EXISTS (SELECT 1 FROM PEDIDOS WHERE Pedido = 'PED-0004')
BEGIN
INSERT INTO PEDIDOS (Pedido, IdCliente, IdHerramienta, Cantidad, FechaEntrega, FechaEmision)
SELECT
'PED-0004',
c.IdCliente,
h.IdHerramienta,
3,
'2026-07-15',
'2026-06-23'
FROM CLIENTES c
INNER JOIN HERRAMIENTAS h ON h.Nombre = 'Guante aislante MT'
WHERE c.Cuit = '30-71234567-8';
END;

IF NOT EXISTS (SELECT 1 FROM PEDIDOS WHERE Pedido = 'PED-0005')
BEGIN
INSERT INTO PEDIDOS (Pedido, IdCliente, IdHerramienta, Cantidad, FechaEntrega, FechaEmision)
SELECT
'PED-0005',
c.IdCliente,
h.IdHerramienta,
1,
'2026-07-20',
'2026-06-24'
FROM CLIENTES c
INNER JOIN HERRAMIENTAS h ON h.Nombre = 'Detector digital de tension'
WHERE c.Cuit = '30-70999888-1';
END;


-- DATOS DE EJEMPLO - INGRESOS


IF NOT EXISTS (SELECT 1 FROM INGRESOS WHERE Precinto = 'PREC-0001')
BEGIN
INSERT INTO INGRESOS (Serie, Precinto, IdPedido)
SELECT 'SER-1001', 'PREC-0001', IdPedido
FROM PEDIDOS
WHERE Pedido = 'PED-0001';
END;

IF NOT EXISTS (SELECT 1 FROM INGRESOS WHERE Precinto = 'PREC-0002')
BEGIN
INSERT INTO INGRESOS (Serie, Precinto, IdPedido)
SELECT 'SER-1002', 'PREC-0002', IdPedido
FROM PEDIDOS
WHERE Pedido = 'PED-0002';
END;

IF NOT EXISTS (SELECT 1 FROM INGRESOS WHERE Precinto = 'PREC-0003')
BEGIN
INSERT INTO INGRESOS (Serie, Precinto, IdPedido)
SELECT 'SER-1003', 'PREC-0003', IdPedido
FROM PEDIDOS
WHERE Pedido = 'PED-0003';
END;

IF NOT EXISTS (SELECT 1 FROM INGRESOS WHERE Precinto = 'PREC-0004')
BEGIN
INSERT INTO INGRESOS (Serie, Precinto, IdPedido)
SELECT 'SER-1004', 'PREC-0004', IdPedido
FROM PEDIDOS
WHERE Pedido = 'PED-0004';
END;

IF NOT EXISTS (SELECT 1 FROM INGRESOS WHERE Precinto = 'PREC-0005')
BEGIN
INSERT INTO INGRESOS (Serie, Precinto, IdPedido)
SELECT 'SER-1005', 'PREC-0005', IdPedido
FROM PEDIDOS
WHERE Pedido = 'PED-0005';
END;


-- DATOS DE EJEMPLO - NIVELES


IF NOT EXISTS (SELECT 1 FROM NIVELES WHERE Nivel = 'Tecnico Rigidez Dielectrica')
BEGIN
INSERT INTO NIVELES (Nivel, IdTipoEnsayo, Permiso)
SELECT
'Tecnico Rigidez Dielectrica',
IdTipoEnsayo,
'Puede realizar ensayos de rigidez dielectrica'
FROM TIPOS_ENSAYO
WHERE Nombre = 'Ensayo de rigidez dielectrica';
END;

IF NOT EXISTS (SELECT 1 FROM NIVELES WHERE Nivel = 'Tecnico Continuidad')
BEGIN
INSERT INTO NIVELES (Nivel, IdTipoEnsayo, Permiso)
SELECT
'Tecnico Continuidad',
IdTipoEnsayo,
'Puede realizar ensayos de continuidad'
FROM TIPOS_ENSAYO
WHERE Nombre = 'Ensayo de continuidad';
END;

IF NOT EXISTS (SELECT 1 FROM NIVELES WHERE Nivel = 'Tecnico Calibracion')
BEGIN
INSERT INTO NIVELES (Nivel, IdTipoEnsayo, Permiso)
SELECT
'Tecnico Calibracion',
IdTipoEnsayo,
'Puede realizar calibraciones de detectores'
FROM TIPOS_ENSAYO
WHERE Nombre = 'Calibracion de detector';
END;

IF NOT EXISTS (SELECT 1 FROM NIVELES WHERE Nivel = 'Supervisor General')
BEGIN
INSERT INTO NIVELES (Nivel, IdTipoEnsayo, Permiso)
VALUES (
'Supervisor General',
NULL,
'Puede supervisar y registrar cualquier tipo de ensayo'
);
END;


-- DATOS DE EJEMPLO - EMPLEADOS

IF NOT EXISTS (SELECT 1 FROM EMPLEADOS WHERE DNI = '32111222')
BEGIN
INSERT INTO EMPLEADOS (DNI, Legajo, Nombre, Apellido, IdNivel)
SELECT
'32111222',
'LEG-001',
'Ana',
'Ruiz',
IdNivel
FROM NIVELES
WHERE Nivel = 'Tecnico Rigidez Dielectrica';
END;

IF NOT EXISTS (SELECT 1 FROM EMPLEADOS WHERE DNI = '33222333')
BEGIN
INSERT INTO EMPLEADOS (DNI, Legajo, Nombre, Apellido, IdNivel)
SELECT
'33222333',
'LEG-002',
'Carlos',
'Vega',
IdNivel
FROM NIVELES
WHERE Nivel = 'Tecnico Continuidad';
END;

IF NOT EXISTS (SELECT 1 FROM EMPLEADOS WHERE DNI = '34333444')
BEGIN
INSERT INTO EMPLEADOS (DNI, Legajo, Nombre, Apellido, IdNivel)
SELECT
'34333444',
'LEG-003',
'Marta',
'Sosa',
IdNivel
FROM NIVELES
WHERE Nivel = 'Supervisor General';
END;

IF NOT EXISTS (SELECT 1 FROM EMPLEADOS WHERE DNI = '35444555')
BEGIN
INSERT INTO EMPLEADOS (DNI, Legajo, Nombre, Apellido, IdNivel)
SELECT
'35444555',
'LEG-004',
'Pedro',
'Molina',
IdNivel
FROM NIVELES
WHERE Nivel = 'Tecnico Calibracion';
END;


-- DATOS DE EJEMPLO - REGISTROS DE ENSAYOS

IF NOT EXISTS (
SELECT 1
FROM REGISTROS r
INNER JOIN INGRESOS i ON r.IdIngreso = i.IdIngreso
WHERE i.Precinto = 'PREC-0001'
)
BEGIN
INSERT INTO REGISTROS (
IdIngreso,
IdTipoEnsayo,
Resultado,
FechaEnsayo,
Humedad,
Temperatura,
Observaciones,
IdEmpleado
)
SELECT
i.IdIngreso,
te.IdTipoEnsayo,
'SATISFACTORIO',
'2026-06-25',
45,
22.5,
'Ensayo realizado sin observaciones tecnicas.',
e.IdEmpleado
FROM INGRESOS i
INNER JOIN TIPOS_ENSAYO te ON te.Nombre = 'Ensayo de rigidez dielectrica'
INNER JOIN EMPLEADOS e ON e.DNI = '32111222'
WHERE i.Precinto = 'PREC-0001';
END;

IF NOT EXISTS (
SELECT 1
FROM REGISTROS r
INNER JOIN INGRESOS i ON r.IdIngreso = i.IdIngreso
WHERE i.Precinto = 'PREC-0002'
)
BEGIN
INSERT INTO REGISTROS (
IdIngreso,
IdTipoEnsayo,
Resultado,
FechaEnsayo,
Humedad,
Temperatura,
Observaciones,
IdEmpleado
)
SELECT
i.IdIngreso,
te.IdTipoEnsayo,
'NO SATISFACTORIO',
'2026-06-26',
50,
24.0,
'Se detecta desgaste en el aislamiento.',
e.IdEmpleado
FROM INGRESOS i
INNER JOIN TIPOS_ENSAYO te ON te.Nombre = 'Ensayo de rigidez dielectrica'
INNER JOIN EMPLEADOS e ON e.DNI = '34333444'
WHERE i.Precinto = 'PREC-0002';
END;

IF NOT EXISTS (
SELECT 1
FROM REGISTROS r
INNER JOIN INGRESOS i ON r.IdIngreso = i.IdIngreso
WHERE i.Precinto = 'PREC-0003'
)
BEGIN
INSERT INTO REGISTROS (
IdIngreso,
IdTipoEnsayo,
Resultado,
FechaEnsayo,
Humedad,
Temperatura,
Observaciones,
IdEmpleado
)
SELECT
i.IdIngreso,
te.IdTipoEnsayo,
'CALIBRACION',
'2026-06-27',
40,
21.0,
NULL,
e.IdEmpleado
FROM INGRESOS i
INNER JOIN TIPOS_ENSAYO te ON te.Nombre = 'Calibracion de detector'
INNER JOIN EMPLEADOS e ON e.DNI = '35444555'
WHERE i.Precinto = 'PREC-0003';
END;


-- CONSULTAS DE CONTROL
SELECT * FROM MARCAS;
SELECT * FROM TIPOS_HERRAMIENTAS;
SELECT * FROM TIPOS_ENSAYO;
SELECT * FROM CLIENTES;
SELECT * FROM HERRAMIENTAS;
SELECT * FROM PEDIDOS;
SELECT * FROM INGRESOS;
SELECT * FROM NIVELES;
SELECT * FROM EMPLEADOS;
SELECT * FROM REGISTROS;
GO

