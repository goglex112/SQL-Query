select date, consumption from
    (select date, sum(consumption) as consumption, dense_rank() over(order by sum(consumption) desc) as rank from
            (select * from public.fb_eu_energy
            UNION 
            select * from public.fb_asia_energy
            UNION 
            select * from public.fb_na_energy) as x
    group by date
    order by consumption desc) as total_energy_rank
where rank=1