USE [�㶫]
GO



select [����]
      ,[С��������]
      ,[�㶫].[dbo].[�羰���ܱ�].[CGI]
      ,[����]
      ,[��������]
	  ,TEMP.[(�ƶ�)�ܲ�������]
	  ,TEMP.[(�ƶ�)�����ǲ���������(С��-110)]
	  ,TEMP.MR������
INTO �羰���ܱ�1 from

 (SELECT [(�ƶ�)�ܲ�������],[(�ƶ�)�����ǲ���������(С��-110)],CGI,MR������ FROM [�㶫].[dbo].[ȫʡ������])AS TEMP right join 
 [�㶫].[dbo].[�羰���ܱ�] ON  [�㶫].[dbo].[�羰���ܱ�].CGI=TEMP.CGI


 update [�㶫].dbo.�羰���ܱ�1 set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='��ݸ' where ���� like '%��ݸ%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='��ɽ' where ���� like '%��ɽ%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='��Դ' where ���� like '%��Դ%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='ï��' where ���� like '%ï��%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='÷��' where ���� like '%÷��%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='��Զ' where ���� like '%��Զ%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='��ͷ' where ���� like '%��ͷ%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='��β' where ���� like '%��β%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='�ع�' where ���� like '%�ع�%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='�Ƹ�' where ���� like '%�Ƹ�%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='տ��' where ���� like '%տ��%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='����' where ���� like '%����%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='��ɽ' where ���� like '%��ɽ%'
update [�㶫].dbo.�羰���ܱ�1 set [����] ='�麣' where ���� like '%�麣%'