USE LaboratorioEnsayosElectricos;
GO


DROP TRIGGER IF EXISTS TR_Validar_Empleado_TipoEnsayo;
GO

CREATE TRIGGER TR_Validar_Empleado_TipoEnsayo
ON REGISTROS
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        INNER JOIN EMPLEADOS e ON i.IdEmpleado = e.IdEmpleado
        INNER JOIN NIVELES n ON e.IdNivel = n.IdNivel
        WHERE n.IdTipoEnsayo IS NOT NULL
          AND n.IdTipoEnsayo <> i.IdTipoEnsayo
    )
    BEGIN
        THROW 50001, 'El empleado no esta habilitado para realizar este tipo de ensayo.', 1;
    END
END;
GO

DROP TRIGGER IF EXISTS TR_Normalizar_Observaciones_Registros;
GO

CREATE TRIGGER TR_Normalizar_Observaciones_Registros
ON REGISTROS
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE r
    SET Observaciones = 'SIN OBSERVACIONES'
    FROM REGISTROS r
    INNER JOIN inserted i ON r.IdRegistro = i.IdRegistro
    WHERE i.Observaciones IS NULL
       OR LTRIM(RTRIM(i.Observaciones)) = '';
END;
GO

DROP TRIGGER IF EXISTS TR_Normalizar_Clase_Herramientas;
GO

CREATE TRIGGER TR_Normalizar_Clase_Herramientas
ON HERRAMIENTAS
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE h
    SET Clase = 'NO APLICA'
    FROM HERRAMIENTAS h
    INNER JOIN inserted i ON h.IdHerramienta = i.IdHerramienta
    WHERE LTRIM(RTRIM(i.Clase)) = '';
END;
GO
