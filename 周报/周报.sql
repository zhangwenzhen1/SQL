/****** Script for SelectTopNRows command from SSMS  ******/
---周报---
--第一步--

USE 广东
GO
------四天覆盖率表合并-------------------------------
 select * into 全省覆盖率0719
  from
  (
    SELECT * FROM [广东].[dbo].[yy_mro_rsrp_day_20180706] where [(移动)总采样点数]>0 union all 
	SELECT * FROM [广东].[dbo].[yy_mro_rsrp_day_20180707] where [(移动)总采样点数]>0 union all
	SELECT * FROM [广东].[dbo].[yy_mro_rsrp_day_20180708] where [(移动)总采样点数]>0 union all
	SELECT * FROM [广东].[dbo].[yy_mro_rsrp_day_20180709] where [(移动)总采样点数]>0
  )b
GO
------------------删除重复行-------------------------
/*select *,row_number() over(partition by [小区ID]order by [小区ID]) as id from [流量系数]*/
--注释：row_number() over(partition by s# order by s#) 
--按s#进行分组排序，row_number()表示s#相同情况下也进行排序
with ab as(
　　　　select * from
　　　　　　(select *,row_number() over(partition by [开始时间],[CGI] order by [开始时间],[CGI]) as id from [广东].[dbo].[全省覆盖率0719]) a
　　　　where id>1)
　　delete from ab
/*select [开始时间],[CGI],[(移动)总采样点数] from [广东].[dbo].[全省覆盖率0719] where CGI='460-00-704215-3'*/
-------------------更改覆盖日期（若需要）-------------------------
update [广东].[dbo].[全省覆盖率0719] set [开始时间]='2018-07-14' where [开始时间]='2018-07-07'
update [广东].[dbo].[全省覆盖率0719] set [开始时间]='2018-07-15' where [开始时间]='2018-07-08'
update [广东].[dbo].[全省覆盖率0719] set [开始时间]='2018-07-16' where [开始时间]='2018-07-06'
update [广东].[dbo].[全省覆盖率0719] set [开始时间]='2018-07-17' where [开始时间]='2018-07-09'
---------------四天KPI表合并--------若计算系数排除上下行流量为零的小区---------------------------------------------------------------------------------------
USE 广东
GO
 select * into 广东.dbo.四天KPI0719
  from
  (
    SELECT * FROM [广东].[dbo].[sumdb.a_common_pm_lte201807181511_1]   union all 
	SELECT * FROM [广东].[dbo].[sumdb.a_common_pm_lte201807181511_2]   union all
	SELECT * FROM [广东].[dbo].[sumdb.a_common_pm_lte201807181511_3]   union all
	SELECT * FROM [广东].[dbo].[sumdb.a_common_pm_lte201807181511_4]   union all
	SELECT * FROM [广东].[dbo].[sumdb.a_common_pm_lte201807181511_5]   
  )b
------------------删除重复行------------------
with ab as(
　　　　select * from
　　　　　　(select *,row_number() over(partition by ["开始时间"],[CGI] order by ["开始时间"],[CGI]) as id from [广东].[dbo].[四天KPI0719]) a
　　　　where id>1)
　　delete from ab

/*select ["开始时间"],[CGI],[上行流量(KByte)] from [广东].[dbo].[四天KPI0719] where CGI='460-00-704215-3'*/
-------------系数计算---------------------------------------------------------------------






--------------------风景区周报----------------------
SELECT [日期]
      ,[省份]
      ,[景区名称]
      ,[景区编号ID]
      ,[小区名称]
      ,[CGI]
  FROM [广东].[dbo].[风景区周报周末0718-]

  select * from 
  (select 开始时间,CGI,1-[(移动)弱覆盖采样点数量(小于-110)]/[(移动)总采样点数] as覆盖率 from [广东].[dbo].[全省覆盖率0719]) as temp right join 
  [广东].[dbo].[风景区周报周末0718-] on [广东].[dbo].[风景区周报周末0718-].CGI= temp.CGI and [广东].[dbo].[风景区周报周末0718-].日期=temp.开始时间
  left join
  (select CGI
		,["开始时间"] as 日期
		,([上行流量(KByte)]+[下行流量(KByte)])/1024/1024  as '日均4G流量（GB）'
		,[无线接通率(%)]
        ,[无线掉线率(%)]
        ,[无线接通率(QCI 1)(%)] as [volte无线接通率（%）]
         ,[E-RAB掉线率(QCI 1)(小区级)(%)] as[volte无线掉话率（%）]
         ,[eSRVCC切换成功率(%)]
		from [广东].[dbo].[四天KPI0719]) as temp1 
		on  [广东].[dbo].[风景区周报周末0718-].日期=temp1.日期 and [广东].[dbo].[风景区周报周末0718-].CGI=temp1.CGI  left join
  (select CGI   from [广东].[dbo].[长期高负荷待扩容小区]) as temp2
        on   [广东].[dbo].[风景区周报周末0718-].CGI=temp2.CGI 