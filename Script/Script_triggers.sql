USE LaboratorioEnsayosElectricos;
GO

CREATE TRIGGER TR_Crear_Registro_PostIngreso ON INGRESOS
AFTER INSERT
AS
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
        IdIngreso,
        '',
        'ESPERANDO ENSAYO',
        GETDATE(),
        0,
        0,
        NULL,
        0
    FROM inserted;
END;
GO