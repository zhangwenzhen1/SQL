USE [����]
GO


/*insert into dbo.[0627] select [С������].[·������] from [С������] where  [С������].[С��ID]= [0627].[С��ID] */

SELECT
       [0627].[����]  
      ,[0627].[С��ID] 
      ,[0627].[С������] 
      ,[0627].[���ǳ���] 
      ,[0627].[Ƶ��]     
      ,[0627].[����PRBƽ��������(v2 8)] 
      ,[0627].[����PRBƽ��������(v2 8)] 
      ,[0627].[PDCCH�ŵ�CCEռ����]  
      ,[0627].[����������(MB)]      
      ,[0627].[����������(MB)]  
	  ,[С������].[·������]
 into ddd FROM dbo.[0627] INNER join [С������] on [С������].[С��ID]= [0627].[С��ID] 
GO

/*SELECT c1.CategoryID, c1.CategoryName
FROM [dbo].[Category] c1 INNER JOIN [dbo].[Category] c2
ON c1.[CategoryID] = c2.[ParentID]*/
