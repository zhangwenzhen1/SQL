/****** Script for SelectTopNRows command from SSMS  ******/
with s as 
(
	select		       
		m.starttime::date as starttime_date,--自忙时日期
		m.starttime,--自忙时时间
		m.cgi,
		m.UL_PRBUSE_RATE,---自忙时-日峰值上行利用率（%）
		m.DL_PRBUSE_RATE,---自忙时-日峰值下行利用率（%）			   
		m.PDCCHCCEUTILRATIO,---自忙时-PDCCH信道CCE日峰值利用率（%）
		h.EFFECTIVECONNMAX,---自忙时-有效RRC连接最大数（个）
		case when m.NBRSUCCESTAB=0 then null else  (m.UPOCTDL + m.UPOCTUL)*1.0 / m.NBRSUCCESTAB end  as ERAB_FLOW_BUSY,---自忙时E-RAB流量（KB） 
		(m.UPOCTDL + m.UPOCTUL) as  PEAK_FLOW_BUSY,---自忙时-日峰值流量（GB)			   			   	   
		h.CONNMAX,---自忙时-RRC连接
		
		最大数（个）
		row_number() over(partition by m.cgi order by greatest(m.DL_PRBUSE_RATE,m.UL_PRBUSE_RATE,m.PDCCHCCEUTILRATIO) desc) as rank
	from sumdb.A_COMMON_PM_LTE_CELL_H m  ---限定时间
	left join rnodb.M_PM_CELL h on h.cgi=m.cgi and h.starttime=m.starttime
	where m.starttime>='2018-06-10 00:00:00' and m.starttime<'2018-06-11 00:00:00' ---时间可根据实际情况修改，此处填的是一天的时间
	and greatest(m.DL_PRBUSE_RATE,m.UL_PRBUSE_RATE,m.PDCCHCCEUTILRATIO)  is not null
),
s2 as
(
	select 
		starttime::date as starttime_date,
		cgi,		
		UPOCTUL,		
		row_number() over(partition by cgi order by UL_PRBUSE_RATE desc) as rank
	from sumdb.A_COMMON_PM_LTE_CELL_H 
	where starttime>='2018-06-10 00:00:00' and starttime<'2018-06-11 00:00:00' ---时间可根据实际情况修改，但需与上面时间一致
	and UL_PRBUSE_RATE is not null
),
s3 as
(
	select 
		starttime::date as starttime_date,
		cgi,
		UPOCTDL,				
		row_number() over(partition by cgi order by DL_PRBUSE_RATE desc) as rank		
	from sumdb.A_COMMON_PM_LTE_CELL_H 
	where starttime>='2018-06-10 00:00:00' and starttime<'2018-06-11 00:00:00' ---时间可根据实际情况修改，但需与上面时间一致
	and DL_PRBUSE_RATE is not null 
)
select 
	a.starttime,--日期
	b.city,--地市
	b.cell_name,--小区名称
	b.ECGI,
	b.STATE,--站点状态
	b.GRID_ROAD,---路测网格
	case when c.RSRP_COUNT=0 then null else (c.RSRP_COUNT - c.RSRP_LT_F110)*1.0/c.RSRP_COUNT end as MR_COVERAGE,---MR覆盖率
	d.UPOCTDL + d.UPOCTUL as D_4G_FLOW,	---日4G流量（GB）
	s.UL_PRBUSE_RATE,---自忙时-日峰值上行利用率（%）
	s.DL_PRBUSE_RATE, 	---自忙时-日峰值下行利用率（%）
	s.PDCCHCCEUTILRATIO,---自忙时-PDCCH信道CCE日峰值利用率（%）
	s.EFFECTIVECONNMAX,---自忙时-有效RRC连接最大数（个）
	a.RADIO_SUCC_RATE,---无线接通率（%）
	a.RADIO_DROP_RATE_CELL,---无线掉线率（%）
	a.RADIO_SUCC_RATE_1,---volte无线接通率（%）
	a.ERAB_DROP_RATE_1,---volte无线掉话率（%）
	a.LTE_2G_SUCC_RATE,---Srvcc切换成功率（%）
	s.ERAB_FLOW_BUSY,---自忙时E-RAB流量（KB）
	s.PEAK_FLOW_BUSY,---自忙时-日峰值流量（GB)
	(a.UPOCTDL + a.UPOCTUL)  as VOLTE_FLOW,---日VoLTE流量（GB)
	s.CONNMAX,---自忙时-RRC连接最大数（个）
	d.EFFECTIVECONNMEAN,---RRC连接平均数（个）
	s2.UPOCTUL,---上行利用率峰值时段流量（上行流量MB）
	s3.UPOCTDL---下行利用率峰值时段流量（下行流量MB）
from sumdb.A_COMMON_PM_LTE_CELL_D a  ---主表
left join rnodb.DIM_CFG_Cell b  on b.cgi=a.cgi and eff_from_date<=a.starttime and eff_to_date > a.starttime
left join rnodb.M_MRO_RSRP_ALL c on c.cgi=a.cgi and c.starttime=a.starttime
left join sumdb.SUM_PM_CELL_D d on d.cgi=a.cgi and d.starttime=a.starttime
left join s on s.cgi=a.cgi and s.starttime_date=a.starttime and s.rank=1
left join s2 on s2.cgi=a.cgi and s2.starttime_date=a.starttime and s2.rank=1
left join s3 on s3.cgi=a.cgi and s3.starttime_date=a.starttime and s3.rank=1
where a.starttime>='2018-06-10 00:00:00' and a.starttime<'2018-06-11 00:00:00' ---时间可根据实际情况修改，但需与上面时间一致