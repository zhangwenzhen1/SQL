USE [广东]

select 网格,count(*) as '流量系数0.2<&<3' into 网格业务均衡比 from [广东].[dbo].[流量系数表] where  流量系数>0.2 and 流量系数<3 group by 网格

select  网格业务均衡比.网格
		,(网格业务均衡比.[流量系数0.2<&<3]+temp.[流量系数>3]+temp1.[流量系数<=0.2&无性能小区])as 总小区数
		,网格业务均衡比.[流量系数0.2<&<3]
		,ltrim(cast((网格业务均衡比.[流量系数0.2<&<3])*1./(网格业务均衡比.[流量系数0.2<&<3]+temp.[流量系数>3]+temp1.[流量系数<=0.2&无性能小区])* 100 as numeric(10,2) ))+'%'as 业务均衡比
		,temp.[流量系数>3]
		,ltrim(cast((temp.[流量系数>3])*1./(网格业务均衡比.[流量系数0.2<&<3]+temp.[流量系数>3]+temp1.[流量系数<=0.2&无性能小区])* 100 as numeric(10,2) ))+'%'as '流量系数>3占比'
		,temp1.[流量系数<=0.2&无性能小区]
		,ltrim(cast((temp1.[流量系数<=0.2&无性能小区])*1./(网格业务均衡比.[流量系数0.2<&<3]+temp.[流量系数>3]+temp1.[流量系数<=0.2&无性能小区])* 100 as numeric(10,2) ))+'%'as '流量系数<=0.2&无性能小区占比'	
 into 网格业务均衡比3  from 

(select 网格,count(*) as '流量系数>3'  from [广东].[dbo].[流量系数表] where  流量系数>3 group by 网格) as temp 
left join 网格业务均衡比 on 网格业务均衡比.[网格]=temp.网格 left join
 
(select 网格,count(*) as '流量系数<=0.2&无性能小区'  from [广东].[dbo].[流量系数表] where  流量系数<=0.2 or 流量系数 is NULL group by 网格) as temp1
 on  网格业务均衡比.[网格]=temp1.网格

 