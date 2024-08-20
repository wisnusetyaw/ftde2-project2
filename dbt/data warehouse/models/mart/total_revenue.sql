{{ config(
    materialized="table",
    schema="mart"
) }}

SELECT
    SUM(amount) AS total_revenue,
    payment_date
FROM {{ ref('fact_payment')}}
GROUP BY payment_date