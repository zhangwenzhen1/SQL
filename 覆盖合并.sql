/****** Script for SelectTopNRows command from SSMS  ******/
USE 广东
  select* into 全省覆盖率07182 from
  (select * from[广东].[dbo].[sumdb.a_common_pm_lte201807181511_1] union all select * from[广东].[dbo].[sumdb.a_common_pm_lte201807181511_2]
  union all select * from [广东].[dbo].[sumdb.a_common_pm_lte201807181511_3] union all select * from[广东].[dbo].[sumdb.a_common_pm_lte201807181511_4]
  union all select * from [广东].[dbo].[sumdb.a_common_pm_lte201807181511_5])b

 