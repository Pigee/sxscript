
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
