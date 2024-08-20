{{ config(
    materialized="table",
    schema="mart"
)
}}

SELECT
    substring(cast(payment_date as varchar), 1, 7) as payment_month,
    sum(amount) as total_revenue
FROM {{ref('fact_payment')}}
GROUP BY payment_month
ORDER BY payment_month



