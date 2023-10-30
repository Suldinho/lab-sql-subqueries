Use sakila;

-- 1 Determins the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
SELECT
    f.title AS film_title,
    COUNT(i.inventory_id) AS num_copies
FROM
    film AS f
JOIN
    inventory AS i ON f.film_id = i.film_id
WHERE
    f.title = 'Hunchback Impossible'
GROUP BY
    f.title;

-- 2 List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT
    title AS film_title,
    length AS film_length
FROM
    film
WHERE
    length > (SELECT AVG(length) FROM film);


-- 3 Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT
    actor.actor_id,
    actor.first_name,
    actor.last_name
FROM
    actor
WHERE
    actor.actor_id IN (
        SELECT
            film_actor.actor_id
        FROM
            film
        JOIN
            film_actor ON film.film_id = film_actor.film_id
        WHERE
            film.title = 'Alone Trip'
    );


-- 4 Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
SELECT
    film.title AS film_title,
    category.name AS category_name
FROM
    film
JOIN
    film_category ON film.film_id = film_category.film_id
JOIN
    category ON film_category.category_id = category.category_id
WHERE
    category.name = 'Family';

-- 5 Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT
    name,
    email
FROM
    customers
WHERE
    country = (SELECT country_id FROM countries WHERE country = 'Canada');


SELECT
    c.name,
    c.email
FROM
    customers AS c
JOIN
    countries AS co ON c.country = co.country_id
WHERE
    co.country = 'Canada';


-- 6 Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) AS film_count
FROM
    actor
JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY
    actor.actor_id
ORDER BY
    film_count DESC
LIMIT 1;

