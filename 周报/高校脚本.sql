
select '2018-06-20' ::date as      starttime_date--����
	   ,sumdb.A_COMMON_PM_LTE_CELL_D.CGI
	   ,sumdb.A_COMMON_PM_LTE_CELL_D.city--����
	   ,sumdb.A_COMMON_PM_LTE_CELL_D.cell_name--С������
	   --,temp.MR������
	   ,temp3.�վ�����GB
	   ,temp1.����PRBƽ��������
	   ,temp1.����PRBƽ��������
	   ,temp1. PDCCH�ŵ�CCEռ����
	   ,temp2.��ЧRRC���������
	   ,temp1.���з�ֵ����MB
	   ,temp1.���з�ֵ����MB 
	   ,temp3.���߽�ͨ��
	   ,temp3.���ߵ�����
	   ,temp3.volte���߽�ͨ��
	   ,temp3.volte���ߵ�����
	   ,temp3.Srvcc�л��ɹ���
	  -- ,temp4.�Ƿ�߸��ɴ�����С�� 
  from
----MR������----
/*( select CGI
		,RSRP_LT_F110
		,RSRP_COUNT
		,cast((RSRP_COUNT-RSRP_LT_F110)*1./RSRP_COUNT as numeric(10,4)) as MR������ 
		FROM rnodb.M_MRO_RSRP_ALL 
		where STARTTIME='2018-06-16 00:00:00' and  RSRP_COUNT>'0' 
 ) as temp right join sumdb.A_COMMON_PM_LTE_CELL_D
   on sumdb.A_COMMON_PM_LTE_CELL_D.CGI=temp.CGI  left join
*/
   ---��ֵͳ��-
    (select '2018-06-20' ::date as      starttime_date
			,CGI
			,avg(UL_PRBUSE_RATE) as ����PRBƽ��������
			,avg(DL_PRBUSE_RATE) as ����PRBƽ��������
			,avg(PDCCHCCEUTILRATIO) as PDCCH�ŵ�CCEռ����
			,avg(cast((UPOCTUL/1024) as numeric(10,4))) as ���з�ֵ����MB
			,avg(cast((UPOCTDL/1024) as numeric(10,4))) as ���з�ֵ����MB 
        from sumdb.A_COMMON_PM_LTE_CELL_H 
		where starttime>='2018-06-14 00:00:00' and starttime<'2018-06-21 00:00:00'
		group by CGI) as temp1  right join sumdb.A_COMMON_PM_LTE_CELL_D
		on  sumdb.A_COMMON_PM_LTE_CELL_D.CGI=temp1.CGI left join
	
     ---RRC�û�����ֵͳ��---
	(select 
			'2018-06-20' ::date as      starttime_date
			,CGI
			,avg(EFFECTIVECONNMAX) as ��ЧRRC���������
			from rnodb.M_PM_CELL 
			where starttime>='2018-06-14 00:00:00' and starttime<'2018-06-21 00:00:00'
			group by CGI) as temp2 on  sumdb.A_COMMON_PM_LTE_CELL_D.CGI=temp2.CGI left join
	 ------
	 (select 
			'2018-06-20' ::date as      starttime_date
			,CGI
			,avg(cast(((UPOCTUL+UPOCTDL))/1024/1024 as numeric(10,4))) as �վ�����GB
			,avg(RADIO_SUCC_RATE) as ���߽�ͨ��
			,avg(RADIO_DROP_RATE) as ���ߵ�����
			,avg(RADIO_SUCC_RATE_1)  as volte���߽�ͨ��
			,avg(ERAB_DROP_RATE_1) as volte���ߵ�����
			,avg(LTE_2G_SUCC_RATE) as Srvcc�л��ɹ���
			from sumdb.A_COMMON_PM_LTE_CELL_D 
			where  starttime>='2018-06-14 00:00:00' and starttime<'2018-06-21 00:00:00'
			group by CGI) as temp3 on  sumdb.A_COMMON_PM_LTE_CELL_D.CGI=temp3.CGI 