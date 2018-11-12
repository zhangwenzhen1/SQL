USE [广东]
GO
-------------初始化数据---------------
update [广东].[dbo].[周平均忙时0709-15]
 set [上行日流量(MB)] = NULL
	,[下行日流量(MB)] = NULL
	,[上行PRB平均利用率(v2 8)] = NULL
	,[下行PRB平均利用率(v2 8)] = NULL
	,[PDCCH信道CCE占用率] = NULL
	,[无线接通率]= NULL
	,[无线掉线率]= NULL
	where
	([上行PRB平均利用率(v2 8)]<=0
	and [下行PRB平均利用率(v2 8)]<=0
	and [下行PRB平均利用率(v2 8)]<=0) or(
	 [上行PRB平均利用率(v2 8)] is NULL
	and [下行PRB平均利用率(v2 8)] is NULL
	and [下行PRB平均利用率(v2 8)] is NULL)

---------------------------

SELECT [地市]
      ,[小区中文名]
      ,[CGI]
      ,[场景]
      ,[景区名称]
  FROM [广东].[dbo].[重要场景清单]

---------------找出重要场景清单中无效小区-从周平均忙时数据表中------------------------
update  [广东].[dbo].[重要场景清单] set  [广东].[dbo].[重要场景清单].[是否有效小区]= '是'  
 from [广东].[dbo].[重要场景清单],[广东].dbo.[周平均忙时0709-15]
 where [广东].dbo.[周平均忙时0709-15].小区ID=[广东].[dbo].[重要场景清单] .CGI

delete  from [广东].[dbo].[重要场景清单] where [广东].[dbo].[重要场景清单].[是否有效小区] is NULL

--------------------------------------

select*
	   into [广东].[dbo].风景区KPItemp from [广东].[dbo].[风景区KPI0718] where [广东].[dbo].[风景区KPI0718].["开始时间"]='2018-07-14'


	   update [广东].[dbo].风景区KPItemp  set [无线接通率(%)]=100 where [无线接通率(%)]>100
	   update [广东].[dbo].风景区KPItemp  set [无线接通率(QCI 1)(%)]=100 where [无线接通率(QCI 1)(%)]>100
	   update [广东].[dbo].风景区KPItemp  set[eSRVCC切换成功率(%)]=100 where [eSRVCC切换成功率(%)]>100
	   update [广东].[dbo].风景区KPItemp  set[eSRVCC切换成功率(%)]=100 where [eSRVCC切换成功率(%)]>100


USE [广东]
GO
select 
       广东.[dbo].[重要场景清单].[地市]
      ,广东.[dbo].[重要场景清单].[小区中文名]
      ,广东.[dbo].[重要场景清单].[CGI]
      ,广东.[dbo].[重要场景清单].[场景]
      ,广东.[dbo].[重要场景清单].[景区名称]
	  ,temp.MR覆盖率
	  ,temp.[(移动)弱覆盖采样点数量(小于-110)]
	  ,temp.[(移动)总采样点数]
	  ,temp1.日均流量GB
	  ,temp1.无线接通率
	  ,temp1.无线掉线率
	  ,temp1.[上行PRB平均利用率(v2 8)]
	  ,temp1.[下行PRB平均利用率(v2 8)]
	  ,temp1.PDCCH信道CCE占用率
	  ,temp1.自忙时峰值利用率
	  --,temp2.VOLTE接通率
	  --,temp2.VOLTE掉话率
	  --,temp2.esrvcc切换占比 as esrvcc切换占比
	  ,temp3.是否高负荷待扩容小区
into 广东.[dbo].重要场景月报统计总表 from 
(select 1-[(移动)弱覆盖采样点数量(小于-110)]*1.0/[(移动)总采样点数]as[MR覆盖率],[CGI],[(移动)弱覆盖采样点数量(小于-110)],[(移动)总采样点数] from [广东].[dbo].[yy_mro_rsrp_mon_20180606(9~10日22~25日28~29日汇总)] where[(移动)总采样点数]>0) as temp right join 广东.[dbo].[重要场景清单]
   on temp.CGI= 广东.[dbo].[重要场景清单].CGI left join
(select [小区ID]
       ,([上行日流量(MB)]+[下行日流量(MB)])/1024 as 日均流量GB 
	   , iif([上行PRB平均利用率(v2 8)] >[下行PRB平均利用率(v2 8)]and[上行PRB平均利用率(v2 8)]>[PDCCH信道CCE占用率],[上行PRB平均利用率(v2 8)],iif([下行PRB平均利用率(v2 8)]>[PDCCH信道CCE占用率],[下行PRB平均利用率(v2 8)],[PDCCH信道CCE占用率])) as 自忙时峰值利用率
	   , [无线接通率]
	   , [无线掉线率]
	   ,[下行PRB平均利用率(v2 8)]
       ,[上行PRB平均利用率(v2 8)]
       ,[PDCCH信道CCE占用率]
	   from [广东].[dbo].[周平均忙时0709-15])as temp1  on 广东.[dbo].[重要场景清单].CGI=temp1.[小区ID]  left join
