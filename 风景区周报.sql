USE [广东]
GO

/*
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
SELECT [地市]
      ,[小区中文名]
      ,CGI
      ,[场景]
      ,[景区名称]
  FROM [dbo].[风景区周报]
  */
SELECT   [广东].dbo.全省覆盖率 .日期
		,TEMP.地市
		,TEMP.景区名称
		,TEMP.小区中文名
		,TEMP.CGI
		,TEMP4.场景
		,[广东].dbo.全省覆盖率.MR覆盖率
		,TEMP1.[日均4G流量(GB)]
		,TEMP1.日峰值上行利用率
		,TEMP1.[上行利用率峰值时段流量(上行流量MB)]
		,TEMP1.日峰值下行利用率
		,TEMP1.[下行利用率峰值时段流量(下行流量MB)]
		,TEMP1.PDCCH信道CCE日峰值利用率
		,TEMP1.RRC连接最大数
		,TEMP2.[无线接通率(%)]
		,TEMP2.[无线掉线率(%)]
		,TEMP2.[无线接通率(QCI 1)(%)]
		,TEMP2.[E-RAB掉线率(QCI 1)(小区级)(%)]
		,TEMP2.[eSRVCC切换成功率(%)]
		,TEMP3.是否高负荷待扩容小区
		,TEMP1.最大利用率
 INTO　风景区周报日常　FROM
     (SELECT * FROM [广东].dbo.风景区周报 ) AS TEMP  LEFT JOIN [广东].dbo.全省覆盖率  ON [广东].dbo.全省覆盖率.CGI=TEMP.CGI  
	/*(SELECT CGI,MR覆盖率 FROM [广东].dbo.全省覆盖率)    AS TEMP RIGHT JOIN [广东].dbo.风景区周报 
	 ON [广东].dbo.风景区周报.CGI=TEMP.CGI*/  LEFT JOIN
	 (SELECT 小区ID
			,日流量GB as '日均4G流量(GB)'
			,[上行PRB平均利用率(v2 8)] as 日峰值上行利用率
			,[上行日流量(MB)] as '上行利用率峰值时段流量(上行流量MB)'
			,[下行PRB平均利用率(v2 8)] as 日峰值下行利用率 
			,[下行日流量(MB)]as '下行利用率峰值时段流量(下行流量MB)'
			,[PDCCH信道CCE占用率] as PDCCH信道CCE日峰值利用率
			,[有效RRC连接最大数] as [RRC连接最大数]
			,[下行日流量(MB)]
			,[最大利用率]
		FROM [广东].dbo.[流量系数总表]) AS TEMP1 
	 ON  [广东].dbo.全省覆盖率.CGI=TEMP1.小区ID   LEFT JOIN
	 (SELECT [CGI]
			 ,[无线接通率(%)]
			 ,[无线掉线率(%)]
			 ,[无线接通率(QCI 1)(%)]
			 ,[E-RAB掉线率(QCI 1)(小区级)(%)]
			 ,[eSRVCC切换成功率(%)]
			 FROM [广东].dbo.[风景区KPI]) AS TEMP2 
	 ON [广东].dbo.全省覆盖率.CGI=TEMP2.CGI  LEFT JOIN
	 (SELECT  [小区ID] as 是否高负荷待扩容小区 FROM [容量].[dbo].[长期高负荷小区]) AS TEMP3
	  ON [广东].dbo.全省覆盖率.CGI=TEMP3.[是否高负荷待扩容小区]   LEFT JOIN
	  (SELECT * FROM [广东].[dbo].[重要场景清单汇总]) AS TEMP4
	  ON [广东].dbo.全省覆盖率.CGI=TEMP4.[CGI]  
	 
	update[广东].dbo.风景区周报日常 set [是否高负荷待扩容小区] ='是' where [是否高负荷待扩容小区] is NOT NULL
	update[广东].dbo.风景区周报日常 set [是否高负荷待扩容小区] ='否' where [是否高负荷待扩容小区] is NULL
	/*delete from [广东].dbo.风景区周报日常 where 日期 IS NULL*/

	