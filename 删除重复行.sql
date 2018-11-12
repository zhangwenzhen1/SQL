/****** Script for SelectTopNRows command from SSMS  ******/
/*USE 容量*/


/*select *,row_number() over(partition by [小区ID]order by [小区ID]) as id from [流量系数]*/
--注释：row_number() over(partition by s# order by s#) 
--按s#进行分组排序，row_number()表示s#相同情况下也进行排序
with ab as(
　　　　select * from
　　　　　　(select *,row_number() over(partition by [小区ID]order by [小区ID]) as id from 广东.[dbo].[周平均忙时0727-0802]) a
　　　　where id>1)
　　delete from ab