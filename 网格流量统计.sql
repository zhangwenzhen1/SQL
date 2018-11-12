USE [容量]


select 地市,sum(日流量GB) as 流量,count(*) from [容量].[dbo].[流量系数1] where 路测网格='C'  group by 地市 order by 地市