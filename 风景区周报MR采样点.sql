USE [广东]
GO



select [地市]
      ,[小区中文名]
      ,[广东].[dbo].[风景区周报].[CGI]
      ,[场景]
      ,[景区名称]
	  ,TEMP.[(移动)总采样点数]
	  ,TEMP.[(移动)弱覆盖采样点数量(小于-110)]
	  ,TEMP.MR覆盖率
INTO 风景区周报1 from

 (SELECT [(移动)总采样点数],[(移动)弱覆盖采样点数量(小于-110)],CGI,MR覆盖率 FROM [广东].[dbo].[全省覆盖率])AS TEMP right join 
 [广东].[dbo].[风景区周报] ON  [广东].[dbo].[风景区周报].CGI=TEMP.CGI


 update [广东].dbo.风景区周报1 set [地市] ='潮州' where 地市 like '%潮州%'
update [广东].dbo.风景区周报1 set [地市] ='东莞' where 地市 like '%东莞%'
update [广东].dbo.风景区周报1 set [地市] ='佛山' where 地市 like '%佛山%'
update [广东].dbo.风景区周报1 set [地市] ='广州' where 地市 like '%广州%'
update [广东].dbo.风景区周报1 set [地市] ='河源' where 地市 like '%河源%'
update [广东].dbo.风景区周报1 set [地市] ='惠州' where 地市 like '%惠州%'
update [广东].dbo.风景区周报1 set [地市] ='江门' where 地市 like '%江门%'
update [广东].dbo.风景区周报1 set [地市] ='揭阳' where 地市 like '%揭阳%'
update [广东].dbo.风景区周报1 set [地市] ='茂名' where 地市 like '%茂名%'
update [广东].dbo.风景区周报1 set [地市] ='梅州' where 地市 like '%梅州%'
update [广东].dbo.风景区周报1 set [地市] ='清远' where 地市 like '%清远%'
update [广东].dbo.风景区周报1 set [地市] ='汕头' where 地市 like '%汕头%'
update [广东].dbo.风景区周报1 set [地市] ='汕尾' where 地市 like '%汕尾%'
update [广东].dbo.风景区周报1 set [地市] ='韶关' where 地市 like '%韶关%'
update [广东].dbo.风景区周报1 set [地市] ='深圳' where 地市 like '%深圳%'
update [广东].dbo.风景区周报1 set [地市] ='阳江' where 地市 like '%阳江%'
update [广东].dbo.风景区周报1 set [地市] ='云浮' where 地市 like '%云浮%'
update [广东].dbo.风景区周报1 set [地市] ='湛江' where 地市 like '%湛江%'
update [广东].dbo.风景区周报1 set [地市] ='肇庆' where 地市 like '%肇庆%'
update [广东].dbo.风景区周报1 set [地市] ='中山' where 地市 like '%中山%'
update [广东].dbo.风景区周报1 set [地市] ='珠海' where 地市 like '%珠海%'