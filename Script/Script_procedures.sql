DROP PROCEDURE IF EXISTS sp_UpdateRegistro;
GO

CREATE OR ALTER PROCEDURE sp_UpdateRegistro (
    @idingreso INT,
    @idtipoensayo INT,
    @resultado VARCHAR(100),
    @fechaensayo DATE,
    @humedad INT,
    @temperatura FLOAT,
    @observaciones VARCHAR(255) = NULL,
    @idempleado INT
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @idingreso IS NULL
    BEGIN
        RAISERROR('El IdIngreso es obligatorio.', 16, 1);
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM INGRESOS
        WHERE IdIngreso = @idingreso
    )
    BEGIN
        RAISERROR('El ingreso indicado no existe.', 16, 2);
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM REGISTROS
        WHERE IdIngreso = @idingreso
    )
    BEGIN
        RAISERROR('El ingreso indicado no tiene un registro de ensayo asociado para actualizar.', 16, 3);
        RETURN;
    END;

    IF @idtipoensayo IS NULL
    BEGIN
        RAISERROR('El tipo de ensayo es obligatorio.', 16, 4);
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM TIPOS_ENSAYO
        WHERE IdTipoEnsayo = @idtipoensayo
    )
    BEGIN
        RAISERROR('El tipo de ensayo indicado no existe.', 16, 5);
        RETURN;
    END;

    IF @idempleado IS NULL
    BEGIN
        RAISERROR('El empleado es obligatorio.', 16, 6);
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM EMPLEADOS
        WHERE IdEmpleado = @idempleado
    )
    BEGIN
        RAISERROR('El empleado indicado no existe.', 16, 7);
        RETURN;
    END;

    IF @resultado IS NULL OR @resultado NOT IN (
        'SATISFACTORIO',
        'NO SATISFACTORIO',
        'NO SE ENSAYA',
        'CALIBRACION'
    )
    BEGIN
        RAISERROR('El resultado ingresado no es valido.', 16, 8);
        RETURN;
    END;

    IF @fechaensayo IS NULL
    BEGIN
        RAISERROR('La fecha de ensayo es obligatoria.', 16, 9);
        RETURN;
    END;

    IF @fechaensayo > CAST(GETDATE() AS DATE)
    BEGIN
        RAISERROR('La fecha de ensayo no puede ser futura.', 16, 10);
        RETURN;
    END;

    IF @humedad IS NULL OR @humedad < 0 OR @humedad > 100
    BEGIN
        RAISERROR('La humedad debe estar entre 0 y 100.', 16, 11);
        RETURN;
    END;

    IF @temperatura IS NULL OR @temperatura < -10.0 OR @temperatura > 60.0
    BEGIN
        RAISERROR('La temperatura debe estar entre -10.0 y 60.0.', 16, 12);
        RETURN;
    END;

    UPDATE REGISTROS
    SET
        IdTipoEnsayo = @idtipoensayo,
        Resultado = @resultado,
        FechaEnsayo = @fechaensayo,
        Humedad = @humedad,
        Temperatura = @temperatura,
        Observaciones = @observaciones,
        IdEmpleado = @idempleado
    WHERE IdIngreso = @idingreso;
END;
GO

DROP PROCEDURE IF EXISTS sp_InsertRegistro;
GO

CREATE OR ALTER PROCEDURE sp_InsertRegistro (
    @idingreso INT,
    @idtipoensayo INT,
    @resultado VARCHAR(100),
    @fechaensayo DATE,
    @humedad INT,
    @temperatura FLOAT,
    @observaciones VARCHAR(255) = NULL,
    @idempleado INT
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @idingreso IS NULL
    BEGIN
        RAISERROR('El IdIngreso es obligatorio.', 16, 1);
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM INGRESOS
        WHERE IdIngreso = @idingreso
    )
    BEGIN
        RAISERROR('El ingreso indicado no existe.', 16, 2);
        RETURN;
    END;

    IF EXISTS (
        SELECT 1
        FROM REGISTROS
        WHERE IdIngreso = @idingreso
    )
    BEGIN
        RAISERROR('El ingreso indicado ya tiene un registro de ensayo asociado.', 16, 3);
        RETURN;
    END;

    IF @idtipoensayo IS NULL
    BEGIN
        RAISERROR('El tipo de ensayo es obligatorio.', 16, 4);
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM TIPOS_ENSAYO
        WHERE IdTipoEnsayo = @idtipoensayo
    )
    BEGIN
        RAISERROR('El tipo de ensayo indicado no existe.', 16, 5);
        RETURN;
    END;

    IF @idempleado IS NULL
    BEGIN
        RAISERROR('El empleado es obligatorio.', 16, 6);
        RETURN;
    END;

    IF NOT EXISTS (
        SELECT 1
        FROM EMPLEADOS
        WHERE IdEmpleado = @idempleado
    )
    BEGIN
        RAISERROR('El empleado indicado no existe.', 16, 7);
        RETURN;
    END;

    IF @resultado IS NULL OR @resultado NOT IN (
        'SATISFACTORIO',
        'NO SATISFACTORIO',
        'NO SE ENSAYA',
        'CALIBRACION'
    )
    BEGIN
        RAISERROR('El resultado ingresado no es valido.', 16, 8);
        RETURN;
    END;

    IF @fechaensayo IS NULL
    BEGIN
        RAISERROR('La fecha de ensayo es obligatoria.', 16, 9);
        RETURN;
    END;

    IF @fechaensayo > CAST(GETDATE() AS DATE)
    BEGIN
        RAISERROR('La fecha de ensayo no puede ser futura.', 16, 10);
        RETURN;
    END;

    IF @humedad IS NULL OR @humedad < 0 OR @humedad > 100
    BEGIN
        RAISERROR('La humedad debe estar entre 0 y 100.', 16, 11);
        RETURN;
    END;

    IF @temperatura IS NULL OR @temperatura < -10.0 OR @temperatura > 60.0
    BEGIN
        RAISERROR('La temperatura debe estar entre -10.0 y 60.0.', 16, 12);
        RETURN;
    END;

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
    VALUES (
        @idingreso,
        @idtipoensayo,
        @resultado,
        @fechaensayo,
        @humedad,
        @temperatura,
        @observaciones,
        @idempleado
    );
END;
GO

DROP PROCEDURE IF EXISTS sp_GetIngresosPendientesEnsayo;
GO

CREATE OR ALTER PROCEDURE sp_GetIngresosPendientesEnsayo
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        i.IdIngreso,
        i.Serie,
        i.Precinto,
        p.IdPedido,
        p.Pedido AS NumeroPedido,
        c.RazonSocial AS Cliente,
        h.IdHerramienta,
        h.Nombre AS Herramienta,
        h.Modelo,
        h.Clase,
        th.Nombre AS TipoHerramienta
    FROM INGRESOS i
    INNER JOIN PEDIDOS p
        ON i.IdPedido = p.IdPedido
    INNER JOIN CLIENTES c
        ON p.IdCliente = c.IdCliente
    INNER JOIN HERRAMIENTAS h
        ON p.IdHerramienta = h.IdHerramienta
    INNER JOIN TIPOS_HERRAMIENTAS th
        ON h.IdTipoHerramienta = th.IdTipoHerramienta
    LEFT JOIN REGISTROS r
        ON i.IdIngreso = r.IdIngreso
    WHERE r.IdRegistro IS NULL
    ORDER BY i.IdIngreso;
END;
GO