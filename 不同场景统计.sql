/****** Script for SelectTopNRows command from SSMS  ******/
USE [广东]
 GO
select 地市
      ,[景区名称]
	  ,count(*) as 小区数
	  ,sum(MR覆盖率)/count(*) as MR覆盖率
	  ,sum(日均流量GB)/count(*)  as 日均流量GB
	  ,sum(自忙时峰值利用率)/count (*) as 自忙时峰值利用率
	  ,sum(无线接通率)/count(*)  as 无线接通率
	  ,sum(无线掉线率)/count (*) as 无线掉线率
	  ,sum([上行PRB平均利用率(v2 8)])/count(*) as [上行PRB平均利用率]
	  ,sum([下行PRB平均利用率(v2 8)])/count(*) as [下行PRB平均利用率]
	  ,sum(PDCCH信道CCE占用率)/count(*) as PDCCH信道CCE占用率
	  ,sum(VOLTE接通率)/count(*) as VOLTE接通率
	  ,sum(VOLTE掉话率)/count(*)  as  VOLTE掉话率
	  ,ltrim(sum(esrvcc切换占比)/count(*))+'%'  as  esrvcc切换占比
  into 美食  from 广东.[dbo].重要场景月报统计总表  where 场景='美食' group by 地市,[景区名称] 

USE [广东]
 GO
  select 广东.[dbo].美食.地市
        ,广东.[dbo].美食.景区名称
		,广东.[dbo].美食.小区数
		,广东.[dbo].美食.MR覆盖率
		,temp.[MR覆盖率<95%小区数]
		,ltrim(cast((temp.[MR覆盖率<95%小区数]*1./广东.[dbo].美食.小区数)* 100 as numeric(10,2) ))+'%'  as 'MR覆盖率<95%小区占比'
		,广东.[dbo].美食.日均流量GB
		,广东.[dbo].美食.自忙时峰值利用率
		,广东.[dbo].美食.上行PRB平均利用率
		,广东.[dbo].美食.下行PRB平均利用率
		,广东.[dbo].美食.PDCCH信道CCE占用率
		,广东.[dbo].美食.无线接通率
		,广东.[dbo].美食.无线掉线率
		,广东.[dbo].美食.VOLTE接通率
		,广东.[dbo].美食.VOLTE掉话率
		,广东.[dbo].美食.esrvcc切换占比
		,temp1.高负荷待扩容小区数
		,ltrim(cast((temp1.高负荷待扩容小区数*1./广东.[dbo].美食.小区数)* 100 as numeric(10,2) ))+'%'  as 高负荷待扩容小区占比
  from 
  (select  地市
           ,[景区名称]
	       ,count(*)as 'MR覆盖率<95%小区数'
   from 广东.[dbo].重要场景月报统计总表  where 场景='美食'and  MR覆盖率<0.95  group by 地市,[景区名称])as temp
   right join 广东.[dbo].美食 on 广东.[dbo].美食.地市=temp.地市 and 广东.[dbo].美食.景区名称=temp.景区名称
   left join
   (select 地市,[景区名称],count(*)as 高负荷待扩容小区数
   from 广东.[dbo].重要场景月报统计总表 where  场景='美食'and [是否高负荷待扩容小区]='是' group by 地市,[景区名称]) as temp1
   on 广东.[dbo].美食.地市=temp1.地市 and 广东.[dbo].美食.景区名称=temp1.景区名称