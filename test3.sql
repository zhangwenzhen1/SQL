/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [日期]
      ,[地市]
      ,[景区名称]
      ,[小区中文名]
      ,[CGI]
      ,[场景]
      ,[MR覆盖率]
      ,[日均4G流量(GB)]
      ,[日峰值上行利用率]
      ,[上行利用率峰值时段流量(上行流量MB)]
      ,[日峰值下行利用率]
      ,[下行利用率峰值时段流量(下行流量MB)]
      ,[PDCCH信道CCE日峰值利用率]
      ,[RRC连接最大数]
      ,[无线接通率(%)]
      ,[无线掉线率(%)]
      ,[无线接通率(QCI 1)(%)]
      ,[E-RAB掉线率(QCI 1)(小区级)(%)]
      ,[eSRVCC切换成功率(%)]
      ,[是否高负荷待扩容小区]
      ,[最大利用率]
  FROM [广东].[dbo].[风景区周报日常]

  SELECT  [地市],场景,count(*) as 小区数, AVG ([无线掉线率(%)])
      				  
 			FROM [广东].[dbo].[风景区周报日常] group by 地市,场景 order by 地市,场景

  SELECT count( distinct[地市])
 			FROM [广东].[dbo].[风景区周报]  

SELECT  [地市],count(*) as 小区数
      				  
 			FROM [广东].[dbo].[风景区周报] group by 地市 order by 地市 

update [广东].dbo.风景区周报 set [地市] ='潮州' where 地市 like '%潮州%'
update [广东].dbo.风景区周报 set [地市] ='东莞' where 地市 like '%东莞%'
update [广东].dbo.风景区周报 set [地市] ='佛山' where 地市 like '%佛山%'
update [广东].dbo.风景区周报 set [地市] ='广州' where 地市 like '%广州%'
update [广东].dbo.风景区周报 set [地市] ='河源' where 地市 like '%河源%'
update [广东].dbo.风景区周报 set [地市] ='惠州' where 地市 like '%惠州%'
update [广东].dbo.风景区周报 set [地市] ='江门' where 地市 like '%江门%'
update [广东].dbo.风景区周报 set [地市] ='揭阳' where 地市 like '%揭阳%'
update [广东].dbo.风景区周报 set [地市] ='茂名' where 地市 like '%茂名%'
update [广东].dbo.风景区周报 set [地市] ='梅州' where 地市 like '%梅州%'
update [广东].dbo.风景区周报 set [地市] ='清远' where 地市 like '%清远%'
update [广东].dbo.风景区周报 set [地市] ='汕头' where 地市 like '%汕头%'
update [广东].dbo.风景区周报 set [地市] ='汕尾' where 地市 like '%汕尾%'
update [广东].dbo.风景区周报 set [地市] ='韶关' where 地市 like '%韶关%'
update [广东].dbo.风景区周报 set [地市] ='深圳' where 地市 like '%深圳%'
update [广东].dbo.风景区周报 set [地市] ='阳江' where 地市 like '%阳江%'
update [广东].dbo.风景区周报 set [地市] ='云浮' where 地市 like '%云浮%'
update [广东].dbo.风景区周报 set [地市] ='湛江' where 地市 like '%湛江%'
update [广东].dbo.风景区周报 set [地市] ='肇庆' where 地市 like '%肇庆%'
update [广东].dbo.风景区周报 set [地市] ='中山' where 地市 like '%中山%'
update [广东].dbo.风景区周报 set [地市] ='珠海' where 地市 like '%珠海%'


select  地市,景区名称,sum([日均4G流量(GB)]) as 日均流量,sum(最大利用率)/count(*) as 自忙时峰值利用率 from [广东].dbo.[风景区周报日常] where 场景='高铁' group by 地市,景区名称 having (sum([日均4G流量(GB)])>15)


SELECT  [地市],场景,count(*) as 小区数, AVG ([无线掉线率(%)])
      				  
 			FROM [广东].[dbo].[风景区周报日常]  where 地市 in ('广州','深圳') group by 地市,场景 order by 地市,场景



SELECT 场景, [广东].dbo.全省覆盖率.小区名,小区中文名 FROM [广东].dbo.风景区周报   JOIN [广东].dbo.全省覆盖率  ON [广东].dbo.全省覆盖率.CGI=[广东].dbo.风景区周报.CGI  


SELECT * FROM [广东].dbo.风景区周报  LEFT JOIN [广东].dbo.全省覆盖率  ON [广东].dbo.全省覆盖率.CGI=[广东].dbo.风景区周报.CGI  