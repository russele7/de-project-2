drop view if exists analysis.orders; 
create view analysis.orders as 
with cte as (select order_id, max(dttm) as max_dttm
			 from production.orderstatuslog  
			 group by order_id),
cte2 as (select distinct t1.* from production.orderstatuslog t1 
		inner join cte t2 on t1.order_id = t2.order_id and t1.dttm = t2.max_dttm)
select t1.order_id,
		t1.order_ts,
		t1.user_id,		
		t1.bonus_payment,
		t1.payment,
		t1.cost,
		t1.bonus_grant,
		t2.status_id as status
from production.orders t1 left join cte2 t2 on t1.order_id = t2.order_id;
