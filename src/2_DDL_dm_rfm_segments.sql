drop table if exists analysis.dm_rfm_segments;
create table analysis.dm_rfm_segments
(   user_id        int4 primary key,
    recency        int2 check(recency between 1 and 5),
    frequency      int2 check(recency between 1 and 5),
    monetary_value int2 check(recency between 1 and 5)
    );

   