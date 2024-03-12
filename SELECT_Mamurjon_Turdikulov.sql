-- 1. Staff Members with Highest Revenue for Each Store (2017)
SELECT 
    s.store_id,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    SUM(p.amount) AS total_revenue
FROM 
    payment p
INNER JOIN 
    staff s ON p.staff_id = s.staff_id
WHERE 
    YEAR(p.payment_date) = 2017
GROUP BY 
    s.store_id, s.staff_id
ORDER BY 
    s.store_id, total_revenue DESC;

-- 2. Five Most Rented Movies and Expected Age of Audience
SELECT 
    f.film_id,
    f.title AS movie_title,
    COUNT(r.rental_id) AS rental_count,
    AVG(c.age) AS expected_age
FROM 
    film f
INNER JOIN 
    inventory i ON f.film_id = i.film_id
INNER JOIN 
    rental r ON i.inventory_id = r.inventory_id
INNER JOIN 
    customer c ON r.customer_id = c.customer_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    rental_count DESC
LIMIT 5;

-- 3. Actors/Actresses Who Didn't Act for a Longer Period
SELECT 
    actor_id,
    CONCAT(first_name, ' ', last_name) AS actor_name,
    DATEDIFF(NOW(), MAX(release_date)) AS days_since_last_act
FROM 
    actor a
INNER JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN 
    film f ON fa.film_id = f.film_id
GROUP BY 
    actor_id, actor_name
ORDER BY 
    days_since_last_act DESC;
