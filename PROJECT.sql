-- SQL PROJECT USING DVD RENTAL FILE

--1. How many rentals were made in total? 

select R.rental_id,sum(R.customer_id) AS "TOTAL RENTAL" from rental R 
join inventory i  ON R.inventory_id = i.inventory_id
Group by R.rental_id 


--2. What is the average rental duration?

select R.rental_id,f.title,ROUND(AVG(f.rental_duration),2) AS "AVERAGE RENTAL DURATION" 
from film f
join inventory i  ON f.film_id = i.film_id
join rental R ON i.inventory_id = R.inventory_id
Group by R.rental_id,f.title

--3. Which films have a rental rate greater than $4.00? 

select f.film_id,f.title, f.rental_rate from film f 
join inventory i ON f.film_id = i.film_id 
join rental R ON i.inventory_id = R.inventory_id
WHERE f.rental_rate  > 4.00
group by f.film_id,f.title, f.rental_rate

---4. What is the total amount earned from rentals? 

select R.rental_id, sum(amount) AS "TOTAL EARNED" from rental R  
join payment p ON p.rental_id = R.rental_id GROUP BY R.rental_id

---5. How many customers have rented films in each city? 

select c.customer_id,ci.city,count(f.title) from city ci 
join address a ON ci.city_id = a.city_id 
join customer c ON a.address_id = c.address_id
join rental R ON c.customer_id = R.customer_id
join inventory i ON R.inventory_id = i.inventory_id 
join film f ON i.film_id = f.film_id
GROUP BY c.customer_id,ci.city

--6. List the top 5 longest-running rental transactions (based on rental duration)

select R.rental_id,f.rental_duration from rental R
join inventory i 
ON R.inventory_id = i.inventory_id 
join film f on i.film_id = f.film_id 
group by R.rental_id,f.rental_duration
limit 5

-- 7. What is the average rental duration for each customer? 

select CONCAT(C.first_name,' ',C.last_name)AS "customer name",
ROUND(AVG(f.rental_duration),2)
AS "Average Rental duration"
from customer C 
join rental R ON c.customer_id = R.customer_id 
join inventory i ON R.inventory_id = i.inventory_id
join film f ON i.film_id = f.film_id 
group by C.first_name,C.last_name


---8. List the top 5 films category with the highest average replacement costs. 

select fc.category_id,ROUND(avg(f.replacement_cost),2) AS "Highest Average Replacement cost" 
from film f join film_category fc 
ON f.film_id = fc.film_id group by fc.category_id
ORDER BY avg(f.replacement_cost) DESC

---9. Which films have never been rented? 

select f.title,count(R.customer_id) from film f FULL OUTER JOIN inventory i
ON f.film_id = i.film_id 
 FULL OUTER JOIN rental R ON i.inventory_id = R.inventory_id
GROUP by  f.title
HAVING count(R.customer_id) = 0

 --10. HOW many R is in the film table
select * from film where rating = 'R'

--11. get the film with length between 80 and 120

select * from film where length between 80 and 120

-- 12. we found a recipt for a movie in store this morning. we want to get a name in detail of a customer who rented the movie
--but we got the first name it start with E and last name is N. can you find us the list of customer that own the recipt.

select * from customer 
where first_name ILIKE 'E%' AND last_name ILIKE '%N'

-- 13. get only 5 record on addres table

select * from rental
select * from Address limit 5

--14. how many movie that cost 15.99,18.99,21.99

select * from film where  Replacement_cost = 15.99 OR 
Replacement_cost =  18.99 OR 
Replacement_cost= 21.99

--15. get the first_name that end with E
SELECT * from actor
where first_name ILIKE '%E'

--16. get the first_name that start  with E
SELECT * from actor
where first_name ILIKE 'E%'

--17. Extract from payment_date

Select customer_id,payment_id,amount,
EXTRACT(DAY FROM payment_date)
AS DAY FROM Payment

--18. extract Month name from payment date

Select customer_id,payment_id, 
TO_CHAR(payment_date, 'month') AS month_name FROM PAYMENT
where extract(month from payment_date) = 4

--19. HOW MANY DOCUMENTARY RATING PG

select c.name, count(f.title)
from film f
join film_category fc ON f.film_id = fc.film_id
join category c ON fc.category_id = c.category_id
where c.name = 'Documentary' AND f.rating = 'PG'
group by c.name

---20. WHAT IS THE TOTTAL PAYMENT GENERATED BY EACH STAFF

select p.staff_id, s.first_name,s.last_name, sum(amount) from payment p 
join staff s ON p.staff_id = s.staff_id
group by p.staff_id, s.first_name,s.last_name

