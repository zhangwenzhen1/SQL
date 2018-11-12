USE [广东]
GO



SELECT temp.[省份]
      ,temp.[地市]
      ,temp.[小区ID]
      ,temp.[小区名称]
	  ,[容量].[dbo].[小区工参] .网格
	  ,[容量].[dbo].[小区工参] .路测网格
      ,temp.[基站ID]
      ,temp.[基站名称]
      ,temp.[主设备厂家]
      ,temp.[室内外基站属性]
      ,temp.[区域类型]
      ,temp.[覆盖场景]
      ,temp.[频段]
      ,temp.[载频个数]
      ,temp.[载波带宽(MHZ)]
      ,temp.[经度]
      ,temp.[纬度]
      ,temp.[方位角]
      ,temp.[是否属于五期扩容工程]
      ,temp.[是否多层网小区]
      ,temp.[基础频点小区]
      ,temp.[对应的基础频点小区ID]
      ,temp.[有效RRC连接平均数]
      ,temp.[有效RRC连接最大数]
      ,temp.[RRC连接平均数]
      ,temp.[RRC连接最大数]
      ,temp.[下行PDSCH PRB占用平均数]
      ,temp.[下行PDSCH PRB可用平均数]
      ,temp.[上行PDSCH PRB占用平均数]
      ,temp.[上行PDSCH PRB可用平均数]
      ,temp.[PDCCH信道CCE可用个数]
      ,temp.[PDCCH信道CCE占用个数]
      ,temp.[下行PRB平均利用率(v2 6)]
      ,temp.[上行PRB平均利用率(v2 6)]
      ,temp.[下行PDSCH PRB占用数]
      ,temp.[下行PDSCH PRB可用数]
      ,temp.[上行PDSCH PRB占用数]
      ,temp.[上行PDSCH PRB可用数]
      ,temp.[下行PRB平均利用率(v2 8)]
      ,temp.[上行PRB平均利用率(v2 8)]
      ,temp.[PDCCH信道CCE占用率]
      ,temp.[下行业务信道流量(MB)]
      ,temp.[上行业务信道流量(MB)]
      ,temp.[下行用户平均速率]
      ,temp.[上行用户平均速率]
      ,temp.[平均E-RAB数]
      ,temp.[E-RAB建立成功数]
      ,temp.[VOLTE语音话务量]
      ,temp.[VOLTE语音峰值用户数]
      ,temp.[下行VOLTE占用PRB总数]
      ,temp.[上行VOLTE占用PRB总数]
      ,temp.[分QCI的建立成功次数(QCI5)]
      ,temp.[小区用户面上行字节数（QCI5）]
      ,temp.[小区用户面下行字节数（QCI5）]
      ,temp.[无线接通率]
      ,temp.[E-RAB拥塞率(无线资源不足)]
      ,temp.[上行日流量(MB)]
      ,temp.[下行日流量(MB)]
      ,temp.[设备型号(仅室外微站填写)]
      ,temp.[通道最大发射功率(W)]
      ,temp.[无线掉线率]
      ,temp.[无线掉线率(剔除UI)]
      ,temp.[E-RAB掉线率]
      ,temp.[E-RAB建立成功率]
      ,temp.[切换成功率]
      ,temp.[天线挂高]
      ,temp.[CQI平均值]
	 /* ,round(([上行日流量(MB)]+[下行日流量(MB)])/1024,2)as 日流量GB
	  ,iif([上行PRB平均利用率(v2 8)] >[下行PRB平均利用率(v2 8)]and[上行PRB平均利用率(v2 8)]>[PDCCH信道CCE占用率],[上行PRB平均利用率(v2 8)],iif([下行PRB平均利用率(v2 8)]>[PDCCH信道CCE占用率],[下行PRB平均利用率(v2 8)],[PDCCH信道CCE占用率])) as 最大利用率
	  */
into 总表temp FROM
/*(SELECT [小区ID],[网格],[路测网格]from [容量].[dbo].[小区工参]) as temp left join
[广东].[dbo].[周平均忙时流量0703]  on  [广东].[dbo].[周平均忙时流量0703].小区ID= temp.小区ID*/
(SELECT * FROM [广东].[dbo].[周平均忙时流量0703]) AS temp left join [容量].[dbo].[小区工参]
 ON [容量].[dbo].[小区工参] .小区ID= temp.小区ID

 /*
update [广东].dbo.总表temp set [地市] ='潮州' where 小区名称 like '%潮州%'
update [广东].dbo.总表temp set [地市] ='东莞' where 小区名称 like '%东莞%'
update [广东].dbo.总表temp set [地市] ='佛山' where 小区名称 like '%佛山%'
update [广东].dbo.总表temp set [地市] ='广州' where 小区名称 like '%广州%'
update [广东].dbo.总表temp set [地市] ='河源' where 小区名称 like '%河源%'
update [广东].dbo.总表temp set [地市] ='惠州' where 小区名称 like '%惠州%'
update [广东].dbo.总表temp set [地市] ='江门' where 小区名称 like '%江门%'
update [广东].dbo.总表temp set [地市] ='揭阳' where 小区名称 like '%揭阳%'
update [广东].dbo.总表temp set [地市] ='茂名' where 小区名称 like '%茂名%'
update [广东].dbo.总表temp set [地市] ='梅州' where 小区名称 like '%梅州%'
update [广东].dbo.总表temp set [地市] ='清远' where 小区名称 like '%清远%'
update [广东].dbo.总表temp set [地市] ='汕头' where 小区名称 like '%汕头%'
update [广东].dbo.总表temp set [地市] ='汕尾' where 小区名称 like '%汕尾%'
update [广东].dbo.总表temp set [地市] ='韶关' where 小区名称 like '%韶关%'
update [广东].dbo.总表temp set [地市] ='深圳' where 小区名称 like '%深圳%'
update [广东].dbo.总表temp set [地市] ='阳江' where 小区名称 like '%阳江%'
update [广东].dbo.总表temp set [地市] ='云浮' where 小区名称 like '%云浮%'
update [广东].dbo.总表temp set [地市] ='湛江' where 小区名称 like '%湛江%'
update [广东].dbo.总表temp set [地市] ='肇庆' where 小区名称 like '%肇庆%'
update [广东].dbo.总表temp set [地市] ='中山' where 小区名称 like '%中山%'
update [广东].dbo.总表temp set [地市] ='珠海' where 小区名称 like '%珠海%'
*/