(select CGI 
      ,[无线接通率(QCI 1)(%)]*0.01    as   VOLTE接通率
      ,[E-RAB掉线率(QCI 1)(小区级)(%)]*0.01 as VOLTE掉话率
      ,[eSRVCC切换成功率(%)]*0.01 as esrvcc切换占比
	  from [广东].[dbo].风景区KPItemp ) as temp2 
	  on 广东.[dbo].[重要场景清单].CGI=temp2.[CGI] left join 
	  (select CGI as 是否高负荷待扩容小区 from [广东].[dbo].[长期高负荷待扩容小区]) as temp3
	  on 广东.[dbo].[重要场景清单].CGI=temp3.是否高负荷待扩容小区 

  GO

  update 广东.[dbo].重要场景月报统计总表 set 是否高负荷待扩容小区='是' where 是否高负荷待扩容小区 is NOT NULL
  update 广东.[dbo].重要场景月报统计总表 set 是否高负荷待扩容小区='否' where 是否高负荷待扩容小区 is  NULL
  update 广东.[dbo].重要场景月报统计总表 set 无线接通率=0.993 where 无线接通率>=1
  update 广东.[dbo].重要场景月报统计总表 set 自忙时峰值利用率=0.993 where 自忙时峰值利用率>=1
  update 广东.[dbo].重要场景月报统计总表 set [上行PRB平均利用率(v2 8)]=0.993 where [上行PRB平均利用率(v2 8)]>=1
  update 广东.[dbo].重要场景月报统计总表 set [下行PRB平均利用率(v2 8)]=0.993 where [下行PRB平均利用率(v2 8)]>=1
  update 广东.[dbo].重要场景月报统计总表 set  [PDCCH信道CCE占用率]=0.993 where [PDCCH信道CCE占用率]>=1
  update 广东.[dbo].重要场景月报统计总表 set  [MR覆盖率]=0.99 where [MR覆盖率]>=1
  update 广东.[dbo].重要场景月报统计总表 set  [PDCCH信道CCE占用率]=0 where [PDCCH信道CCE占用率]<0
  /*update 广东.[dbo].重要场景月报统计总表 set  	 MR覆盖率='' where MR覆盖率 is NULL*/



  
  ----------------------------------------------------------------------------------------------------------
  USE [广东]
GO
 select 地市,场景
		,count(*) as 小区数
		,1-sum([(移动)弱覆盖采样点数量(小于-110)])/sum([(移动)总采样点数]) as MR覆盖率
		/*sum([MR覆盖率])/count(*)  as MR覆盖率*/
into 月报覆盖统计 from 广东.[dbo].重要场景月报统计总表 group by 地市,场景
GO
---- 月报覆盖统计表----
select 广东.[dbo].[月报覆盖统计].地市
      ,广东.[dbo].[月报覆盖统计].场景
	  ,广东.[dbo].[月报覆盖统计].小区数
	  ,广东.[dbo].[月报覆盖统计].MR覆盖率
	  ,temp.[MR覆盖率<95%小区数]
	  ,cast((temp.[MR覆盖率<95%小区数]*1./广东.[dbo].[月报覆盖统计].小区数) as numeric(10,4) ) as 'MR覆盖率<95%小区占比'
   from
(select 地市,场景, count(*)as 'MR覆盖率<95%小区数' from 广东.[dbo].[重要场景月报统计总表] where MR覆盖率<0.95 group by 地市,场景 ) as temp
right join 广东.[dbo].[月报覆盖统计] on 广东.[dbo].[月报覆盖统计].地市=temp.地市 and 广东.[dbo].[月报覆盖统计].场景=temp.场景


----------------------------------------
 USE [广东]
GO
select 地市,场景
		,count(*) as 小区数
		,sum(日均流量GB)/count(日均流量GB)  as 日均流量GB
		,sum(自忙时峰值利用率)/count (自忙时峰值利用率) as 自忙时峰值利用率
		,sum(无线接通率)/count(无线接通率)  as 无线接通率
		,sum(无线掉线率)/count (无线掉线率) as 无线掉线率
		,sum([上行PRB平均利用率(v2 8)])/count([上行PRB平均利用率(v2 8)]) as [上行PRB平均利用率]
		,sum([下行PRB平均利用率(v2 8)])/count([下行PRB平均利用率(v2 8)]) as [下行PRB平均利用率]
		,sum(PDCCH信道CCE占用率)/count(PDCCH信道CCE占用率) as PDCCH信道CCE占用率
into 重要场景容量统计	from 广东.[dbo].重要场景月报统计总表 group by 地市,场景

