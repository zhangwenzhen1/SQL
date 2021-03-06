/****** Script for SelectTopNRows command from SSMS  ******/
USE [容量]
/*select count(*) from [容量].[dbo].[流量系数1] where  流量系数<=0.05*/
/*select count(*) from [容量].[dbo].[流量系数1] where  流量系数>0.05 and 流量系数<=0.2*/
/*select 地市,count(*) from [容量].[dbo].[流量系数1] where  流量系数>0.05 and 流量系数<=0.2*/
select 地市,sum(日流量GB)/count(*) as 单小区平均流量GB into 各地业务均衡比 from [流量系数1] group by 地市
select 地市,count(*) as 系数大于小鱼 into 各地业务均衡比 from [容量].[dbo].[流量系数1] where  流量系数>0.05 and 流量系数<=0.2 group by 地市