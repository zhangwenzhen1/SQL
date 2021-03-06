/****** Script for SelectTopNRows command from SSMS  ******/
/****** Script for SelectTopNRows command from SSMS  ******/
/****** Script for SelectTopNRows command from SSMS  ******/
USE [广东]
 GO
select 地市
      ,[景区名称]
	  ,count(*) as 小区数
	  ,sum(MR覆盖率)/count(MR覆盖率) as MR覆盖率
	  ,sum(日均流量GB)/count(日均流量GB)  as 日均流量GB
	  ,sum(自忙时峰值利用率)/count (自忙时峰值利用率) as 自忙时峰值利用率
	  ,sum(无线接通率)/count(无线接通率)  as 无线接通率
	  ,sum(无线掉线率)/count (无线掉线率) as 无线掉线率
	  ,sum([上行PRB平均利用率(v2 8)])/count([上行PRB平均利用率(v2 8)]) as [上行PRB平均利用率]
	  ,sum([下行PRB平均利用率(v2 8)])/count([下行PRB平均利用率(v2 8)]) as [下行PRB平均利用率]
	  ,sum(PDCCH信道CCE占用率)/count(PDCCH信道CCE占用率) as PDCCH信道CCE占用率
	  /*,sum(VOLTE接通率)/count(VOLTE接通率) as VOLTE接通率
	  ,sum(VOLTE掉话率)/count(VOLTE掉话率)  as  VOLTE掉话率
	  ,(sum(esrvcc切换占比)/count(esrvcc切换占比))  as  esrvcc切换占比*/
  into 风景区  from 广东.[dbo].重要场景月报统计总表  where 场景='风景区' group by 地市,[景区名称] 

--------------------风景区统计明细----------------------
USE [广东]
 GO
  select 广东.[dbo].风景区.地市
        ,广东.[dbo].风景区.景区名称
		,广东.[dbo].风景区.小区数
		,广东.[dbo].风景区.MR覆盖率
		,case when temp.[MR覆盖率<95%小区数] is NULL then 0 else temp.[MR覆盖率<95%小区数] end as [MR覆盖率<95%小区数]
		,case when (temp.[MR覆盖率<95%小区数]*1./广东.[dbo].风景区.小区数) is NULL then 0 else 
		cast((temp.[MR覆盖率<95%小区数]*1./广东.[dbo].风景区.小区数) as numeric(10,4)) end as 'MR覆盖率<95%小区占比' 
		,广东.[dbo].风景区.日均流量GB
		,广东.[dbo].风景区.自忙时峰值利用率
		,广东.[dbo].风景区.上行PRB平均利用率
		,广东.[dbo].风景区.下行PRB平均利用率
		,广东.[dbo].风景区.PDCCH信道CCE占用率
		,广东.[dbo].风景区.无线接通率
		,广东.[dbo].风景区.无线掉线率
		--,广东.[dbo].风景区.VOLTE接通率
		--,广东.[dbo].风景区.VOLTE掉话率
		--,广东.[dbo].风景区.esrvcc切换占比
		--,case when temp1.高负荷待扩容小区数 is NULL then 0 else temp1.高负荷待扩容小区数 end as 高负荷待扩容小区数
		--,case when (temp1.高负荷待扩容小区数*1./广东.[dbo].风景区.小区数) is NULL then 0 else 
		--cast((temp1.高负荷待扩容小区数*1./广东.[dbo].风景区.小区数) as numeric(10,4)) end as 高负荷待扩容小区占比
		,case when 自忙时峰值利用率>0.5 then '是' else '' end  as '是否自忙时峰值利用率>50%景区'
		, case when MR覆盖率<0.95 then '是'else '' end  as '是否MR覆盖率<95%景区'
  from 
  (select  地市
           ,[景区名称]
	       ,count(*)as 'MR覆盖率<95%小区数'
   from 广东.[dbo].重要场景月报统计总表  where 场景='风景区'and  MR覆盖率<0.95  group by 地市,[景区名称])as temp
   right join 广东.[dbo].风景区 on 广东.[dbo].风景区.地市=temp.地市 and 广东.[dbo].风景区.景区名称=temp.景区名称
   left join
   (select 地市,[景区名称],count(*)as 高负荷待扩容小区数
   from 广东.[dbo].重要场景月报统计总表 where  场景='风景区'and [是否高负荷待扩容小区]='是' group by 地市,[景区名称]) as temp1
   on 广东.[dbo].风景区.地市=temp1.地市 and 广东.[dbo].风景区.景区名称=temp1.景区名称


   ----------------------------风景区小区统计明细---------------------------------------
   USE [广东]
 GO
 SELECT [地市]
      ,[小区中文名]
      ,[CGI]
      ,[场景]
      ,[景区名称]
      ,[MR覆盖率]
      ,[(移动)弱覆盖采样点数量(小于-110)]
      ,[(移动)总采样点数]
      ,[日均流量GB]
      ,[无线接通率]
      ,[无线掉线率]
      ,[上行PRB平均利用率(v2 8)]
      ,[下行PRB平均利用率(v2 8)]
      ,[PDCCH信道CCE占用率]
      ,[自忙时峰值利用率]
	  ,case when [自忙时峰值利用率]>0.5 then '是' else '' end as '是否自忙时-最大利用率大于50%小区 '
      ,[是否高负荷待扩容小区]
  FROM [dbo].[重要场景月报统计总表] where [场景]='风景区'

