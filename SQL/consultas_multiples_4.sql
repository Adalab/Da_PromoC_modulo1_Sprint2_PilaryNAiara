##Consultas en múltiples tablas 5

##1.Extraed los pedidos con el máximo "order_date" para cada empleado.
#saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.

SELECT p1.order_id ,p1.customer_id, p1.employee_id, p1.order_date, p1.required_date
from products as p1
where p1.customer_id = 
		(Select MAX(p2.order_date)
        From products as p2
        where p1.order_id = p2.order_id);
        
##2.Extraed el precio unitario máximo (unit_price) de cada producto vendido.
#Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario.

SELECT p1.product_id, p1.unit_price as max_unit_price_sold
FROM products as p1
where p1.product_id = (
	select p2.product_id
	FROM order_details as p2
	where p1.product_id = p2.product_id
    GROUP BY p2.product_id);
    
#3.Ciudades que empiezan con "A" o "B".
#Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B".
# Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.

SELECT city, company_name,contact_name
FROM customers
WHERE city LIKE "A%" or city like "B%";

#Número de pedidos que han hecho en las ciudades que empiezan con L.
#En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos que han hecho todas las ciudades 
#que empiezan por "L".

select company_name, contact_name, city
From customers
Where city LIKE "L%"
group by count(orde_id) as Numero_pedidos;