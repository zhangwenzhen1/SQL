USE [广东]
GO

SELECT [地市]
      ,[小区中文名]
      ,[CGI]
      ,[场景]
      ,[景区名称]
      ,[MR覆盖率]
      ,[日均流量GB]
      ,[无线接通率]
      ,[无线掉线率]
      ,[自忙时峰值利用率]
      ,[VOLTE接通率]
      ,[VOLTE掉话率]
      ,[esrvcc切换占比]
      ,[是否高负荷待扩容小区]
  FROM [dbo].[重要场景月报统计总表]
GO
USE [广东]
GO

select  地市
		,场景
		,count(*) as 小区数
		,sum([MR覆盖率])/count(*)  as MR覆盖率
		into 月报覆盖统计 from 广东.[dbo].[重要场景月报统计总表] group by 地市,场景 order by 地市

select 广东.[dbo].[重要场景月报统计总表].地市
	   ,广东.[dbo].[重要场景月报统计总表].场景
	   ,广东.[dbo].[重要场景月报统计总表].小区数
	   ,广东.[dbo].[重要场景月报统计总表].[MR覆盖率]
	   ,temp.[MR覆盖率<95%小区数]
	   ,temp.[MR覆盖率<95%小区数]*1./广东.[dbo].[重要场景月报统计总表].小区数 as 'MR覆盖率<95%小区占比'
  from
(select 地市,场景,count(*) as 'MR覆盖率<95%小区数' from 广东.[dbo].[重要场景月报统计总表] where MR覆盖率<0.95 group by 地市,场景  )as temp right join 
广东.[dbo].月报覆盖统计 on 广东.[dbo].月报覆盖统计.地市=temp.地市 and 广东.[dbo].月报覆盖统计.场景=temp.场景




		
