USE [广东]
GO

select 地市,sum(日流量GB) as A类网格流量,count(*) as A类网格小区数 into 地市网格流量情况1 from [广东].[dbo].[流量系数表] where 路测网格='A'  group by 地市 order by 地市


select  地市网格流量情况1.地市
		, ltrim(cast((地市网格流量情况1.A类网格流量)*1./(地市网格流量情况1.A类网格流量+temp.B类网格流量+temp1.C类网格流量)* 100 as numeric(10,0) ))+'%'as A类网格流量占比
		,ltrim(cast((temp.B类网格流量)*1./(地市网格流量情况1.A类网格流量+temp.B类网格流量+temp1.C类网格流量)* 100 as numeric(10,0) ))+'%'as B类网格流量占比
		,ltrim(cast((temp1.C类网格流量)*1./(地市网格流量情况1.A类网格流量+temp.B类网格流量+temp1.C类网格流量)* 100 as numeric(10,0) ))+'%'as C类网格流量占比
		,ltrim(cast((地市网格流量情况1.A类网格小区数)*1./(地市网格流量情况1.A类网格小区数+temp.B类网格小区数+temp1.C类网格小区数)* 100 as numeric(10,0) ))+'%'as A类网格小区数占比
		,ltrim(cast((temp.B类网格小区数)*1./(地市网格流量情况1.A类网格小区数+temp.B类网格小区数+temp1.C类网格小区数)* 100 as numeric(10,0) ))+'%'as B类网格小区数占比
		,ltrim(cast((temp1.C类网格小区数)*1./(地市网格流量情况1.A类网格小区数+temp.B类网格小区数+temp1.C类网格小区数)* 100 as numeric(10,0) ))+'%'as C类网格小区数占比
		,地市网格流量情况1.A类网格流量
		,地市网格流量情况1.A类网格小区数
		,temp.B类网格流量
		,temp.B类网格小区数
		,temp1.C类网格流量
		,temp1.C类网格小区数
into 地市网格流量情况 from 

(select 地市,sum(日流量GB) as B类网格流量,count(*) as B类网格小区数  from [广东].[dbo].[流量系数表] where 路测网格!='A' and 路测网格!='C'and 路测网格!='D' group by 地市) as temp 
left join 地市网格流量情况1 on 地市网格流量情况1.[地市]=temp.地市 left join
 
(select 地市,sum(日流量GB) as C类网格流量,count(*) as C类网格小区数  from [广东].[dbo].[流量系数表] where 路测网格='C'  group by 地市) as temp1
 on 地市网格流量情况1.[地市]=temp1.地市 
