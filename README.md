Based on the SQL script, the database for the company ElectroConecta includes several tables for managing electronic sales. Below is a draft for the README file in English:

---

# ElectroConecta Database

This project contains the SQL Server database schema for ElectroConecta, a company that sells electronic products. The database is designed to handle various aspects of the business, including customers, employees, inventory, and sales transactions.

## Database Structure

The database consists of the following main tables:

1. **DISTRITOS**: Stores district information.
    - `ID_distrito` (CHAR(3)): Primary Key
    - `nombre_distrito` (VARCHAR(40)): Name of the district

2. **TRABAJADOR**: Stores employee information.
    - `DNI_trabajador` (CHAR(8)): Primary Key
    - `nombres_tra` (VARCHAR(25)): First names of the employee
    - `apellidos_tra` (VARCHAR(25)): Last names of the employee
    - `direccion_tra` (VARCHAR(60)): Address of the employee
    - `edad` (INT): Age of the employee
    - `telefono_tra` (VARCHAR(12)): Phone number of the employee
    - `email_tra` (VARCHAR(35)): Email of the employee
    - `sueldo` (MONEY): Salary of the employee
    - `fecha_inicio_contrato` (DATE): Contract start date
    - `fecha_final_contrato` (DATE): Contract end date
    - `ID_distrito` (CHAR(3)): Foreign Key referencing `DISTRITOS`

3. **CLIENTE**: Stores customer information.
    - `DNI_cliente` (CHAR(8)): Primary Key
    - `nombres_cli` (VARCHAR(25)): First names of the customer
    - `apellidos_cli` (VARCHAR(25)): Last names of the customer
    - `direccion_cli` (VARCHAR(60)): Address of the customer
    - `telefono_cli` (CHAR(9)): Phone number of the customer
    - `email_cli` (VARCHAR(35)): Email of the customer
    - `ID_distrito` (CHAR(3)): Foreign Key referencing `DISTRITOS`

4. **ALMACEN**: Stores warehouse information.
    - `cod_almacen` (CHAR(7)): Primary Key
    - `ID_distrito` (CHAR(3)): Foreign Key referencing `DISTRITOS`
    - `direccion` (VARCHAR(60)): Address of the warehouse
    - `area_m2` (DECIMAL(8,2)): Area of the warehouse in square meters
    - `cant_pisos` (INT): Number of floors in the warehouse

5. **ALMACENERO**: Stores warehouse manager information.
    - `cod_almacenero` (CHAR(7)): Primary Key
    - `cod_almacen` (CHAR(7)): Foreign Key referencing `ALMACEN`
    - `DNI_trabajador` (CHAR(8)): Foreign Key referencing `TRABAJADOR`

6. **TRANSPORTE**: Stores transport vehicle information.
    - `placa` (VARCHAR(7)): Primary Key
    - `capacidad_carga` (CHAR(5)): Load capacity of the vehicle
    - `modelo` (VARCHAR(12)): Model of the vehicle
    - `dimencion_alt_m` (DECIMAL(2,2)): Height of the vehicle in meters
    - `dimencion_ancho_m` (DECIMAL(2,2)): Width of the vehicle in meters
    - `dimencion_largo_m` (DECIMAL(2,2)): Length of the vehicle in meters
    - `peso_vehiculo_kg` (DECIMAL(8,2)): Weight of the vehicle in kilograms

7. **TRANSPORTISTA**: Stores transport driver information.
    - `cod_transportista` (CHAR(7)): Primary Key
    - `placa` (VARCHAR(7)): Foreign Key referencing `TRANSPORTE`
    - `DNI_trabajador` (CHAR(8)): Foreign Key referencing `TRABAJADOR`

8. **VENDEDOR**: Stores salesperson information.
    - `cod_vendedor` (CHAR(7)): Primary Key
    - `DNI_trabajador` (CHAR(8)): Foreign Key referencing `TRABAJADOR`

9. **VENTA**: Stores sales transaction information.
    - `num_venta` (CHAR(8)): Primary Key
    - `fecha_emision` (DATE): Date of issuance
    - `DNI_cliente` (CHAR(8)): Foreign Key referencing `CLIENTE`
    - `cod_vendedor` (CHAR(7)): Foreign Key referencing `VENDEDOR`
    - `IGV` (DECIMAL(4,2)): Tax
    - `sub_total` (DECIMAL(8,2)): Subtotal amount
    - `Total` (DECIMAL(8,2)): Total amount

10. **PRODUCTO**: Stores product information.
    - `ID_producto` (CHAR(6)): Primary Key
    - `nombre_producto` (VARCHAR(35)): Name of the product
    - `precio` (MONEY): Price of the product
    - `ID_categoria` (CHAR(3)): Foreign Key referencing `CATEGORIA`
    - `stock` (INT): Stock quantity
    - `marca` (VARCHAR(25)): Brand of the product

11. **DETALLE_VENTA**: Stores sales detail information.
    - `num_venta` (CHAR(8)): Foreign Key referencing `VENTA`
    - `ID_producto` (CHAR(6)): Foreign Key referencing `PRODUCTO`
    - `cantidad` (INT): Quantity of the product sold
    - `precio_venta` (MONEY): Sale price of the product

## Usage

To set up the database, run the SQL script provided in the repository. Ensure you have SQL Server installed and configured.

1. Create the database:
    ```sql
    CREATE DATABASE PROYECTO_BASE_DATOS_EDIT1;
    ```

2. Use the database:
    ```sql
    USE PROYECTO_BASE_DATOS_EDIT1;
    ```

3. Create tables:
    ```sql
    -- Example of creating the DISTRITOS table
    CREATE TABLE DISTRITOS (
        ID_distrito CHAR(3) NOT NULL PRIMARY KEY,
        nombre_distrito VARCHAR(40) NOT NULL
    );
    ```

4. Insert data as required for your application.

## Contributing

Contributions are welcome! Please fork the repository and submit pull requests for any enhancements or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to modify the README according to your specific needs and additional details you might want to include.
