-- Kathleen Freeberg


USE Sakila;


-- Question 1a
SELECT 
	first_name, 
    last_name
FROM actor;

-- Question 1b
SELECT concat(first_name, ' ',  last_name) AS 'Actor Name'
FROM actor;

-- Question 2a
SELECT 
	actor_id, 
    first_name, 
    last_name
FROM actor
WHERE first_name='Joe';

-- Question 2b
SELECT 
	actor_id, 
    first_name, 
    last_name
FROM actor
WHERE last_name Like '%gen%';

-- Question 2c
SELECT 
	actor_id, 
    first_name, 
    last_name
FROM actor
WHERE last_name Like '%le%'
ORDER BY last_name, first_name;

-- Question 2d
SELECT 
	country_id, 
	country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- Question 3a
ALTER TABLE actor
ADD COLUMN description BLOB;

-- Question 3a
ALTER TABLE actor
DROP COLUMN description;

-- Question 4a
SELECT 
	last_name, 
    count(*) AS 'Num Actors'
FROM actor
GROUP BY last_name;

-- Question 4b
SELECT 
	last_name, 
    count(*) AS 'Num Actors'
FROM actor
GROUP BY last_name
HAVING count(*) > 1;

-- Question 4c
UPDATE actor
SET first_name = 'HARPO'
WHERE 
	first_name='GROUCHO' AND 
	last_name='Williams';

-- Question 4d
UPDATE actor
SET first_name = 'GROUCHO'
WHERE 
	first_name='HARPO' AND 
    last_name='Williams';

-- Question 5a
SHOW CREATE TABLE address;

-- Question 6a
SELECT 
	first_name, 
    last_name, 
    address
FROM staff
JOIN address ON (staff.address_id=address.address_id);

-- Question 6b
SELECT  
	first_name, 
    last_name, 
    SUM(payment.amount) AS 'Total Sales'
FROM staff
JOIN payment ON (staff.staff_id=payment.staff_id)
WHERE  '2005-08-01' <= date(payment_date) and date(payment_date) <= '2008-8-31'
GROUP BY first_name, last_name;

-- Question 6c
SELECT 
	title, 
	count(*) AS 'Num Actors'
FROM film
INNER JOIN film_actor ON (film.film_id=film_actor.film_id)
GROUP BY title;

-- Question 6d
SELECT 
	title, 
	count(*) AS'Num Copies'
FROM film
JOIN inventory ON (film.film_id=inventory.film_id)
WHERE title='Hunchback Impossible';

-- Question 6e
SELECT 
	first_name, 
	last_name, 
    sum(payment.amount)
FROM customer
JOIN payment ON (customer.customer_id=payment.customer_id)
GROUP BY first_name, last_name
ORDER BY last_name, first_name;

-- Question 7a
SELECT 
	film_id, 
    title, 
    (SELECT name FROM language WHERE film.language_id=language.language_id)
FROM film
WHERE title LIKE 'q%' OR title LIKE 'k%' ;
    
-- Question 7b
SELECT 
	first_name, 
	last_name
FROM actor
WHERE actor_id IN
	(
	Select actor_id
	FROM film_actor
	WHERE film_id IN 
		(
		SELECT film_id
		FROM film
		WHERE title = 'Alone Trip'
));

-- Question 7c
SELECT
	first_name,
    last_name,
    email
FROM 
	customer,
	address,
    city,
    country
WHERE 
	customer.address_id=address.address_id AND
	address.city_id=city.city_id AND
	city.country_id=country.country_id AND
    country='Canada';

-- Question 7d    
SELECT
	title
FROM
	film,
    film_category,
    category
WHERE
	film.film_id=film_category.film_id AND
    film_category.category_id=category.category_id AND
    category.name = 'Family';

-- Question 7e    
 SELECT 
	title,
    count(rental_id) AS 'N_Rentals'
FROM
	film,
    inventory,
    rental
WHERE
	film.film_id=inventory.film_id AND
    inventory.inventory_id = rental.inventory_id
GROUP BY title
ORDER BY N_Rentals DESC;
    
 -- Question 7f     	 	
 SELECT 
	store.store_id, 
    SUM(payment.amount) 
FROM 
	store,  
	staff,
	payment   
WHERE
	store.store_id = staff.store_id AND
	staff.staff_id = payment.staff_id
GROUP BY store.store_id;    

 -- Question 7g   
  SELECT
	store.store_id,
    city.city,
    country.country
FROM
	store,
    address,
    city,
    country
WHERE
	store.address_id=address.address_id AND
    address.city_id=city.city_id AND
    city.country_id=country.country_id;

 -- Question 8a 
SELECT 
	category.name AS 'Genre', 
    SUM(payment.amount) AS 'Gross' 
FROM 
	category,
    film_category,
	inventory,
	rental,
	payment
WHERE
	category.category_id=film_category.category_id AND
	film_category.film_id=inventory.film_id AND
	inventory.inventory_id=rental.inventory_id AND
	rental.rental_id=payment.rental_id
GROUP BY Genre
ORDER BY Gross  LIMIT 5; 

 -- Question 8b  
CREATE VIEW top_five_genres AS  
SELECT 
	category.name AS 'Genre', 
    SUM(payment.amount) AS 'Gross' 
FROM 
	category,
    film_category,
	inventory,
	rental,
	payment
WHERE
	category.category_id=film_category.category_id AND
	film_category.film_id=inventory.film_id AND
	inventory.inventory_id=rental.inventory_id AND
	rental.rental_id=payment.rental_id
GROUP BY Genre
ORDER BY Gross  LIMIT 5; 

 -- Question 8c
SELECT * FROM top_five_genres;  

 -- Question 8d
DROP VIEW top_five_genres;
  