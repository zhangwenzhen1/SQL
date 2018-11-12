USE [广东]
GO

select distinct 地市,景区名称 into 医院 from [广东].dbo.[风景区周报日常] where 场景='医院'order by 地市
/* select 地市,景区名称 into 医院 from [广东].dbo.[风景区周报日常] where 场景='医院'order by 地市*/
/*x需要删除表[广东].dbo.[医院]中的重复行*/
select temp.地市
	   ,temp.景区名称 as 场景名城
	   ,temp.小区数
	   ,temp1.MR覆盖率
	   ,temp2.[MR覆盖率<95%小区数]
	   ,ltrim(cast((temp2.[MR覆盖率<95%小区数]*1.0/temp.小区数)* 100 as numeric(10,2) ))+'%' as 'MR覆盖率<95%小区占比'
	   ,temp3.日均流量GB
	   ,temp3.自忙时峰值利用率
	   ,temp5.[无线接通率(%)]
	   ,temp5.[无线掉线率(%)]
	   ,temp5.VOLTE接通率
	   ,temp5.VOLTE掉话率
	   ,ltrim(cast((temp5.esrvcc切换占比) as numeric(10,2)))+'%' as esrvcc切换占比
	   ,temp4.高负荷待扩容小区数
	   ,ltrim(cast((temp4.高负荷待扩容小区数*1.0/temp.小区数)* 100 as numeric(10,2) ))+'%' as '高负荷待扩容小区占比'
from
	(select  地市,景区名称,count(*) as 小区数 from [广东].dbo.[风景区周报日常] where 场景='医院' group by 地市,景区名称)AS temp
	 right join  [广东].dbo.[医院] on [广东].dbo.[医院].地市=temp.地市 and [广东].dbo.[医院].景区名称=temp.景区名称 left join
	 (select 地市,景区名称,(1-sum([(移动)弱覆盖采样点数量(小于-110)])/sum ([(移动)总采样点数]))as MR覆盖率 from [广东].dbo.[风景区周报1] where 场景='医院' group by 地市,景区名称) AS temp1
	  on [广东].dbo.[医院].地市=temp1.地市 and [广东].dbo.[医院].景区名称=temp1.景区名称 left join
	  (select 地市,景区名称,count(*) as 'MR覆盖率<95%小区数' from [广东].dbo.[风景区周报1]where 场景='医院'and MR覆盖率<0.95 group by 地市,景区名称)AS temp2 
	   on [广东].dbo.[医院].地市=temp2.地市 and [广东].dbo.[医院].景区名称=temp2.景区名称 left join
	   (select  地市,景区名称,sum([日均4G流量(GB)]) as 日均流量GB,sum(最大利用率)/count(*) as 自忙时峰值利用率 from [广东].dbo.[风景区周报日常] where 场景='医院' group by 地市,景区名称)AS temp3
	   on [广东].dbo.[医院].地市=temp3.地市 and [广东].dbo.[医院].景区名称=temp3.景区名称 left join
	 (select  地市,景区名称,count(*) as 高负荷待扩容小区数 from [广东].dbo.[风景区周报日常] where 场景='医院' and 是否高负荷待扩容小区='是' group by 地市,景区名称)AS temp4
	 on [广东].dbo.[医院].地市=temp4.地市 and [广东].dbo.[医院].景区名称=temp4.景区名称 left join
	 (select  地市,景区名称
	  ,sum([无线接通率(%)])/count(*) as [无线接通率(%)]
      ,sum([无线掉线率(%)])/count(*) as [无线掉线率(%)]
      ,sum([无线接通率(QCI 1)(%)])/count(*) as VOLTE接通率
      ,sum([E-RAB掉线率(QCI 1)(小区级)(%)])/count(*) as VOLTE掉话率
      ,sum([eSRVCC切换成功率(%)] )/count(*) as esrvcc切换占比
	  from [广东].dbo.[风景区周报日常] where 场景='医院' group by 地市,景区名称) as temp5
	  on [广东].dbo.[医院].地市=temp5.地市 and [广东].dbo.[医院].景区名称=temp5.景区名称 


	
     