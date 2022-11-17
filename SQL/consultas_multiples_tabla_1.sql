#consultas multiples tabla 1


#Pedidos por empresa en UK:
#Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer cuántos pedidos ha realizado 
#cada empresa cliente de UK. 
#Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos. 

SELECT customers.company_name AS NombreEmpresa, orders.customer_id AS identificador, count(Distinct orders.order_id) AS NumeroPedidos, COUNTRY
FROM customers NATURAL JOIN orders
GROUP BY identificador
having country ="UK";

SELECT customers.company_name AS NombreEmpresa, orders.customer_id AS identificador, count(Distinct orders.order_id) AS NumeroPedidos
FROM customers NATURAL JOIN orders
WHERE country = "UK"
GROUP BY identificador;


#Productos pedidos por empresa en UK por año:onocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. 
#Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
#El resultado será una tabla similar a esta:

SELECT YEAR (orders.order_date) as año,COUNt(distinct order_details.product_id) As num_objetos
FROM order_details inner JOIN orders
ON orders.order_id = order_details.order_id
group by año;