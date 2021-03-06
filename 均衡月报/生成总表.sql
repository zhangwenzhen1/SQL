/****** Script for SelectTopNRows command from SSMS  ******/
USE 广东
GO
/*
update [容量].[dbo].[小区工参] set 路测网格='A' where 路测网格 like 'A%'
update [容量].[dbo].[小区工参] set 路测网格='C' where 路测网格 like 'C%'
update [容量].[dbo].[小区工参] set 路测网格='D' where 路测网格=''
update [容量].[dbo].[小区工参] set 路测网格='B' where 路测网格!='D' and 路测网格!='A'and  路测网格!='C'
*/
with s as 
	(	select  地市
			 ,小区ID
			 ,round(([上行日流量(MB)]+[下行日流量(MB)])/1024,2)as 日流量GB
		FROM [广东].[dbo].[周平均忙时0727-0802]
	),	
	s1 as
	(select 地市, sum(([上行日流量(MB)]+[下行日流量(MB)])/1024)/count([下行日流量(MB)]) as 地市单小区日均流量GB  from [广东].[dbo].[周平均忙时流量0703] group by 地市 
	),
	s2 as
	(SELECT 小区ID,网格,路测网格 FROM [容量].[dbo].[小区工参] )
	select [省份] 
		,[广东].[dbo].[周平均忙时0727-0802].[地市]
      ,[广东].[dbo].[周平均忙时0727-0802].[小区ID]
      ,[小区名称]
	  ,s2.网格
	  ,s2.路测网格
      ,[基站ID]
      ,[基站名称]
      ,[主设备厂家]
      ,[室内外基站属性]
      ,[区域类型]
      ,[覆盖场景]
      ,[频段]
      ,[载频个数]
      ,[载波带宽(MHZ)]
      ,[经度]
      ,[纬度]
      ,[方位角]
      ,[是否属于五期扩容工程]
      ,[是否多层网小区]
      ,[基础频点小区]
      ,[对应的基础频点小区ID]
      ,[有效RRC连接平均数]
      ,[有效RRC连接最大数]
      ,[RRC连接平均数]
      ,[RRC连接最大数]
      ,[下行PDSCH PRB占用平均数]
      ,[下行PDSCH PRB可用平均数]
      ,[上行PDSCH PRB占用平均数]
      ,[上行PDSCH PRB可用平均数]
      ,[PDCCH信道CCE可用个数]
      ,[PDCCH信道CCE占用个数]
      ,[下行PRB平均利用率(v2 6)]
      ,[上行PRB平均利用率(v2 6)]
      ,[下行PDSCH PRB占用数]
      ,[下行PDSCH PRB可用数]
      ,[上行PDSCH PRB占用数]
      ,[上行PDSCH PRB可用数]
      ,[下行PRB平均利用率(v2 8)]
      ,[上行PRB平均利用率(v2 8)]
      ,[PDCCH信道CCE占用率]
      ,[下行业务信道流量(MB)]
      ,[上行业务信道流量(MB)]
      ,[下行用户平均速率]
      ,[上行用户平均速率]
      ,[平均E-RAB数]
      ,[E-RAB建立成功数]
      ,[VOLTE语音话务量]
      ,[VOLTE语音峰值用户数]
      ,[下行VOLTE占用PRB总数]
      ,[上行VOLTE占用PRB总数]
      ,[分QCI的建立成功次数(QCI5)]
      ,[小区用户面上行字节数（QCI5）]
      ,[小区用户面下行字节数（QCI5）]
      ,[无线接通率]
      ,[E-RAB拥塞率(无线资源不足)]
      ,[上行日流量(MB)]
      ,[下行日流量(MB)]
      ,[设备型号(仅室外微站填写)]
      ,[通道最大发射功率(W)]
      ,[无线掉线率]
      ,[无线掉线率(剔除UI)]
      ,[E-RAB掉线率]
      ,[E-RAB建立成功率]
      ,[切换成功率]
      ,[天线挂高]
      ,[CQI平均值]
	  ,s.日流量GB
	  ,iif([上行PRB平均利用率(v2 8)] >[下行PRB平均利用率(v2 8)]and[上行PRB平均利用率(v2 8)]>[PDCCH信道CCE占用率],[上行PRB平均利用率(v2 8)],iif([下行PRB平均利用率(v2 8)]>[PDCCH信道CCE占用率],[下行PRB平均利用率(v2 8)],[PDCCH信道CCE占用率])) as 最大利用率
	  ,temp.流量系数
	into 流量系数表 from[广东].[dbo].[周平均忙时0727-0802]
	left join s2 on [广东].[dbo].[周平均忙时0727-0802].小区ID=s2.小区ID
	left join s  on [广东].[dbo].[周平均忙时0727-0802].小区ID=s.小区ID
	left join
	(select s.地市
			,小区ID
			,日流量GB 
			,日流量GB/s1.地市单小区日均流量GB as 流量系数
			from s,s1 where s.地市=s1.地市)as temp 
		on [广东].[dbo].[周平均忙时0727-0802].小区ID=temp.小区ID



