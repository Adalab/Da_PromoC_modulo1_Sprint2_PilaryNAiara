use northwind;

/* 1. Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente 
y el nombre de la compañia de la tabla Customers. */

WITH cteEjer1 AS(
	SELECT customer_id, company_name
    FROM customers)
SELECT cteEjer1.customer_id, cteEjer1.company_name
FROM cteEjer1;


/* 2. Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, 
pero solo queremos los que pertezcan a "Germany". */

WITH cteEjer2 AS(
	SELECT customer_id, company_name
    FROM customers
    WHERE country = 'Germany')
SELECT cteEjer2.customer_id, cteEjer2.company_name
FROM cteEjer2;


/* 3. Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, 
su fecha la compañia a la que pertenece. */

WITH cteEjer3 AS(
	SELECT c.customer_id, c.company_name, o.order_id, o.order_date
    FROM customers AS c
    inner join orders AS o
    ON c.customer_id = o.customer_id)
SELECT cteEjer3.customer_id, cteEjer3.company_name, cteEjer3.order_id, cteEjer3.order_date
FROM cteEjer3
ORDER BY cteEjer3.customer_id;


/* 4. Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente. */

WITH cteEjer4 AS(
	SELECT c.customer_id, c.company_name, o.order_id
    FROM customers AS c
    inner join orders AS o
    ON c.customer_id = o.customer_id)
SELECT cteEjer4.customer_id, cteEjer4.company_name, count(cteEjer4.order_id)
FROM cteEjer4
group by cteEjer4.customer_id, cteEjer4.company_name
ORDER BY cteEjer4.customer_id;


/* 5. Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media. */


select products.product_name,  avg(order_details.quantity) as media 
from order_details inner join products
on order_details.product_id = products.product_id
group by order_details.product_id
order by  products.product_name;


