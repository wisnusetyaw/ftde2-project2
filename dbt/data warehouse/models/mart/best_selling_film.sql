{{ config(
    materialized="table",
    schema="mart"
) }}

SELECT
    f.film_id,
    f.title,
    f.release_year,
    SUM(p.amount) AS total_sales
FROM {{ ref('dim_film') }} AS f
JOIN {{ ref('dim_inventory') }} AS i ON f.film_id = i.film_id
JOIN {{ ref('dim_rental') }} AS r ON i.inventory_id = r.inventory_id
JOIN {{ ref('fact_payment') }} AS p ON r.rental_id = p.rental_id
GROUP BY
    f.film_id,
    f.title,
    f.release_year
ORDER BY
    total_sales DESC
LIMIT 5