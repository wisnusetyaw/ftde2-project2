{{ config(
    materialized="table",
    schema="mart"
)
}}

WITH rent_film AS (
SELECT df.film_id,
    df.title,
	COUNT(*) AS jumlah_rental
FROM {{ref('fact_payment')}} AS fp
LEFT JOIN {{ref('dim_rental')}} AS dr
ON fp.rental_id = dr.rental_id 
LEFT JOIN {{ref('dim_inventory')}} AS di
ON dr.inventory_id = di.inventory_id 
LEFT JOIN {{ref('dim_film')}} AS df
ON di.film_id = df.film_id 
GROUP BY df.film_id, df.title
ORDER BY jumlah_rental DESC
)

SELECT *
FROM rent_film
WHERE jumlah_rental = (SELECT MAX(jumlah_rental) FROM rent_film)


