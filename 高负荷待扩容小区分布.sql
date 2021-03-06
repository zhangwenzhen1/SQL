/****** 需先生成[长期高负荷小区]表  ******/
USE [容量]
select[长期高负荷小区].[小区ID]
     ,[流量系数1].[地市]
	 ,[流量系数1].[RRC连接最大数]
	 ,[流量系数1].[频段]
     ,[流量系数1].[载波带宽]
	 into 高负荷小区 from [长期高负荷小区],[流量系数1] where  [长期高负荷小区].[小区ID]=[流量系数1].[小区ID]
select 地市,count(*) as [长期高负荷小区数] into 高负荷待扩容小区 from [容量].[dbo].高负荷小区  group by 地市 order by 地市

select temp.[地市]
	 ,高负荷待扩容小区.[长期高负荷小区数]
	 ,temp.超高用户小区数
	 ,ltrim(cast((超高用户小区数)*1./(长期高负荷小区数)* 100 as numeric(10,2) ))+'%'as 超高用户小区占比
	 ,temp1.D频段小区数
	 ,temp2.E频段小区数
	 ,temp3.F1频段小区数
	 ,temp4.F2频段小区数
	into 高负荷待扩容小区分布 from 

(select 地市, count(*) as [超高用户小区数]from [容量].[dbo].高负荷小区 where  [RRC连接最大数]>=150 group by 地市) as temp 
left join 高负荷待扩容小区 on 高负荷待扩容小区.[地市]=temp.地市 left join
 
(select 地市, count(*) as D频段小区数 from [容量].[dbo].高负荷小区 where [频段]='D' group by 地市 ) as temp1
 on 高负荷待扩容小区.[地市]=temp1.[地市] left join

 (select 地市, count(*) as E频段小区数 from [容量].[dbo].高负荷小区 where [频段]='E' group by 地市 ) as temp2
 on 高负荷待扩容小区.[地市]=temp2.[地市] left join
 (select 地市, count(*) as F1频段小区数 from [容量].[dbo].高负荷小区 where [频段]='F'and [载波带宽]=20.00  group by 地市 ) as temp3
 on 高负荷待扩容小区.[地市]=temp3.[地市] left join
  (select 地市, count(*) as F2频段小区数 from [容量].[dbo].高负荷小区 where [频段]='F'and [载波带宽]=10.00  group by 地市 ) as temp4
 on 高负荷待扩容小区.[地市]=temp4.[地市] 

