USE [广东]
GO
/*
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/19.919965 where 地市='广州'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/27.278668  where 地市='深圳'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/27.991009 where 地市='东莞'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/20.838103 where 地市='佛山'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/22.306201 where 地市='汕头'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/13.835432 where 地市='珠海'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/24.432080 where 地市='惠州'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/19.066558 where 地市='中山'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/17.048297 where 地市='江门'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/15.297221 where 地市='湛江'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/14.551410 where 地市='茂名'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/19.093644 where 地市='揭阳'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/8.643583 where 地市='韶关'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/11.800942 where 地市='河源'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/11.413319 where 地市='梅州'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/12.114130 where 地市='汕尾'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/14.232844 where 地市='阳江'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/14.670028 where 地市='肇庆'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/12.772101 where 地市='清远'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/12.028278 where 地市='潮州'
update  容量.[dbo].[流量系数1] set [流量系数]=日流量GB/10.007457where 地市='云浮'  */


/*update [业务均衡] set [系数小于等于0.05]= bb where [业务均衡].地市=(select 地市, count(*) as bb from [容量].[dbo].[流量系数1] where  流量系数<=0.05 group by 地市).地市*/
select 地市,sum(日流量GB)/count(*) as 单小区平均流量GB into 业务均衡 from [广东].[dbo].[流量系数表] group by 地市

select temp.地市
	,[业务均衡].[单小区平均流量GB]
	,ltrim(cast(([系数大于0.2小于等于0.5]+[系数大于0.5小于等于1.5]+[系数大于1.5小于等于3])*1./([系数小于等于0.05]+[系数大于0.05小于等于0.2]+[系数大于0.2小于等于0.5]+[系数大于0.5小于等于1.5]+[系数大于1.5小于等于3]+[系数大于3小于等于5]+[系数大于5] )* 100 as numeric(10,2) ))+'%'as 业务均衡比
	,[性能为空]
	,[系数小于等于0.05]
	,[系数大于0.05小于等于0.2]
	,[系数大于0.2小于等于0.5]
	,[系数大于0.5小于等于1.5]
	,[系数大于1.5小于等于3]
	,[系数大于3小于等于5]
	,[系数大于5]
	into 各地业务均衡比1 from 

(select 地市, count(*) as [系数小于等于0.05] from [广东].[dbo].[流量系数表] where  流量系数<=0.05 group by 地市) as temp 
left join [业务均衡] on [业务均衡].地市=temp.地市 left join
 
(select 地市, count(*) as [系数大于0.05小于等于0.2] from [广东].[dbo].[流量系数表] where  流量系数>0.05 and 流量系数<=0.2 group by 地市) as temp1
 on [业务均衡].地市=temp1.地市 left join
 (select 地市, count(*) as [系数大于0.2小于等于0.5] from [广东].[dbo].[流量系数表] where  流量系数>0.2 and 流量系数<=0.5 group by 地市) as temp2
 on [业务均衡].地市=temp2.地市 left join
 (select 地市, count(*) as [系数大于0.5小于等于1.5] from [广东].[dbo].[流量系数表] where  流量系数>0.5 and 流量系数<=1.5 group by 地市) as temp3
 on [业务均衡].地市=temp3.地市 left join
 (select 地市, count(*) as [系数大于1.5小于等于3] from [广东].[dbo].[流量系数表] where  流量系数>1.5 and 流量系数<=3 group by 地市) as temp4
 on [业务均衡].地市=temp4.地市 left join
 (select 地市, count(*) as [系数大于3小于等于5] from [广东].[dbo].[流量系数表] where  流量系数>3 and 流量系数<=5 group by 地市) as temp5
 on [业务均衡].地市=temp5.地市 left join
 (select 地市, count(*) as [系数大于5] from [广东].[dbo].[流量系数表] where  流量系数>5  group by 地市) as temp6
 on [业务均衡].地市=temp6.地市 left join
 (select 地市, count(*) as [性能为空] from [广东].[dbo].[流量系数表] where  流量系数 is NULL group by 地市) as temp0
 on [业务均衡].地市=temp0.地市 
 /*(select 地市,sum(日流量GB)/count(*) as 单小区平均流量GB from [流量系数1] group by 地市) as temp7
 on [业务均衡].地市=temp7.地市 */

 /*
 select  count(*) as [系数大于0.05小于等于0.2] from [广东].[dbo].[流量系数表] where  流量系数<0.05 
select  count(*) as [系数大于0.05小于等于0.2] from [广东].[dbo].[流量系数表] where  流量系数>0.05 and 流量系数<=0.2 
select  count(*) as [系数大于0.05小于等于0.2] from [广东].[dbo].[流量系数表] where  流量系数>0.2 and 流量系数<=0.5 
select  count(*) as [系数大于0.05小于等于0.2] from [广东].[dbo].[流量系数表] where  流量系数>0.5 and 流量系数<=1.5 
select  count(*) as [系数大于0.05小于等于0.2] from [广东].[dbo].[流量系数表] where  流量系数>1.5 and 流量系数<=3 
select  count(*) as [系数大于0.05小于等于0.2] from [广东].[dbo].[流量系数表] where  流量系数>3 and 流量系数<=5
select  count(*) as [系数大于0.05小于等于0.2] from [广东].[dbo].[流量系数表] where  流量系数>5 
 */
		