#1. Lista de todos os filmes
select * 
from film
#2. Lista do titulo de todos os filmes
select title
from film
#3. Lista de filmes com duração menor do que 60 minutos
select * 
from film
where length<60
#4. Lista dos clientes inativos
select * 
from customer
where active=0
#5. Lista dos clientes ativos e respectivos endereços
select c.first_name, a.address
from customer c, address a
where c.active=1 and c.address_id=a.address_id
#6. Lista dos nomes dos clientes residentes no Brasil.
select c.first_name
from customer c
where c.active=1 and c.address_id in(select a.address_id from address a inner join city ci on a.city_id=ci.city_id, country co
									where ci.country_id=co.country_id and country='Brazil')
#7. Relação de filmes e atores que atuaram no mesmo
select title, first_name, last_name
from film f inner join film_actor fa on (f.film_id=fa.film_id) inner join actor a on(a.actor_id=fa.actor_id)
#8. Relação de filmes e atores que atuaram no mesmo ordenada por filme
select title, first_name, last_name
from film f inner join film_actor fa on (f.film_id=fa.film_id) inner join actor a on(a.actor_id=fa.actor_id)
order by title
#9. Relação de filmes e atores que atuaram no mesmo ordenada por ator
select title, first_name, last_name
from film f inner join film_actor fa on (f.film_id=fa.film_id) inner join actor a on(a.actor_id=fa.actor_id)
order by first_name and last_name
#10. Relação de filmes com participação de um ator específico.
select title, first_name, last_name
from film f inner join film_actor fa on (f.film_id=fa.film_id) inner join actor a on(a.actor_id=fa.actor_id)
where a.actor_id=1;
#11. Quantidade total de filmes
select count(film_id)
from film	
#12. Duração média dos filmes
select avg(length)
from film
#13. Lista de filmes por categoria.
select title, name
from film f inner join film_category fg on (f.film_id=fg.film_id) inner join category c on (fg.category_id=c.category_id)
#14. Quantidade de filmes por categoria.
select name,count(film_id)
from film_category  f inner join category  c on (f.category_id=c.category_id)
group by name
#15. Duração média dos filmes por categoria
select avg(length), name
from film f inner join film_category fg on (f.film_id=fg.film_id) inner join category c on (fg.category_id=c.category_id)
group by name
#16. Quantidade de filmes por categoria das categorias com menos de 57 filmes
select count(f.film_id), name
from film f inner join film_category fg on (f.film_id=fg.film_id) inner join category c on (fg.category_id=c.category_id)
group by name
having count(f.film_id)<57
#17. Duração média dos filmes por categoria das categorias com menos de 57 filmes
select avg(length), name
from film f inner join film_category fg on (f.film_id=fg.film_id) inner join category c on (fg.category_id=c.category_id)
group by name
having count(f.film_id)<57
#18. Quantidade de filmes alugados por cliente
select first_name, last_name, count(inventory_id)
from rental r inner join customer c on (r.customer_id=c.customer_id)
group by (c.customer_id)
#19. Quantidade de filmes alugados por cliente em ordem decrescente de quantidade de filmes alugados
select first_name, last_name, count(inventory_id) qnt_filme
from rental r inner join customer c on (r.customer_id=c.customer_id)
group by (c.customer_id)
order by qnt_filme desc
#20. Relação de nomes dos clientes que possuem um filme alugado no momento
select distinct rental.customer_id,first_name, last_name
from rental left join customer on (customer.customer_id = rental.customer_id)
where return_date is null
#21. Relação de nomes dos clientes que não possuem um filme alugado no momento
select distinct rental.customer_id,first_name, last_name
from rental left join customer on (customer.customer_id = rental.customer_id)
where return_date is not null and rental.customer_id not in (select distinct rental.customer_id
from rental left join customer on (customer.customer_id = rental.customer_id)
where return_date is null)

