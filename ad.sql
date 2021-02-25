每月每天平均
select a.u_time,a.ysll,b.yszd,c.fyzd,d.lqzd,e.cszd,f.csyul,g.csph,i.gtjyl from (select date_format(u_time,'%Y-%m-%d') u_time,round(avg(ysll),2) ysll  from ad_1610453311089 where u_time >= '2021-01-1' and  u_time < '2021-02-1' GROUP BY day(u_time)) a
left join 
(select date_format(u_time,'%Y-%m-%d') u_time,round(avg(yszd),2) yszd  from ad_1610453509730 where u_time >= '2021-01-1' and  u_time < '2021-02-1' GROUP BY day(u_time)) b on a.u_time = b.u_time
left join 
(select date_format(u_time,'%Y-%m-%d') u_time,round(avg(fyzd),2) fyzd  from ad_1610453533152 where u_time >= '2021-01-1' and  u_time < '2021-02-1' GROUP BY day(u_time)) c on a.u_time = c.u_time
left join 
(select date_format(u_time,'%Y-%m-%d') u_time,round(avg(lqzd),2) lqzd  from ad_1610453551996 where u_time >= '2021-01-1' and  u_time < '2021-02-1' GROUP BY day(u_time)) d on a.u_time = d.u_time
left join 
(select date_format(u_time,'%Y-%m-%d') u_time,round(avg(cszd),2) cszd  from ad_1610453575371 where u_time >= '2021-01-1' and  u_time < '2021-02-1' GROUP BY day(u_time)) e on a.u_time = e.u_time
left join 
(select date_format(u_time,'%Y-%m-%d') u_time,round(avg(csyul),2) csyul  from ad_1610453606574 where u_time >= '2021-01-1' and  u_time < '2021-02-1' GROUP BY day(u_time)) f on a.u_time = f.u_time
left join 
(select date_format(u_time,'%Y-%m-%d') u_time,round(avg(csph),2) csph  from ad_1610453594262 where u_time >= '2021-01-1' and  u_time < '2021-02-1' GROUP BY day(u_time)) g on a.u_time = g.u_time
left join 
(select date_format(u_time,'%Y-%m-%d') u_time,round(avg(gtjyl),2) gtjyl  from ad_1610453619105 where u_time >= '2021-01-1' and  u_time < '2021-02-1' GROUP BY day(u_time)) i on a.u_time = i.u_time
#########################
每天第一条
select a.s_time,a.ysll,b.yszd,c.fyzd,d.lqzd,e.cszd,f.csyul,g.csph,i.gtjyl from (
select hour(t.u_time) u_time,DATE_FORMAT(t.u_time,'%H:%m') s_time,t.ysll from (
select u_time,ysll,row_number() over (PARTITION by hour(u_time) order by u_time asc) rn 
from ad_1610453311089 where date(u_time) = '2021-01-31') t where t.rn = 1) a
left join 
(select hour(t.u_time) u_time,t.yszd from (
select u_time,yszd,row_number() over (PARTITION by hour(u_time) order by u_time asc) rn 
from ad_1610453509730 where date(u_time) = '2021-01-31') t where t.rn = 1) b on a.u_time = b.u_time
left join 
(select hour(t.u_time) u_time,t.fyzd from (
select u_time,fyzd,row_number() over (PARTITION by hour(u_time) order by u_time asc) rn 
from ad_1610453533152 where date(u_time) = '2021-01-31') t where t.rn = 1) c on a.u_time = c.u_time
left join 
(select hour(t.u_time) u_time,t.lqzd from (
select u_time,lqzd,row_number() over (PARTITION by hour(u_time) order by u_time asc) rn 
from ad_1610453551996 where date(u_time) = '2021-01-31') t where t.rn = 1) d on a.u_time = d.u_time
left join 
(select hour(t.u_time) u_time,t.cszd from (
select u_time,cszd,row_number() over (PARTITION by hour(u_time) order by u_time asc) rn 
from ad_1610453575371 where date(u_time) = '2021-01-31') t where t.rn = 1) e on a.u_time = e.u_time
left join 
(select hour(t.u_time) u_time,t.csyul from (
select u_time,csyul,row_number() over (PARTITION by hour(u_time) order by u_time asc) rn 
from ad_1610453606574 where date(u_time) = '2021-01-31') t where t.rn = 1) f on a.u_time = f.u_time
left join 
(select hour(t.u_time) u_time,t.csph from (
select u_time,csph,row_number() over (PARTITION by hour(u_time) order by u_time asc) rn 
from ad_1610453594262 where date(u_time) = '2021-01-31') t where t.rn = 1) g on a.u_time = g.u_time
left join 
(select hour(t.u_time) u_time,t.gtjyl from (
select u_time,gtjyl,row_number() over (PARTITION by hour(u_time) order by u_time asc) rn 
from ad_1610453619105 where date(u_time) = '2021-01-31') t where t.rn = 1) i on a.u_time = i.u_time


