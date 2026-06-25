CREATE PROCEDURE sp_UpdateRegistro (
	@idingreso INT,
	@idtipoensayo INT,
	@resultado VARCHAR(100),
	@fechaensayo DATE,
	@humedad INT,
	@temperatura FLOAT,
	@observaciones VARCHAR(255),
	@idempleado INT
)
AS
BEGIN
	DECLARE @error BIT;
	DECLARE @herramienta VARCHAR(50);

	SET @error = 1;

	IF @resultado <> 'SATISFACTORIO' AND @resultado <> 'NO SATISFACTORIO' AND @resultado <> 'NO SE ENSAYA' AND @resultado <> 'CALIBRACION'
	BEGIN
		RAISERROR('Los valores de RESULTADO ingresados no son válidos', 16, 1);
		SET @error = 0;
	END
	IF @humedad < 0 AND @humedad > 100
    BEGIN
        RAISERROR('Los valores de HUMEDAD ingresados no son válidos.', 16, 2);
		SET @error = 0;
    END
	IF @temperatura < -10.0 AND @temperatura > 60.0
	BEGIN
		RAISERROR('Los valores de TEMPERATURA ingresados no son válidos.', 16, 3);
		SET @error = 0;
	END
	IF @idempleado IS NULL
	BEGIN
		RAISERROR('Los valores de EMPLEADO ingresados no son válidos.', 16, 4);
		SET @error = 0;
	END;
	IF @error = 1
	BEGIN
		UPDATE REGISTROS
		SET
			IdTipoEnsayo = @idtipoensayo,
			Resultado = @resultado,
			FechaEnsayo = GETDATE(),
			Humedad = @humedad,
			Temperatura = @temperatura,
			Observaciones = @observaciones,
			IdEmpleado = @idempleado
		WHERE 
			IdIngreso = @idingreso;
	END;
	ELSE
	BEGIN
		RETURN;
	END;
END;