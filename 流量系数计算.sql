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
      ,[日流量GB]
      ,[最大利用率]
      ,[流量系数]
  FROM [dbo].[流量系数1]
GO

update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/19.86 where 地市='广州'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/27.3  where 地市='深圳'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/28.15 where 地市='东莞'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/20.94 where 地市='佛山'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/22.46 where 地市='汕头'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/13.86 where 地市='珠海'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/24.87 where 地市='惠州'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/19.06 where 地市='中山'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/17.02 where 地市='江门'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/15.32 where 地市='湛江'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/14.49 where 地市='茂名'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/19.49 where 地市='揭阳'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/8.71 where 地市='韶关'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/11.86 where 地市='河源'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/11.43 where 地市='梅州'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/12.18 where 地市='汕尾'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/14.07 where 地市='阳江'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/14.69 where 地市='肇庆'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/13.01 where 地市='清远'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/12.05 where 地市='潮州'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/9.38 where 地市='云浮'