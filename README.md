# 🔬 Sistema de Gestión de Laboratorio de Ensayos Eléctricos

Este proyecto consiste en el desarrollo de una Base de Datos para la gestión interna de un laboratorio de ensayos eléctricos.

## 📚 Contexto Académico

Este sistema fue desarrollado en el marco de la materia **Base de Datos II** de la **Tecnicatura Universitaria en Programación - UTN FRGP**.

## 👥 Integrantes del equipo

* Erro, Dana - Legajo 32526
* Lamonaca, Lautaro - Legajo 32388

## 🧩 Descripción del Sistema

El sistema permite gestionar los pedidos realizados por clientes para la ejecución de ensayos eléctricos sobre herramientas utilizadas en trabajos con riesgo eléctrico.

La base de datos respalda la gestión interna del laboratorio, permitiendo registrar:

* Clientes
* Pedidos
* Herramientas
* Tipos de herramientas
* Marcas
* Ingresos al laboratorio
* Empleados responsables
* Tipos de ensayo
* Niveles o permisos de empleados
* Registros de ensayos realizados

El objetivo principal del sistema es mantener la trazabilidad de cada herramienta ensayada, registrando su ingreso al laboratorio, el ensayo realizado, el resultado obtenido y el empleado responsable.

## ⚙️ Componentes Técnicos

### 🔄 Triggers

* TR_Validar_Empleado_TipoEnsayo
* TR_Normalizar_Observaciones_Registros
* TR_Normalizar_Clase_Herramientas

### ⚙️ Procedimientos almacenados

* sp_InsertRegistro
* sp_UpdateRegistro
* sp_GetIngresosPendientesEnsayo

### 👁️‍🗨️ Vistas

* VW_Marcas
* VW_Herramientas
* VW_Clientes
* VW_Pedidos
* VW_Empleados
* VW_Ingresos
* VW_Registros

## 🗂️ Scripts incluidos

El repositorio contiene los scripts separados en la carpeta `Script`:

* `Script_creacion_database.sql`
* `Script_insert_datos_ejemplo.sql`
* `Script_vistas.sql`
* `Script_procedures.sql`
* `Script_triggers.sql`

## 📝 Recomendaciones para el funcionamiento de la Base de Datos SQL

Para probar correctamente la base de datos, se recomienda ejecutar los scripts en el siguiente orden:

1. `Script_creacion_database.sql`
2. `Script_insert_datos_ejemplo.sql`
3. `Script_vistas.sql`
4. `Script_procedures.sql`
5. `Script_triggers.sql`

La base de datos debe ser creada con el nombre:

`LaboratorioEnsayosElectricos`

Luego de ejecutar los scripts, se podrán consultar las vistas, ejecutar los procedimientos almacenados y probar los triggers definidos para validar y normalizar la información cargada en las tablas.

## Grupo 13
