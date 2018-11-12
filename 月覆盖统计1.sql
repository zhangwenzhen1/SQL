USE [广东]


  select 地市,场景 as 场景 ,count(*) as 小区数 into 覆盖率统计表 from [广东].[dbo].[风景区周报日常] group by 地市,场景 order by 地市



  select 
   覆盖率统计表.地市
		,覆盖率统计表.场景
		,覆盖率统计表.小区数
		,temp.MR覆盖率
		,temp1.[MR覆盖率<95%小区数]
		,ltrim(cast((temp1.[MR覆盖率<95%小区数]*1.0/覆盖率统计表.小区数)* 100 as numeric(10,2) ))+'%' as 'MR覆盖率<95%小区占比'
		,temp2.日均流量GB
		,temp2.自忙时峰值利用率
		,temp2.无线接通率
		,temp2.无线掉线率
		,temp3.高负荷待扩容小区数
		,ltrim(cast((temp3.高负荷待扩容小区数*1./覆盖率统计表.小区数)* 100 as numeric(10,2) ))+'%' as 高负荷待扩容小区占比
		,temp2.VOLTE接通率 
		,temp2.VOLTE掉话率
		,ltrim(temp2. esrvcc切换占比)+'%' as esrvcc切换占比
  from
  (select 地市,场景,(1-sum([(移动)弱覆盖采样点数量(小于-110)])/sum ([(移动)总采样点数]))as MR覆盖率 from [广东].[dbo].[风景区周报1] group by 地市,场景 ) as temp
  right join 覆盖率统计表 on 覆盖率统计表.地市=temp.地市 and 覆盖率统计表.场景=temp.场景  left join
  (select 地市,场景,count(*) as 'MR覆盖率<95%小区数' from [广东].[dbo].[风景区周报日常] where MR覆盖率<0.95 group by 地市,场景  )as temp1
   on 覆盖率统计表.地市=temp1.地市 and 覆盖率统计表.场景=temp1.场景  left join
  (select 地市
		  ,场景
		  ,sum([日均4G流量(GB)])/count(*) as 日均流量GB
		  ,sum(最大利用率)/count(*) as 自忙时峰值利用率
		  ,sum([无线接通率(%)])/count(*) as 无线接通率 
		  ,sum([无线掉线率(%)])/count(*) as 无线掉线率
		  ,sum([无线接通率(QCI 1)(%)] )/count(*) as VOLTE接通率
		  ,sum([E-RAB掉线率(QCI 1)(小区级)(%)])/count(*)  as VOLTE掉话率
		  ,sum ([eSRVCC切换成功率(%)])/count(*) as esrvcc切换占比
		  from [广东].[dbo].[风景区周报日常] group by 地市,场景) as temp2
   on 覆盖率统计表.地市=temp2.地市 and 覆盖率统计表.场景=temp2.场景   left join 
  (select 地市,场景,count(*)as 高负荷待扩容小区数
   from [广东].[dbo].[风景区周报日常] where [是否高负荷待扩容小区]='是' group by 地市,场景)as temp3
  on 覆盖率统计表.地市=temp3.地市 and 覆盖率统计表.场景=temp3.场景  



 
   DELETE FROM [广东].[dbo].[月报覆盖] WHERE 地市 is NULL

   /*
 select 地市,场景,count(*) as 'MR覆盖率<95%小区数' from [广东].[dbo].[风景区周报1] where MR覆盖率<0.95 and 地市='肇庆'group by 地市,场景 

 select 地市,场景 ,count(*) as 小区数  from [广东].[dbo].[风景区周报1]where  地市='肇庆' group by 地市,场景 order by 地市

 */
