USE [容量]
GO
 select * 
into 小区工参 from(
  SELECT[地市],[小区名称],[小区ID],[网格],[路测网格]FROM [容量].[dbo].[小区工参1]union all SELECT 
  [地市],[小区名称],[小区ID],[网格],[路测网格] 
  FROM [dbo].[小区工参2]
  )b
	
GO


