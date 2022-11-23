#consultas multiples tabla 1


#Pedidos por empresa en UK:
#Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer cuántos pedidos ha realizado 
#cada empresa cliente de UK. 
#Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos. 

SELECT customers.company_name AS NombreEmpresa, orders.customer_id AS identificador, count(Distinct orders.order_id) AS NumeroPedidos, COUNTRY
FROM customers NATURAL JOIN orders
GROUP BY identificador
having country ="UK";

-- Otra forma de solucionarlo
SELECT customers.company_name AS NombreEmpresa, orders.customer_id AS identificador, count(Distinct orders.order_id) AS NumeroPedidos
FROM customers NATURAL JOIN orders
WHERE country = "UK"
GROUP BY identificador;


# 2. Productos pedidos por empresa en UK por año:onocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. 
# Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
# El resultado será una tabla similar a esta:

select customers.company_name as NombreEmpresa, year(orders.order_date) as año, sum(order_details.quantity) as NumObjetos
from customers inner join orders
on customers.customer_id = orders.customer_id
inner join order_details
on orders.order_id = order_details.order_id
where customers.country = 'UK'
group by year(orders.order_date), customers.company_name;


# 3. Mejorad la query anterior:
# Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad 
# de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. 
# Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.

select customers.company_name as NombreEmpresa, year(orders.order_date) as año, sum(order_details.quantity) as NumObjetos,
	sum(quantity * unit_price - quantity * unit_price * discount) as DineroTotal
from customers inner join orders
on customers.customer_id = orders.customer_id
inner join order_details
on orders.order_id = order_details.order_id
where customers.country = 'UK'
group by year(orders.order_date), customers.company_name;

# 4. 