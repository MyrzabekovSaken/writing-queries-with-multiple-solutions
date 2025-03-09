
--Which staff members made the highest revenue for each store and deserve a bonus for the year 2017?
SELECT DISTINCT ON (s.store_id)
    s.store_id,
    s.staff_id,
    s.first_name,
    s.last_name,
    SUM(p.amount) AS total_revenue
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
WHERE EXTRACT(YEAR FROM p.payment_date) = 2017
GROUP BY s.staff_id, s.store_id, s.first_name, s.last_name
ORDER BY s.store_id, total_revenue DESC;


--Which five movies were rented more than the others, and what is the expected age of the audience for these movies?
SELECT
    f.film_id,
    f.title,
    f.rating,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, f.rating
ORDER BY rental_count DESC
LIMIT 5;


--Which actors/actresses didn't act for a longer period of time than the others?
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COALESCE(MAX(f.last_update), '1900-01-01') AS last_film_date
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY last_film_date ASC
LIMIT 5;
