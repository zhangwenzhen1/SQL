----MR覆盖率----
create temp table temp0 as
select 
	CGI
	,RSRP_LT_F110
	,RSRP_COUNT
	,cast((RSRP_COUNT-RSRP_LT_F110)*1.0/RSRP_COUNT as numeric(10,4)) as MR覆盖率 
FROM rnodb.M_MRO_RSRP_ALL 
where STARTTIME='2018-09-18 00:00:00' and  RSRP_COUNT>'0'
DISTRIBUTED BY (CGI);

---峰值统计-
create temp table  temp1 as 
select 
	'2018-09-24'::date as starttime_date
	,CGI
	--,max(UL_PRBUSE_RATE) as 上行PRB平均利用率
	--,max(DL_PRBUSE_RATE) as 下行PRB平均利用率
	--,max(PDCCHCCEUTILRATIO) as PDCCH信道CCE占用率
	,max(cast((UPOCTUL/1024) as numeric(10,4))) as 上行峰值流量MB
	,max(cast((UPOCTDL/1024) as numeric(10,4))) as 下行峰值流量MB 
from sumdb.A_COMMON_PM_LTE_CELL_H 
where starttime>='2018-09-24 00:00:00' and starttime<'2018-09-26 00:00:00' 
group by CGI
DISTRIBUTED BY (CGI);

create temp table temp4 as
select 
	'2018-09-24'::date as starttime_date
	,CGI
	,max(UL_PRBUSE_RATE) as 上行PRB平均利用率1
	,max(DL_PRBUSE_RATE) as 下行PRB平均利用率1
	,max(PDCCHCCEUTILRATIO) as PDCCH信道CCE占用率1
from sumdb.A_COMMON_PM_LTE_CELL_H
where starttime>='2018-09-24 00:00:00' and starttime<'2018-09-25 00:00:00'
group by CGI
DISTRIBUTED BY (CGI);
   
---RRC用户数峰值统计---
create temp table temp2 as
select 
	'2018-09-24'::date as starttime_date
	,CGI
	,max(EFFECTIVECONNMAX) as 有效RRC连接最大数
from rnodb.M_PM_CELL 
where starttime>='2018-09-24 00:00:00' and starttime<'2018-09-26 00:00:00' 
group by CGI
DISTRIBUTED BY (CGI);
   
create temp table temp3 as
select 
	'2018-09-24'::date as starttime_date
	,CGI
	,avg(cast( ((UPOCTUL+UPOCTDL))/1024/1024 as numeric(10,4))) as 日均流量GB
	,avg(RADIO_SUCC_RATE) as 无线接通率
	,avg(RADIO_DROP_RATE) as 无线掉线率
	,avg(RADIO_SUCC_RATE_1)  as volte无线接通率
	,avg(ERAB_DROP_RATE_1) as volte无线掉话率
	,avg(LTE_2G_SUCC_RATE) as Srvcc切换成功率
from sumdb.A_COMMON_PM_LTE_CELL_D 
where starttime>='2018-09-24 00:00:00' and starttime<'2018-09-26 00:00:00' 
group by CGI
DISTRIBUTED BY (CGI);

create temp table temp5 as
select 
	'2018-09-24'::date as starttime_date
	,CGI
	,max(UL_PRBUSE_RATE) as 上行PRB平均利用率2
	,max(DL_PRBUSE_RATE) as 下行PRB平均利用率2
	,max(PDCCHCCEUTILRATIO) as PDCCH信道CCE占用率2
from sumdb.A_COMMON_PM_LTE_CELL_H
where starttime>='2018-09-25 00:00:00' and starttime<'2018-09-26 00:00:00'
group by CGI
DISTRIBUTED BY (CGI);


select 
	'2018-09-24'::date as starttime_date--日期
    ,a.CGI
    ,a.city--地市
    ,a.cell_name--小区名称
    ,b.MR覆盖率
    ,e.日均流量GB
    ,(f.上行PRB平均利用率1+g.上行PRB平均利用率2)*1.0/2 as 上行PRB平均利用率
	,(f.下行PRB平均利用率1+g.下行PRB平均利用率2)*1.0/2 as 下行PRB平均利用率
	,(f.PDCCH信道CCE占用率1+g.PDCCH信道CCE占用率2)*1.0/2 as PDCCH信道CCE占用率
	,d.有效RRC连接最大数
    ,c.上行峰值流量MB
    ,c.下行峰值流量MB 
    ,e.无线接通率
    ,e.无线掉线率
    ,e.volte无线接通率
    ,e.volte无线掉话率
    ,e.Srvcc切换成功率
	-- ,f.是否高负荷待扩容小区 
from sumdb.A_COMMON_PM_LTE_CELL_D a
left join  temp0 b on a.cgi = b.cgi
left join  temp1 c on a.cgi = c.cgi
left join  temp2 d on a.cgi = d.cgi 
left join  temp3 e on a.cgi = e.cgi
left join  temp4 f on a.cgi = f.cgi
left join  temp5 g on a.cgi = g.cgi
where starttime='2018-09-24 00:00:00'  