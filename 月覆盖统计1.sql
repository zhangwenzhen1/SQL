USE [�㶫]


  select ����,���� as ���� ,count(*) as С���� into ������ͳ�Ʊ� from [�㶫].[dbo].[�羰���ܱ��ճ�] group by ����,���� order by ����



  select 
   ������ͳ�Ʊ�.����
		,������ͳ�Ʊ�.����
		,������ͳ�Ʊ�.С����
		,temp.MR������
		,temp1.[MR������<95%С����]
		,ltrim(cast((temp1.[MR������<95%С����]*1.0/������ͳ�Ʊ�.С����)* 100 as numeric(10,2) ))+'%' as 'MR������<95%С��ռ��'
		,temp2.�վ�����GB
		,temp2.��æʱ��ֵ������
		,temp2.���߽�ͨ��
		,temp2.���ߵ�����
		,temp3.�߸��ɴ�����С����
		,ltrim(cast((temp3.�߸��ɴ�����С����*1./������ͳ�Ʊ�.С����)* 100 as numeric(10,2) ))+'%' as �߸��ɴ�����С��ռ��
		,temp2.VOLTE��ͨ�� 
		,temp2.VOLTE������
		,ltrim(temp2. esrvcc�л�ռ��)+'%' as esrvcc�л�ռ��
  from
  (select ����,����,(1-sum([(�ƶ�)�����ǲ���������(С��-110)])/sum ([(�ƶ�)�ܲ�������]))as MR������ from [�㶫].[dbo].[�羰���ܱ�1] group by ����,���� ) as temp
  right join ������ͳ�Ʊ� on ������ͳ�Ʊ�.����=temp.���� and ������ͳ�Ʊ�.����=temp.����  left join
  (select ����,����,count(*) as 'MR������<95%С����' from [�㶫].[dbo].[�羰���ܱ��ճ�] where MR������<0.95 group by ����,����  )as temp1
   on ������ͳ�Ʊ�.����=temp1.���� and ������ͳ�Ʊ�.����=temp1.����  left join
  (select ����
		  ,����
		  ,sum([�վ�4G����(GB)])/count(*) as �վ�����GB
		  ,sum(���������)/count(*) as ��æʱ��ֵ������
		  ,sum([���߽�ͨ��(%)])/count(*) as ���߽�ͨ�� 
		  ,sum([���ߵ�����(%)])/count(*) as ���ߵ�����
		  ,sum([���߽�ͨ��(QCI 1)(%)] )/count(*) as VOLTE��ͨ��
		  ,sum([E-RAB������(QCI 1)(С����)(%)])/count(*)  as VOLTE������
		  ,sum ([eSRVCC�л��ɹ���(%)])/count(*) as esrvcc�л�ռ��
		  from [�㶫].[dbo].[�羰���ܱ��ճ�] group by ����,����) as temp2
   on ������ͳ�Ʊ�.����=temp2.���� and ������ͳ�Ʊ�.����=temp2.����   left join 
  (select ����,����,count(*)as �߸��ɴ�����С����
   from [�㶫].[dbo].[�羰���ܱ��ճ�] where [�Ƿ�߸��ɴ�����С��]='��' group by ����,����)as temp3
  on ������ͳ�Ʊ�.����=temp3.���� and ������ͳ�Ʊ�.����=temp3.����  



 
   DELETE FROM [�㶫].[dbo].[�±�����] WHERE ���� is NULL

   /*
 select ����,����,count(*) as 'MR������<95%С����' from [�㶫].[dbo].[�羰���ܱ�1] where MR������<0.95 and ����='����'group by ����,���� 

 select ����,���� ,count(*) as С����  from [�㶫].[dbo].[�羰���ܱ�1]where  ����='����' group by ����,���� order by ����

 */
