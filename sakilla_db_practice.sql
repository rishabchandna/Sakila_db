use sakila;

-- which actors have the first name scarlett?

SELECT first_name,
       last_name
FROM   actor
WHERE  first_name = 'Scarlett'; 

-- Q-2 Which actors have the last name ‘Johansson’?

SELECT first_name,
       last_name
FROM   actor
WHERE  last_name = 'Johansson'; 


-- Q-3 How many distinct actors last names are there?
SELECT Count(DISTINCT last_name)
FROM   actor
WHERE  last_name IS NOT NULL; 

-- Q-4 Which last names are not repeated?
SELECT last_name,
       Count(last_name) AS last_nam
FROM   actor
GROUP  BY last_name
HAVING last_nam = 1; 


-- Q-5 Which last names appear more than once?
SELECT last_name,
       Count(last_name) AS last_nam
FROM   actor
GROUP  BY last_name
HAVING last_nam > 1; 


-- Q-6 Which actor has appeared in the most films?
SELECT first_name,
       last_name,
       Count(film_id) AS max_films
FROM   actor AS a
       INNER JOIN film_actor AS f
               ON a.actor_id = f.actor_id
GROUP  BY first_name,
          last_name
ORDER  BY max_films DESC
LIMIT  1; 

-- Q-7 Is ‘Academy Dinosaur’ available for rent from Store 1?
SELECT     (f.title) ,
           i.store_id
FROM       film      AS f
INNER JOIN inventory AS i
where      f.title = 'Academy Dinosaur'
AND        i.store_id = 1;
-- Yes it availabl


-- Q-8 What is that average running time of all the films in the sakila DB?
SELECT Avg(length) AS Avg_running_time
FROM   film; 

-- Q-9 What is the average running time of films by category?

SELECT c.NAME,
       Avg(f.length) AS avg_time
FROM   category AS c
       INNER JOIN film_category AS fc
               ON c.category_id = fc.category_id
       INNER JOIN film AS f
               ON fc.film_id = f.film_id
GROUP  BY c.NAME
ORDER  BY avg_time DESC;

-- Q-10. What are the names of all the languages in the database (sorted alphabetically)?
SELECT name
FROM   language
ORDER  BY NAME ASC; 

-- Q-12 Return the full names (first and last) of actors with “SON” in their last name, ordered by their first name.
SELECT CONCAT(first_name, " " ,last_name) AS full_name
FROM actor
WHERE last_name LIKE '%SON%'
ORDER BY first_name ASC;

-- Q-13 Find all the addresses where the second address is not empty (i.e., contains some text), and return these second addresses sorted.   
SELECT * 
from address
where address2 = ''
order by address2;

/* Q-14 Return the first and last names of actors who played in a film involving a “Crocodile” and a “Shark”,
along with the release year of the movie, sorted by the actors’ last names.
*/
SELECT (a.first_name), a.last_name, f.release_year, f.title
FROM actor AS a
INNER JOIN film_actor as fa
ON a.actor_id = fa.actor_id
INNER JOIN film as f
ON fa.film_id = f.film_id
where f.description like '%Crocodile%' or f.description like '%Shark%'
ORDER BY a.last_name;

/* Q-15 Find all the film categories in which there are between 55 and 65 films. Return the names of these
categories and the number of films per category, sorted by the number of films. */
SELECT c.NAME,
       Count(f.title) AS total_films
FROM   category AS c
       INNER JOIN film_category AS fc
               ON c.category_id = fc.category_id
       INNER JOIN film AS f
               ON fc.film_id = f.film_id
GROUP  BY c.NAME
HAVING total_films BETWEEN 55 AND 65
ORDER  BY total_films; 

/* Q-16  In how many film categories is the average difference between the film replacement cost and the
rental rate larger than 17? */


SELECT NAME                                         AS category_name,
       Avg(rental_rate)                             AS Avg_rental_price,
       Avg(replacement_cost)                        AS Avg_replacement_price,
       ( Avg(replacement_cost) - Avg(rental_rate) ) AS replace_sub_rental
  FROM film_category
       INNER JOIN film using (film_id)
       INNER JOIN category using (category_id)
 GROUP BY category_id
HAVING replace_sub_rental > 17; 


/* Q-17 List the top five genres in gross revenue in descending order. */
CREATE VIEW genre_revenue AS
SELECT c.NAME        AS NAME,
       Sum(p.amount) AS gross_revenue
FROM   category AS c
       INNER JOIN film_category AS fc
               ON c.category_id = fc.category_id
       INNER JOIN inventory AS i
               ON fc.film_id = i.film_id
       INNER JOIN rental AS r
               ON i.inventory_id = r.inventory_id
       INNER JOIN payment AS p
               ON r.rental_id = p.rental_id
GROUP  BY NAME
ORDER  BY gross_revenue; 

/*  Q-18 How many copies of the film `Hunchback Impossible` exist in the inventory system? */
SELECT f.title,
       Count(f.title) AS copies
FROM   film AS f
       INNER JOIN inventory AS i
               ON f.film_id = i.film_id
WHERE  f.title = 'Hunchback Impossible'; 




--     