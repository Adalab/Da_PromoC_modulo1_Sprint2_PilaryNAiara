##Consultas en múltiples tablas 3

#crear en algunos de los ejercicios una columna temporal.
#Para ver como funciona esta creación de columnas temporales prueba el siguiente código:

#proveedores que tenemos en la BBDD. Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación 
#(Proveedor o Cliente). Pero importante! No debe haber duplicados en nuestra respuesta. 
#La columna Relationship no existe y debe ser creada como columna temporal. Para ello añade el valor que le quieras dar al campo y utilizada como alias 
#Relationship.


USE  NORTHWIND;

SELECT city, company_name, contact_name,'cliente' as relationship
FROM CUSTOMERS 
UNION 
SELECT city, company_name, contact_name, 'proveedor'  as relationship
FROM suppliers
order by city;

#saber cuantos pedidos ha gestionado "Nancy Davolio", una de nuestras empleadas. Nos pide todos los detalles tramitados por ella.

SELECT order_id, customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country
FROM orders where employee_id IN (
	SELECT	employee_id
    From employees 
	WHERE last_name = "Davolio" and first_name = "Nancy");
        
#Extraed todas las empresas que no han comprado en el año 1997
#En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997.

select distinct ship_name as company_name, ship_country as country 
FROM orders
WHERE year(order_date) not in (
	SELECT YEAR (order_date)	
	FROM orders
    WHERE year (order_date) = '1997')
order by company_name; 
    
#Extraed toda la información de los pedidos donde tengamos "Konbu"
#Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo.
# Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".

select order_details.order_id, order_details.product_id, products.products_name 
 FROM order_details inner join	products 
 HAVING (poduct_id);

