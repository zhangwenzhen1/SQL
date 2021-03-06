/****** Script for SelectTopNRows command from SSMS  ******/
USE [容量]
SELECT[周平均忙时0627-0703].["地市"] as a
      ,[周平均忙时0627-0703].["小区ID"] as b
      ,[周平均忙时0627-0703].["小区名称"] as c
      ,[周平均忙时0627-0703].["覆盖场景"] as d
      ,[周平均忙时0627-0703].["频段"] as e
      ,[周平均忙时0627-0703].["载频个数"] as ww
      ,[周平均忙时0627-0703].["下行PRB平均利用率(v2 8)"] as ee
      ,[周平均忙时0627-0703].["上行PRB平均利用率(v2 8)"] as rr 
      ,[周平均忙时0627-0703].["PDCCH信道CCE占用率"] as tt
      ,[周平均忙时0627-0703].["下行业务信道流量(MB)"] as yy
      ,[周平均忙时0627-0703].["上行业务信道流量(MB)"] as ff
      ,[周平均忙时0627-0703].["E-RAB拥塞率(无线资源不足)"] as wwww
      ,[周平均忙时0627-0703].["上行日流量(MB)"] as qqq
      ,[周平均忙时0627-0703].["下行日流量(MB)"] as tttt
 into hhh FROM [容量].[dbo].[周平均忙时0627-0703] 
