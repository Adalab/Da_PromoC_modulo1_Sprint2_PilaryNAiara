##Consultas en múltiples tablas 5

##1.Extraed los pedidos con el máximo "order_date" para cada empleado.
#saber la fecha de los pedidos más recientes que ha gestionado cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.

SELECT p1.order_id, p1.customer_id, p1.employee_id, MAX(p1.order_date), p1.required_date
from orders as p1
where p1.customer_id = 
		(Select p2.customer_id
        From orders as p2
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

select customers.city, customers.company_name, customers.contact_name, count(order_details.order_id)
from customers inner join orders
on customers.customer_id = orders.customer_id
inner join order_details
on orders.order_id = order_details.order_id
where customers.city like "L%"
group by customers.city, customers.company_name, customers.contact_name
order by customers.company_name;


/* 5. Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". 
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia. */

select contact_name, contact_title, company_name
from customers
where contact_title not like "%Sales%";


/* 6. Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto. */

select contact_name
from customers
where contact_name not like "_a%";