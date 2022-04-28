insert into analysis.dm_rfm_segments 
with cte1 as 
	(select *, 
    	now(),
    	now() - order_ts as delta  
	from analysis.orders o
	where status =  (select id from analysis.orderstatuses o where key = 'Closed')
    and extract(year from order_ts) > 202),
cte2 as 
	(select t1.id, 
		coalesce(min(t2.delta), interval '1000 year') as dt_delta,		
		sum(case when (t2.order_id is null) then 0 else 1 end) as orders_cnt,
		coalesce(sum(t2.payment), 0) as payment_sum
	from analysis.users t1 left join cte1 t2 on t1.id = t2.user_id 
	group by t1.id)
select id,
 ntile(5) over (order by dt_delta) as recency, 
 ntile(5) over (order by orders_cnt) as frequency, 
 ntile(5) over (order by payment_sum desc) as monetary_value 
from cte2
order by id;