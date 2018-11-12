USE [容量]
GO

SELECT [地市]
      ,[小区ID]
      ,[小区名称]
      ,[网格]
      ,[路测网格]
      ,[覆盖场景]
      ,[频段]
      ,[载波带宽]
      ,[RRC连接最大数]
      ,[下行PRB平均利用率(v2 8)]
      ,[上行PRB平均利用率(v2 8)]
      ,[PDCCH信道CCE占用率]
      ,[上行日流量(MB)]
      ,[下行日流量(MB)]
	  ,round(([上行日流量(MB)]+[下行日流量(MB)])/1024,2)as 日流量GB
	  ,iif([上行PRB平均利用率(v2 8)] >[下行PRB平均利用率(v2 8)]and[上行PRB平均利用率(v2 8)]>[PDCCH信道CCE占用率],[上行PRB平均利用率(v2 8)],iif([下行PRB平均利用率(v2 8)]>[PDCCH信道CCE占用率],[下行PRB平均利用率(v2 8)],[PDCCH信道CCE占用率])) as 最大利用率
	  /*,sum(round(([上行日流量(MB)]+[下行日流量(MB)])/1024,2))/count([小区ID])*/
 into 日流量 FROM [dbo].[ccc]
GO


