/****** Script for SelectTopNRows command from SSMS  ******/
USE [容量]
/*select 地市,sum(日流量GB)from [容量].[dbo].[日流量]  group by 地市
/*rows.add(全省总流量)*/
select 地市,路测网格, count(*) from [容量].[dbo].[流量系数]  group by 地市,路测网格 order by 地市,路测网格*/

/*select 地市,路测网格, count(*) from [容量].[dbo].[流量系数] where 流量系数<=0.05  group by 地市,路测网格 order by 地市,路测网格*/
/*select 地市,路测网格, count(*) from [容量].[dbo].[流量系数] where 流量系数>5 group by 地市,路测网格 order by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数>0 and 流量系数<=0.05 group by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数=0  group by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数>0.05 and 流量系数<=0.2 group by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数>0.2 and 流量系数<=0.5 group by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数>0.5 and 流量系数<=1.5 group by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数>1.5 and 流量系数<=3 group by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数>3 and 流量系数<=5 group by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数>5 group by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数=0 group by 地市,路测网格 order by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数<=0.02 group by 地市,路测网格 order by 地市,路测网格*/
/*select 地市,路测网格, count(*) from [容量].[dbo].[流量系数]  group by 地市,路测网格 order by 地市,路测网格*/
/*select 地市,路测网格,count(*) from [容量].[dbo].[流量系数] where 流量系数>0.2 and 流量系数<=3 group by 地市,路测网格 order by 地市,路测网格*/

/*select 地市,路测网格,日流量GB,count(*) from [容量].[dbo].[流量系数] group by 地市,路测网格,日流量GB order by 地市,路测网格,日流量GB */
/*select 地市,路测网格, count(*) from [容量].[dbo].[流量系数]  group by 地市,路测网格 order by 地市,路测网格*/
/*select 地市,路测网格, count(*) from [容量].[dbo].[流量系数]  where 流量系数>3 group by 地市,路测网格 order by 地市,路测网格*/
/*select 地市,路测网格, count(*) from [容量].[dbo].[流量系数]  where 流量系数<=0.2 group by 地市,路测网格 order by 地市,路测网格*/
/*select 地市,路测网格, count(*) from [容量].[dbo].[流量系数]  where 流量系数>3 group by 地市,路测网格 order by 地市,路测网格*/

/*select 地市,网格,count(*) from [容量].[dbo].[流量系数1] where  流量系数<=0.2  and 流量系数<=3 group by 地市,网格*/
/*select 地市,网格,count(*) from [容量].[dbo].[流量系数1] where  流量系数>0.2 and 流量系数<=3   group by 地市,网格*/
/*select 网格,count(*) from [容量].[dbo].[流量系数1] where  流量系数>3 group by 网格*/
/*select 网格,count(*) from [容量].[dbo].[流量系数1] where  流量系数>0.2 and 流量系数<=3   group by 网格*/
/*select 网格,count(*) from [容量].[dbo].[流量系数1] where  流量系数<=0.2  group by 网格*/

/*select 地市,路测网格,日流量GB, count(*) from [容量].[dbo].[流量系数1] group by 地市,路测网格,日流量GB order by 地市,路测网格*/

/*select 地市,频段,载波带宽, count(*) from [容量].[dbo].[流量系数1] where  [RRC连接最大数]>=200 group by 地市,频段,载波带宽 order by 地市,频段*/
/*select 地市, count(*) from [容量].[dbo].[流量系数1] where  [RRC连接最大数]>=200 group by 地市 order by 地市*/
/*select 地市,sum(日流量GB)/count(*) as 单小区流量 into dxqll0703  from [容量].[dbo].[流量系数1] group by 地市*/
/*select 地市, count(*) from [容量].[dbo].[流量系数1] where  [最大利用率]>=0.5 group by 地市 order by 地市*/
/*select 地市, count(*) from [容量].[dbo].[流量系数1] where  [RRC连接最大数]>=200 group by 地市 order by 地市*/

/* select 地市, count(*) from [容量].[dbo].[高负荷]  group by 地市 order by 地市*/
/*update 流量系数1 set 路测网格='D' where 路测网格=''*/
 
  /*select 地市,日流量GB,路测网格 from 流量系数1 where 地市='深圳' and 路测网格='A' */
  /*select 地市,日流量GB,路测网格 from 流量系数1 where 地市='深圳' and 路测网格='C' */
   /*select 地市,日流量GB,路测网格 from 流量系数1 where 地市='深圳' and 路测网格!='C'and 路测网格!='A'and 路测网格!='D'*/
   /*select 地市,sum(日流量GB) as 流量,count(*) from [容量].[dbo].[流量系数1] where 路测网格!='C'and 路测网格!='A'and 路测网格!='D' group by 地市 order by 地市*/
   /*select[长期高负荷小区].[小区ID]
     ,[流量系数1].[地市]
	 ,[流量系数1].[RRC连接最大数]
	 ,[流量系数1].[频段]
     ,[流量系数1].[载波带宽]
	  into 高负荷1 from [长期高负荷小区],[流量系数1] where  [长期高负荷小区].[小区ID]=[流量系数1].[小区ID]*/


/*select 地市,[频段],[载波带宽], count(*) from [容量].[dbo].[高负荷1]  group by 地市,[频段],[载波带宽] order by 地市*/
/*select 地市, count(*) from [容量].[dbo].[高负荷1] where [频段]='F'and [载波带宽]=15.00 group by 地市 order by 地市*/
/*select 地市,日流量GB,路测网格 from 流量系数1 where 地市='深圳' and 路测网格='A'*/
/*select 地市,sum(日流量GB) as 流量,count(*) from [容量].[dbo].[流量系数1] where 路测网格!='C'and 路测网格!='A'and 路测网格!='D' group by 地市 order by 地市*/
/*select 地市,sum(日流量GB) as 流量,count(*) from [容量].[dbo].[流量系数1] where 路测网格='C'  group by 地市 order by 地市*/

/*select count(*) from [容量].[dbo].[流量系数1] where  流量系数<=0.2  */

/*select 地市,count(*) from [流量系数1] where 流量系数>0 group by 地市*/
/*select 地市,sum(日流量GB) from [流量系数1] group by 地市*/
/*select 地市, count(*) from [容量].[dbo].[流量系数1] where  流量系数<=0.05 group by 地市*/
/*select count(*) from [容量].[dbo].[流量系数1] where  流量系数>0.05 and 流量系数<=0.2*/
/*select 地市,sum(日流量GB)/count(*) as 单小区平均流量GB from [流量系数1] group by 地市*/
/*select 地市, count(*) from [容量].[dbo].[高负荷小区] where  [RRC连接最大数]>=150 group by 地市 order by 地市*/
select 网格,count(*) as '流量系数0.2<&<3' from [容量].[dbo].[流量系数1] where  流量系数>0.2 and 流量系数<3 group by 网格

select 小区ID,日流量GB from 容量.dbo.日流量 where 容量.dbo.日流量.小区ID='460-00-186669-12'

select * from KPI1415 where cgi in (select ecgi from 风景区)
