use sakila;
-- 1a) first and last name:
select*from actor limit 10;
select first_name, last_name from actor;

-- 1b) one column Actor Name
-- update actor  (actor_name

select first_name,last_name,  
concat(first_name , 
concat(" ", last_name)) 
as actor_name from actor;

-- 2a) finding Joe:
select actor_id,first_name, last_name from actor 
where first_name = 'Joe';

-- 2b) last name 'Gen..'

select last_name from actor
where last_name like '%gen%';

-- 2c) last name Li order by first and last

select last_name, first_name from actor
where last_name like '%li%'
order by last_name, first_name;

-- 2d) `country_id` and `country`:Afghanistan, Bangladesh, and China
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a). Add a `middle_name` column to the table `actor`
select*from actor limit 10;
alter table actor add column middle_name varchar (30);
select last_name, middle_name, first_name from actor;
-- position???

-- 3b.   Change the data type of the `middle_name` column to `blobs`.
alter table actor modify column middle_name blob;

-- 3c. Now delete the `middle_name` column.
alter table actor drop column middle_name;
select*from actor;

-- 4a. List the last names of actors, as well as how many actors have that last name

select last_name, count(last_name) from actor group by last_name;

-- 4b) at least 2 actors ????
-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

select last_name, count(last_name) from actor group by last_name
having count(last_name) >= 2;

-- 4c. Oh, no! The actor `HARPO WILLIAMS

UPDATE actor
SET first_name = 'Groucho'
WHERE first_name = 'Harpo';

select*from actor where first_name='Mucho Groucho';



--  4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`.

update actor set first_name = 'Mucho Groucho' where actor_id IN (172);

-- * 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?

show create table address;

-- 6a)Use the tables `staff` and `address

select*from address limit 10;
select*from staff limit 10;



select first_name, last_name, address
from staff
join address
on address.address_id = staff.address_id;

-- 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005.
select*from payment;

select staff.first_name, staff.last_name, 
sum(payment.amount) as total_payment
from staff
join payment on payment.staff_id = staff.staff_id
where payment.payment_date > '2005-08-01' and payment.payment_date < '2005-08-31'
group by staff.staff_id
;


-- 6c)List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
select*from film_actor limit 10;
select*from film limit 10;

select  title, count(actor_id)
from film
inner join film_actor
on film.film_id = film_actor.film_id
group by film.title;

-- 6d. How many copies of the film `Hunchback Impossible
select*from inventory;
select*from film;

select f.title, count(inv.inventory_id) as NUMBER_OF_COPIES
from film f
join inventory inv
on inv.film_id = f.film_id
where f.title = ('Hunchback Impossible');
-- select count('Hunchback Impossible');

 SELECT title, 
 (
 SELECT COUNT(*) FROM inventory 
 WHERE film.film_id = inventory.film_id ) 
 AS 'Number of Copies'
 FROM film;

-- 6e)

select*from payment;
select*from customer;

select Last_name, payment.amount
from payment
join customer
on payment.customer_id = customer.customer_id
group by last_name;


select*from language limit 10;
-- 7a) ???Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English. 
select language_id
from language
where name IN
(
select film_id 
from film 
where title Like 'K%'
);
 
 
 -- 7b) Use subqueries to display all actors who appear in the film `Alone Trip`
 select first_name, last_name
 from actor
 where actor_id IN
 (
 Select actor_id
 from film_actor
 where film_id IN
 (
 Select film_id
 from film
 where title = 'Alone Trip'
 )
 );
 
 --  7c) names and email addresses of all Canadian customers, use joins
 
 select* from customer;
 select last_name, first_name, email
 from customer
 left join address
 on district
 group by district = 'canada';
 
 -- 7d) target all family movies for a promotion. Identify all movies categorized as famiy films
 select*from film;
 
 select film_id, title
 from film 
 where film_id IN
 (
 select film_id
 from film_category
 where category_id = 8
 );
 
 -- 7e) Display the most frequently rented movies in descending order
 
 
 
 