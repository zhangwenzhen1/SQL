USE [�㶫]
GO

/*
update [�㶫].dbo.�羰���ܱ� set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ� set [����] ='��ݸ' where ���� like '%��ݸ%'
update [�㶫].dbo.�羰���ܱ� set [����] ='��ɽ' where ���� like '%��ɽ%'
update [�㶫].dbo.�羰���ܱ� set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ� set [����] ='��Դ' where ���� like '%��Դ%'
update [�㶫].dbo.�羰���ܱ� set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ� set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ� set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ� set [����] ='ï��' where ���� like '%ï��%'
update [�㶫].dbo.�羰���ܱ� set [����] ='÷��' where ���� like '%÷��%'
update [�㶫].dbo.�羰���ܱ� set [����] ='��Զ' where ���� like '%��Զ%'
update [�㶫].dbo.�羰���ܱ� set [����] ='��ͷ' where ���� like '%��ͷ%'
update [�㶫].dbo.�羰���ܱ� set [����] ='��β' where ���� like '%��β%'
update [�㶫].dbo.�羰���ܱ� set [����] ='�ع�' where ���� like '%�ع�%'
update [�㶫].dbo.�羰���ܱ� set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ� set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ� set [����] ='�Ƹ�' where ���� like '%�Ƹ�%'
update [�㶫].dbo.�羰���ܱ� set [����] ='տ��' where ���� like '%տ��%'
update [�㶫].dbo.�羰���ܱ� set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ� set [����] ='��ɽ' where ���� like '%��ɽ%'
update [�㶫].dbo.�羰���ܱ� set [����] ='�麣' where ���� like '%�麣%'
SELECT [����]
      ,[С��������]
      ,CGI
      ,[����]
      ,[��������]
  FROM [dbo].[�羰���ܱ�]
  */
SELECT   [�㶫].dbo.ȫʡ������ .����
		,TEMP.����
		,TEMP.��������
		,TEMP.С��������
		,TEMP.CGI
		,TEMP4.����
		,[�㶫].dbo.ȫʡ������.MR������
		,TEMP1.[�վ�4G����(GB)]
		,TEMP1.�շ�ֵ����������
		,TEMP1.[���������ʷ�ֵʱ������(��������MB)]
		,TEMP1.�շ�ֵ����������
		,TEMP1.[���������ʷ�ֵʱ������(��������MB)]
		,TEMP1.PDCCH�ŵ�CCE�շ�ֵ������
		,TEMP1.RRC���������
		,TEMP2.[���߽�ͨ��(%)]
		,TEMP2.[���ߵ�����(%)]
		,TEMP2.[���߽�ͨ��(QCI 1)(%)]
		,TEMP2.[E-RAB������(QCI 1)(С����)(%)]
		,TEMP2.[eSRVCC�л��ɹ���(%)]
		,TEMP3.�Ƿ�߸��ɴ�����С��
		,TEMP1.���������
 INTO���羰���ܱ��ճ���FROM
     (SELECT * FROM [�㶫].dbo.�羰���ܱ� ) AS TEMP  LEFT JOIN [�㶫].dbo.ȫʡ������  ON [�㶫].dbo.ȫʡ������.CGI=TEMP.CGI  
	/*(SELECT CGI,MR������ FROM [�㶫].dbo.ȫʡ������)    AS TEMP RIGHT JOIN [�㶫].dbo.�羰���ܱ� 
	 ON [�㶫].dbo.�羰���ܱ�.CGI=TEMP.CGI*/  LEFT JOIN
	 (SELECT С��ID
			,������GB as '�վ�4G����(GB)'
			,[����PRBƽ��������(v2 8)] as �շ�ֵ����������
			,[����������(MB)] as '���������ʷ�ֵʱ������(��������MB)'
			,[����PRBƽ��������(v2 8)] as �շ�ֵ���������� 
			,[����������(MB)]as '���������ʷ�ֵʱ������(��������MB)'
			,[PDCCH�ŵ�CCEռ����] as PDCCH�ŵ�CCE�շ�ֵ������
			,[��ЧRRC���������] as [RRC���������]
			,[����������(MB)]
			,[���������]
		FROM [�㶫].dbo.[����ϵ���ܱ�]) AS TEMP1 
	 ON  [�㶫].dbo.ȫʡ������.CGI=TEMP1.С��ID   LEFT JOIN
	 (SELECT [CGI]
			 ,[���߽�ͨ��(%)]
			 ,[���ߵ�����(%)]
			 ,[���߽�ͨ��(QCI 1)(%)]
			 ,[E-RAB������(QCI 1)(С����)(%)]
			 ,[eSRVCC�л��ɹ���(%)]
			 FROM [�㶫].dbo.[�羰��KPI]) AS TEMP2 
	 ON [�㶫].dbo.ȫʡ������.CGI=TEMP2.CGI  LEFT JOIN
	 (SELECT  [С��ID] as �Ƿ�߸��ɴ�����С�� FROM [����].[dbo].[���ڸ߸���С��]) AS TEMP3
	  ON [�㶫].dbo.ȫʡ������.CGI=TEMP3.[�Ƿ�߸��ɴ�����С��]   LEFT JOIN
	  (SELECT * FROM [�㶫].[dbo].[��Ҫ�����嵥����]) AS TEMP4
	  ON [�㶫].dbo.ȫʡ������.CGI=TEMP4.[CGI]  
	 
	update[�㶫].dbo.�羰���ܱ��ճ� set [�Ƿ�߸��ɴ�����С��] ='��' where [�Ƿ�߸��ɴ�����С��] is NOT NULL
	update[�㶫].dbo.�羰���ܱ��ճ� set [�Ƿ�߸��ɴ�����С��] ='��' where [�Ƿ�߸��ɴ�����С��] is NULL
	/*delete from [�㶫].dbo.�羰���ܱ��ճ� where ���� IS NULL*/

	