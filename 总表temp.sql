USE [�㶫]
GO



SELECT temp.[ʡ��]
      ,temp.[����]
      ,temp.[С��ID]
      ,temp.[С������]
	  ,[����].[dbo].[С������] .����
	  ,[����].[dbo].[С������] .·������
      ,temp.[��վID]
      ,temp.[��վ����]
      ,temp.[���豸����]
      ,temp.[�������վ����]
      ,temp.[��������]
      ,temp.[���ǳ���]
      ,temp.[Ƶ��]
      ,temp.[��Ƶ����]
      ,temp.[�ز�����(MHZ)]
      ,temp.[����]
      ,temp.[γ��]
      ,temp.[��λ��]
      ,temp.[�Ƿ������������ݹ���]
      ,temp.[�Ƿ�����С��]
      ,temp.[����Ƶ��С��]
      ,temp.[��Ӧ�Ļ���Ƶ��С��ID]
      ,temp.[��ЧRRC����ƽ����]
      ,temp.[��ЧRRC���������]
      ,temp.[RRC����ƽ����]
      ,temp.[RRC���������]
      ,temp.[����PDSCH PRBռ��ƽ����]
      ,temp.[����PDSCH PRB����ƽ����]
      ,temp.[����PDSCH PRBռ��ƽ����]
      ,temp.[����PDSCH PRB����ƽ����]
      ,temp.[PDCCH�ŵ�CCE���ø���]
      ,temp.[PDCCH�ŵ�CCEռ�ø���]
      ,temp.[����PRBƽ��������(v2 6)]
      ,temp.[����PRBƽ��������(v2 6)]
      ,temp.[����PDSCH PRBռ����]
      ,temp.[����PDSCH PRB������]
      ,temp.[����PDSCH PRBռ����]
      ,temp.[����PDSCH PRB������]
      ,temp.[����PRBƽ��������(v2 8)]
      ,temp.[����PRBƽ��������(v2 8)]
      ,temp.[PDCCH�ŵ�CCEռ����]
      ,temp.[����ҵ���ŵ�����(MB)]
      ,temp.[����ҵ���ŵ�����(MB)]
      ,temp.[�����û�ƽ������]
      ,temp.[�����û�ƽ������]
      ,temp.[ƽ��E-RAB��]
      ,temp.[E-RAB�����ɹ���]
      ,temp.[VOLTE����������]
      ,temp.[VOLTE������ֵ�û���]
      ,temp.[����VOLTEռ��PRB����]
      ,temp.[����VOLTEռ��PRB����]
      ,temp.[��QCI�Ľ����ɹ�����(QCI5)]
      ,temp.[С���û��������ֽ�����QCI5��]
      ,temp.[С���û��������ֽ�����QCI5��]
      ,temp.[���߽�ͨ��]
      ,temp.[E-RABӵ����(������Դ����)]
      ,temp.[����������(MB)]
      ,temp.[����������(MB)]
      ,temp.[�豸�ͺ�(������΢վ��д)]
      ,temp.[ͨ������书��(W)]
      ,temp.[���ߵ�����]
      ,temp.[���ߵ�����(�޳�UI)]
      ,temp.[E-RAB������]
      ,temp.[E-RAB�����ɹ���]
      ,temp.[�л��ɹ���]
      ,temp.[���߹Ҹ�]
      ,temp.[CQIƽ��ֵ]
	 /* ,round(([����������(MB)]+[����������(MB)])/1024,2)as ������GB
	  ,iif([����PRBƽ��������(v2 8)] >[����PRBƽ��������(v2 8)]and[����PRBƽ��������(v2 8)]>[PDCCH�ŵ�CCEռ����],[����PRBƽ��������(v2 8)],iif([����PRBƽ��������(v2 8)]>[PDCCH�ŵ�CCEռ����],[����PRBƽ��������(v2 8)],[PDCCH�ŵ�CCEռ����])) as ���������
	  */
into �ܱ�temp FROM
/*(SELECT [С��ID],[����],[·������]from [����].[dbo].[С������]) as temp left join
[�㶫].[dbo].[��ƽ��æʱ����0703]  on  [�㶫].[dbo].[��ƽ��æʱ����0703].С��ID= temp.С��ID*/
(SELECT * FROM [�㶫].[dbo].[��ƽ��æʱ����0703]) AS temp left join [����].[dbo].[С������]
 ON [����].[dbo].[С������] .С��ID= temp.С��ID

 /*
update [�㶫].dbo.�ܱ�temp set [����] ='����' where С������ like '%����%'
update [�㶫].dbo.�ܱ�temp set [����] ='��ݸ' where С������ like '%��ݸ%'
update [�㶫].dbo.�ܱ�temp set [����] ='��ɽ' where С������ like '%��ɽ%'
update [�㶫].dbo.�ܱ�temp set [����] ='����' where С������ like '%����%'
update [�㶫].dbo.�ܱ�temp set [����] ='��Դ' where С������ like '%��Դ%'
update [�㶫].dbo.�ܱ�temp set [����] ='����' where С������ like '%����%'
update [�㶫].dbo.�ܱ�temp set [����] ='����' where С������ like '%����%'
update [�㶫].dbo.�ܱ�temp set [����] ='����' where С������ like '%����%'
update [�㶫].dbo.�ܱ�temp set [����] ='ï��' where С������ like '%ï��%'
update [�㶫].dbo.�ܱ�temp set [����] ='÷��' where С������ like '%÷��%'
update [�㶫].dbo.�ܱ�temp set [����] ='��Զ' where С������ like '%��Զ%'
update [�㶫].dbo.�ܱ�temp set [����] ='��ͷ' where С������ like '%��ͷ%'
update [�㶫].dbo.�ܱ�temp set [����] ='��β' where С������ like '%��β%'
update [�㶫].dbo.�ܱ�temp set [����] ='�ع�' where С������ like '%�ع�%'
update [�㶫].dbo.�ܱ�temp set [����] ='����' where С������ like '%����%'
update [�㶫].dbo.�ܱ�temp set [����] ='����' where С������ like '%����%'
update [�㶫].dbo.�ܱ�temp set [����] ='�Ƹ�' where С������ like '%�Ƹ�%'
update [�㶫].dbo.�ܱ�temp set [����] ='տ��' where С������ like '%տ��%'
update [�㶫].dbo.�ܱ�temp set [����] ='����' where С������ like '%����%'
update [�㶫].dbo.�ܱ�temp set [����] ='��ɽ' where С������ like '%��ɽ%'
update [�㶫].dbo.�ܱ�temp set [����] ='�麣' where С������ like '%�麣%'
*/