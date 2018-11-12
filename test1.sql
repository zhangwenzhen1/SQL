USE [容量]
GO


/*insert into dbo.[0627] select [小区工参].[路测网格] from [小区工参] where  [小区工参].[小区ID]= [0627].[小区ID] */

SELECT
       [0627].[地市]  
      ,[0627].[小区ID] 
      ,[0627].[小区名称] 
      ,[0627].[覆盖场景] 
      ,[0627].[频段]     
      ,[0627].[下行PRB平均利用率(v2 8)] 
      ,[0627].[上行PRB平均利用率(v2 8)] 
      ,[0627].[PDCCH信道CCE占用率]  
      ,[0627].[上行日流量(MB)]      
      ,[0627].[下行日流量(MB)]  
	  ,[小区工参].[路测网格]
 into ddd FROM dbo.[0627] INNER join [小区工参] on [小区工参].[小区ID]= [0627].[小区ID] 
GO

/*SELECT c1.CategoryID, c1.CategoryName
FROM [dbo].[Category] c1 INNER JOIN [dbo].[Category] c2
ON c1.[CategoryID] = c2.[ParentID]*/