GO
---------------风景区容量情况--------------------------
USE [广东]
 GO
   select 
		广东.[dbo].[重要场景容量统计].地市
       ,广东.[dbo].[重要场景容量统计].场景
	   ,广东.[dbo].[重要场景容量统计].小区数
	   ,广东.[dbo].[重要场景容量统计].日均流量GB
	   ,广东.[dbo].[重要场景容量统计].自忙时峰值利用率
	   ,广东.[dbo].[重要场景容量统计].无线接通率
	   ,广东.[dbo].[重要场景容量统计].无线掉线率
	   ,广东.[dbo].[重要场景容量统计].[上行PRB平均利用率]
	   ,广东.[dbo].[重要场景容量统计].[下行PRB平均利用率]
	   ,广东.[dbo].[重要场景容量统计].PDCCH信道CCE占用率
	   ,case when temp.[自忙时-最大利用率大于50%的小区数]is NULL then 0 else temp.[自忙时-最大利用率大于50%的小区数]end as [自忙时-最大利用率大于50%的小区数]
	   ,case when (temp.[自忙时-最大利用率大于50%的小区数]*1./广东.[dbo].[重要场景容量统计].小区数) is NULL then 0 else 
	     temp.[自忙时-最大利用率大于50%的小区数]*1./广东.[dbo].[重要场景容量统计].小区数 end as '自忙时-最大利用率大于50%的小区占比'
	   ,case when temp1.[自忙时-最大利用率大于50%的景区数]is NULL then 0 else temp1.[自忙时-最大利用率大于50%的景区数] end as [自忙时-最大利用率大于50%的景区数]
	   ,case when temp2.景区数 is NULL then 0 else temp2.景区数 end as  景区数
	   ,case when (temp1.[自忙时-最大利用率大于50%的景区数]*1.0/temp2.景区数) is NULL then 0 else 
	     temp1.[自忙时-最大利用率大于50%的景区数]*1.0/temp2.景区数 end as '自忙时-最大利用率大于50%景区占比'
    from 广东.[dbo].[重要场景容量统计]
	left join (select 
	            地市
				,count([小区中文名])as '自忙时-最大利用率大于50%的小区数'
				from [广东].[dbo].[重要场景月报统计总表] 
				where 场景='风景区'and[自忙时峰值利用率]>0.5
				group by 地市)as temp
	 on 广东.[dbo].[重要场景容量统计].地市=temp.地市
	 left join (select 地市,count([景区名称])as '自忙时-最大利用率大于50%的景区数'from[广东].[dbo].[风景区] where [自忙时峰值利用率]>0.5 group by 地市  )as temp1
	  on 广东.[dbo].[重要场景容量统计].地市=temp1.地市
	 left join  (select 地市,count([景区名称])as '景区数'from[广东].[dbo].[风景区]  group by 地市  )as temp2
	 on 广东.[dbo].[重要场景容量统计].地市=temp2.地市
	 where  场景='风景区'
------------------------------------风景区覆盖情况------------------------------------------------
USE [广东]
 GO
 select  广东.[dbo].[月报覆盖统计].地市
		,广东.[dbo].[月报覆盖统计].场景
		,广东.[dbo].[月报覆盖统计].小区数
		,MR覆盖率
		,case when temp.[MR覆盖率<95%小区数]is NULL then 0 else temp.[MR覆盖率<95%小区数] end as [MR覆盖率<95%小区数]
		,case when (temp.[MR覆盖率<95%小区数]*1./广东.[dbo].[月报覆盖统计].小区数) is NULL then 0 else 
		 temp.[MR覆盖率<95%小区数]*1./广东.[dbo].[月报覆盖统计].小区数 end as 'MR覆盖率<95%小区占比'
		,case when temp1.[MR覆盖率<95%景区数]is NUll then 0 else temp1.[MR覆盖率<95%景区数] end as [MR覆盖率<95%景区数]
		,case when temp2.景区数 is NUll then 0 else temp2.景区数 end as 景区数
		,case when (temp1.[MR覆盖率<95%景区数]*1.0/temp2.景区数)is NULL then 0 else 
		 temp1.[MR覆盖率<95%景区数]*1.0/temp2.景区数 end as 'MR覆盖率<95%景区占比'
	from 广东.[dbo].[月报覆盖统计]
	left join (select 地市,场景, count(*)as 'MR覆盖率<95%小区数' from 广东.[dbo].[重要场景月报统计总表] where MR覆盖率<0.95 group by 地市,场景 ) as temp
	 on 广东.[dbo].[月报覆盖统计].地市=temp.地市 and 广东.[dbo].[月报覆盖统计].场景=temp.场景
	left join (select 地市,count([景区名称])as 'MR覆盖率<95%景区数'from[广东].[dbo].[风景区] where MR覆盖率<0.95 group by 地市  )as temp1
	on 广东.[dbo].[月报覆盖统计].地市=temp1.地市
	left join (select 地市,count([景区名称])as 景区数 from[广东].[dbo].[风景区]  group by 地市)as temp2
	 on  广东.[dbo].[月报覆盖统计].地市=temp2.地市
	  where  广东.[dbo].[月报覆盖统计].场景='风景区'

  