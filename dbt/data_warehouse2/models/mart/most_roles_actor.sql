{{ config(
    materialized="table",
    schema="mart"
)
}}


with roles as (
select da.actor_id,
    da.first_name,
    da.last_name ,
	count(*) as total_roles
from {{ref('dim_film_actor')}} dfa 
left join {{ref('dim_actor')}} da 
on dfa.actor_id = da.actor_id 
group by 1, 2, 3
order by total_roles desc
)

select * 
from roles
where total_roles = (select max(total_roles) from roles)