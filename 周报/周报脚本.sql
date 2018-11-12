USE [广东]
GO
/*
SELECT [日期]
      ,[省份]
      ,[景区名称]
      ,[景区编号ID]
      ,[小区名称]
      ,[CGI]
  FROM [dbo].[风景区周报]
GO
*/
select '2018-08-06' ::date as      starttime_date--日期
	   ,sumdb.A_COMMON_PM_LTE_CELL_D.CGI
	   ,sumdb.A_COMMON_PM_LTE_CELL_D.city--地市
	   ,sumdb.A_COMMON_PM_LTE_CELL_D.cell_name--小区名称
	   ,temp.MR覆盖率
	   ,temp3.日均流量GB
	   ,temp1.上行PRB平均利用率
	   ,temp1.下行PRB平均利用率
	   ,temp1.PDCCH信道CCE占用率
	   ,temp2.有效RRC连接最大数
	   ,temp1.上行峰值流量MB
	   ,temp1.下行峰值流量MB 
	   ,temp3.无线接通率
	   ,temp3.无线掉线率
	   ,temp3.volte无线接通率
	   ,temp3.volte无线掉话率
	   ,temp3.Srvcc切换成功率
	  -- ,temp4.是否高负荷待扩容小区 
  from
----MR覆盖率----
( select CGI
		,RSRP_LT_F110
		,RSRP_COUNT
		,cast((RSRP_COUNT-RSRP_LT_F110)*1./RSRP_COUNT as numeric(10,4)) as MR覆盖率 
		FROM rnodb.M_MRO_RSRP_ALL 
		where STARTTIME='2018-07-16 00:00:00' and  RSRP_COUNT>'0' 
 ) as temp right join /*广东.[dbo].[风景区周报] */sumdb.A_COMMON_PM_LTE_CELL_D
   on sumdb.A_COMMON_PM_LTE_CELL_D.CGI=temp.CGI  left join
   ---峰值统计-
    (select '2018-8-06' ::date as      starttime_date
			,CGI
			,max(UL_PRBUSE_RATE) as 上行PRB平均利用率
			,max(DL_PRBUSE_RATE) as 下行PRB平均利用率
			,max(PDCCHCCEUTILRATIO) as PDCCH信道CCE占用率
			,max(cast((UPOCTUL/1024) as numeric(10,4))) as 上行峰值流量MB
			,max(cast((UPOCTDL/1024) as numeric(10,4))) as 下行峰值流量MB 
        from sumdb.A_COMMON_PM_LTE_CELL_H 
		where starttime>='2018-08-06 00:00:00' and starttime<'2018-08-08 00:00:00'
		group by CGI) as temp1 on  sumdb.A_COMMON_PM_LTE_CELL_D.CGI=temp1.CGI left join
     ---RRC用户数峰值统计---
	(select 
			'2018-08-06' ::date as      starttime_date
			,CGI
			,max(EFFECTIVECONNMAX) as 有效RRC连接最大数
			from rnodb.M_PM_CELL 
			where starttime>='2018-08-06 00:00:00' and starttime<'2018-08-08 00:00:00'
			group by CGI) as temp2 on  sumdb.A_COMMON_PM_LTE_CELL_D.CGI=temp2.CGI left join
	 ------
	 (select 
			'2018-08-06' ::date as      starttime_date
			,CGI
			,avg(cast( ((UPOCTUL+UPOCTDL))/1024/1024 as numeric(10,4))) as 日均流量GB
			,avg(RADIO_SUCC_RATE) as 无线接通率
			,avg(RADIO_DROP_RATE) as 无线掉线率
			,avg(RADIO_SUCC_RATE_1)  as volte无线接通率
			,avg(ERAB_DROP_RATE_1) as volte无线掉话率
			,avg(LTE_2G_SUCC_RATE) as Srvcc切换成功率
			from sumdb.A_COMMON_PM_LTE_CELL_D 
			where starttime>='2018-08-06 00:00:00' and starttime<'2018-08-08 00:00:00' 
			group by CGI) as temp3 on  sumdb.A_COMMON_PM_LTE_CELL_D.CGI=temp3.CGI
		/*	 left join
		--是否高负荷小区-
		
	(select CGI as 是否高负荷待扩容小区 from [广东].[dbo].[长期高负荷待扩容小区]) as temp4
	  on 广东.[dbo].[风景区周报].CGI=temp4.是否高负荷待扩容小区 */
	---------------------------------------------------------------------------------------------
/*
--MR覆盖率
 select CGI,RSRP_LT_F110,RSRP_COUNT,cast((RSRP_COUNT-RSRP_LT_F110)*1./RSRP_COUNT as numeric(10,4)) as MR FROM rnodb.M_MRO_RSRP_ALL where STARTTIME='2018-07-21 00:00:00' and  RSRP_COUNT>'0' 

 --峰值统计
select 
      '2018-7-21' ::date as      starttime_date
      ,CGI
      ,CELL_NAME
      ,max(UL_PRBUSE_RATE) as 上行PRB平均利用率
      ,max(DL_PRBUSE_RATE) as 下行PRB平均利用率
      ,max(PDCCHCCEUTILRATIO) as PDCCH信道CCE占用率
      ,max(cast((UPOCTUL/1024) as numeric(10,4))) as 上行峰值流量MB
      ,max(cast((UPOCTDL/1024) as numeric(10,4))) as 下行峰值流量MB 
from sumdb.A_COMMON_PM_LTE_CELL_H 
where starttime>='2018-07-21 00:00:00' and starttime<'2018-07-23 00:00:00'
group by cgi,CELL_NAME

 --RRC用户数峰值统计
select 
      '2018-7-21' ::date as      starttime_date
      ,CGI
      ,max(EFFECTIVECONNMAX) as 有效RRC连接最大数
from rnodb.M_PM_CELL 
where starttime>='2018-07-21 00:00:00' and starttime<'2018-07-23 00:00:00'
group by cgi



 --天级流量和性能指标
select 
      '2018-7-21' ::date as      starttime_date
      ,CGI
      ,CELL_NAME
      ,avg(cast( ((UPOCTUL+UPOCTDL))/1024/1024 as numeric(10,4))) as 日均流量GB
      ,avg(RADIO_SUCC_RATE) as 无线接通率
      ,avg(RADIO_DROP_RATE) as 无线掉线率
      ,avg(RADIO_SUCC_RATE_1)  as volte无线接通率
      ,avg(ERAB_DROP_RATE_1) as volte无线掉话率
      ,avg(LTE_2G_SUCC_RATE) as Srvcc切换成功率
from sumdb.A_COMMON_PM_LTE_CELL_D 
where starttime>='2018-06-06 00:00:00' and starttime<'2018-06-08 00:00:00' 
group by cgi,cell_name
*/