select 广东.[dbo].[重要场景容量统计].地市
       ,广东.[dbo].[重要场景容量统计].场景
	   ,广东.[dbo].[重要场景容量统计].小区数
	   ,广东.[dbo].[重要场景容量统计].日均流量GB
	   ,广东.[dbo].[重要场景容量统计].自忙时峰值利用率
	   ,广东.[dbo].[重要场景容量统计].无线接通率
	   ,广东.[dbo].[重要场景容量统计].无线掉线率
	   ,广东.[dbo].[重要场景容量统计].[上行PRB平均利用率]
	   ,广东.[dbo].[重要场景容量统计].[下行PRB平均利用率]
	   ,广东.[dbo].[重要场景容量统计].PDCCH信道CCE占用率
	   ,temp.高负荷待扩容小区数
	   ,cast((temp.高负荷待扩容小区数*1./广东.[dbo].[重要场景容量统计].小区数) as numeric(10,2) )  as 高负荷待扩容小区占比

 from
   (select 地市,场景,count(*)as 高负荷待扩容小区数
   from 广东.[dbo].重要场景月报统计总表 where [是否高负荷待扩容小区]='是' group by 地市,场景) as temp
   right join 广东.[dbo].[重要场景容量统计] on 广东.[dbo].[重要场景容量统计].地市=temp.地市 and 广东.[dbo].[重要场景容量统计].场景=temp.场景

GO

 --------------------------------------------------性能表统计
 USE [广东]
 GO
   
   select 地市,场景
		,count(*) as 小区数
		,sum(无线接通率)/count(无线接通率)  as 无线接通率
		,sum(无线掉线率)/count (无线掉线率) as 无线掉线率
		,sum([上行PRB平均利用率(v2 8)])/count([上行PRB平均利用率(v2 8)]) as [上行PRB平均利用率]
		,sum([下行PRB平均利用率(v2 8)])/count([下行PRB平均利用率(v2 8)]) as [下行PRB平均利用率]
		,sum(PDCCH信道CCE占用率)/count(PDCCH信道CCE占用率) as PDCCH信道CCE占用率
		--,sum(VOLTE接通率)/count(VOLTE接通率) as VOLTE接通率
		--,sum(VOLTE掉话率)/count(VOLTE掉话率)  as  VOLTE掉话率
		--,sum(esrvcc切换占比)/count(esrvcc切换占比)  as  esrvcc切换占比
from 广东.[dbo].重要场景月报统计总表 group by 地市,场景


GO

--------------------------------------------------
/*
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
	 ---- ,sum(VOLTE接通率)/count(*) as VOLTE接通率
	--  ,sum(VOLTE掉话率)/count(*)  as  VOLTE掉话率
	 -- ,ltrim(sum(esrvcc切换占比)/count(*))+'%'  as  esrvcc切换占比
  into 医院  from 广东.[dbo].重要场景月报统计总表  where 场景='医院' group by 地市,[景区名称] 

  select 广东.[dbo].医院.地市
        ,广东.[dbo].医院.景区名称
		,广东.[dbo].医院.小区数
		,广东.[dbo].医院.MR覆盖率
		,temp.[MR覆盖率<95%小区数]
		,ltrim(cast((temp.[MR覆盖率<95%小区数]*1./广东.[dbo].医院.小区数)* 100 as numeric(10,2) ))+'%'  as 'MR覆盖率<95%小区占比'
		,广东.[dbo].医院.日均流量GB
		,广东.[dbo].医院.自忙时峰值利用率
		,广东.[dbo].医院.无线接通率
		,广东.[dbo].医院.无线掉线率
		,广东.[dbo].医院.VOLTE接通率
		,广东.[dbo].医院.VOLTE掉话率
		,广东.[dbo].医院.esrvcc切换占比
		,temp1.高负荷待扩容小区数
		,ltrim(cast((temp1.高负荷待扩容小区数*1./广东.[dbo].医院.小区数)* 100 as numeric(10,2) ))+'%'  as 高负荷待扩容小区占比
  from 
  (select  地市
           ,[景区名称]
	       ,count(*)as 'MR覆盖率<95%小区数'
   from 广东.[dbo].重要场景月报统计总表  where 场景='医院'and  MR覆盖率<0.95  group by 地市,[景区名称])as temp
   right join 广东.[dbo].医院 on 广东.[dbo].医院.地市=temp.地市 and 广东.[dbo].医院.景区名称=temp.景区名称
   left join
   (select 地市,[景区名称],count(*)as 高负荷待扩容小区数
   from 广东.[dbo].重要场景月报统计总表 where  场景='医院'and [是否高负荷待扩容小区]='是' group by 地市,[景区名称]) as temp1
   on 广东.[dbo].医院.地市=temp1.地市 and 广东.[dbo].医院.景区名称=temp1.景区名称
   */