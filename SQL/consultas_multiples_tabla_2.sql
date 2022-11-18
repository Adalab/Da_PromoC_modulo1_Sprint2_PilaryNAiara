# Pair programming Consultas multiples tablas 2

USE northwind;

#1. Qué empresas tenemos en la BBDD Northwind:
#Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, 
# los ID de sus pedidos y las fechas.

SELECT customers.company_name AS NombreEmpresa, orders.order_id As NumeroPedido, orders.order_date AS FechaPedido
FROM customers LEFT JOIN orders
ON customers.customer_id = orders.customer_id;


# 2. Pedidos por cliente de UK:
# Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha 
# realizado cada cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. 
# Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos.

SELECT customers.company_name AS NombreEmpresa, COUNT(orders.order_id) As NumeroPedidos
FROM customers LEFT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK"
GROUP BY customers.company_name;


# 3. Empresas de UK y sus pedidos:
# También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido 
# (tengan pedidos o no) junto con los ID de todos los pedidos que han realizado, 
# el nombre de contacto de cada empresa y la fecha del pedido.

SELECT customers.company_name AS NombreEmpresa, orders.order_id AS NumeroPedido, 
	customers.contact_name AS NombreCliente, orders.order_date AS FechaPedido
FROM customers LEFT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK";


# 4. Empleadas que sean de la misma ciudad:
# Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla 
# los datos de todas las empleadas y sus supervisoras. Concretamente nos piden: 
# la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. 
# Investiga el resultado, ¿sabes decir quién es el director?

SELECT empleadas.city AS CiudadEmpleada, COUNT(CONCAT(empleadas.first_name, " ", empleadas.last_name)) AS NombreyApellidoEmpleada,
jefas.city AS CiudadJefa, jefas.first_name AS NombreJefa, jefas.last_name AS ApellidoJefa
FROM employees AS empleadas, employees AS jefas
WHERE empleadas.employee_id = jefas.reports_to;
-- GROUP BY CONCAT(empleadas.first_name, " ", empleadas.last_name);


# Error Code: 1055. Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'northwind.empleadas.city' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
