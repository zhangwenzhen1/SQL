USE [�㶫]
GO

select distinct ����,�������� into ҽԺ from [�㶫].dbo.[�羰���ܱ��ճ�] where ����='ҽԺ'order by ����
/* select ����,�������� into ҽԺ from [�㶫].dbo.[�羰���ܱ��ճ�] where ����='ҽԺ'order by ����*/
/*x��Ҫɾ����[�㶫].dbo.[ҽԺ]�е��ظ���*/
select temp.����
	   ,temp.�������� as ��������
	   ,temp.С����
	   ,temp1.MR������
	   ,temp2.[MR������<95%С����]
	   ,ltrim(cast((temp2.[MR������<95%С����]*1.0/temp.С����)* 100 as numeric(10,2) ))+'%' as 'MR������<95%С��ռ��'
	   ,temp3.�վ�����GB
	   ,temp3.��æʱ��ֵ������
	   ,temp5.[���߽�ͨ��(%)]
	   ,temp5.[���ߵ�����(%)]
	   ,temp5.VOLTE��ͨ��
	   ,temp5.VOLTE������
	   ,ltrim(cast((temp5.esrvcc�л�ռ��) as numeric(10,2)))+'%' as esrvcc�л�ռ��
	   ,temp4.�߸��ɴ�����С����
	   ,ltrim(cast((temp4.�߸��ɴ�����С����*1.0/temp.С����)* 100 as numeric(10,2) ))+'%' as '�߸��ɴ�����С��ռ��'
from
	(select  ����,��������,count(*) as С���� from [�㶫].dbo.[�羰���ܱ��ճ�] where ����='ҽԺ' group by ����,��������)AS temp
	 right join  [�㶫].dbo.[ҽԺ] on [�㶫].dbo.[ҽԺ].����=temp.���� and [�㶫].dbo.[ҽԺ].��������=temp.�������� left join
	 (select ����,��������,(1-sum([(�ƶ�)�����ǲ���������(С��-110)])/sum ([(�ƶ�)�ܲ�������]))as MR������ from [�㶫].dbo.[�羰���ܱ�1] where ����='ҽԺ' group by ����,��������) AS temp1
	  on [�㶫].dbo.[ҽԺ].����=temp1.���� and [�㶫].dbo.[ҽԺ].��������=temp1.�������� left join
	  (select ����,��������,count(*) as 'MR������<95%С����' from [�㶫].dbo.[�羰���ܱ�1]where ����='ҽԺ'and MR������<0.95 group by ����,��������)AS temp2 
	   on [�㶫].dbo.[ҽԺ].����=temp2.���� and [�㶫].dbo.[ҽԺ].��������=temp2.�������� left join
	   (select  ����,��������,sum([�վ�4G����(GB)]) as �վ�����GB,sum(���������)/count(*) as ��æʱ��ֵ������ from [�㶫].dbo.[�羰���ܱ��ճ�] where ����='ҽԺ' group by ����,��������)AS temp3
	   on [�㶫].dbo.[ҽԺ].����=temp3.���� and [�㶫].dbo.[ҽԺ].��������=temp3.�������� left join
	 (select  ����,��������,count(*) as �߸��ɴ�����С���� from [�㶫].dbo.[�羰���ܱ��ճ�] where ����='ҽԺ' and �Ƿ�߸��ɴ�����С��='��' group by ����,��������)AS temp4
	 on [�㶫].dbo.[ҽԺ].����=temp4.���� and [�㶫].dbo.[ҽԺ].��������=temp4.�������� left join
	 (select  ����,��������
	  ,sum([���߽�ͨ��(%)])/count(*) as [���߽�ͨ��(%)]
      ,sum([���ߵ�����(%)])/count(*) as [���ߵ�����(%)]
      ,sum([���߽�ͨ��(QCI 1)(%)])/count(*) as VOLTE��ͨ��
      ,sum([E-RAB������(QCI 1)(С����)(%)])/count(*) as VOLTE������
      ,sum([eSRVCC�л��ɹ���(%)] )/count(*) as esrvcc�л�ռ��
	  from [�㶫].dbo.[�羰���ܱ��ճ�] where ����='ҽԺ' group by ����,��������) as temp5
	  on [�㶫].dbo.[ҽԺ].����=temp5.���� and [�㶫].dbo.[ҽԺ].��������=temp5.�������� 


	
     