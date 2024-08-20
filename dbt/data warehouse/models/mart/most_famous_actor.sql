{{ config(
    materialized="table",
    schema="mart"
) }}

SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(fa.film_id) AS number_of_films
FROM {{ ref('dim_actor') }} AS a
JOIN {{ ref('dim_film_actor') }} AS fa ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id,
    a.first_name,
    a.last_name
ORDER BY
    number_of_films DESC
LIMIT 5