select a.����,a.С������,a.ecgi,a.·������,b.����ϵ�� into temp2 from gongcanys a, llmxfx b where a.ecgi=b.ecgi group by a.����,a.С������,a.ecgi,a.·������,b.����ϵ��
select * from temp2


select ����,·������, count(*) from temp2 where ����ϵ��<=0.05  group by ����,·������
select ����,·������,count(*) from temp2 where ����ϵ��>0.05 and ����ϵ��<=0.2 group by ����,·������
select ����,·������,count(*) from temp2 where ����ϵ��>0.2 and ����ϵ��<=0.5 group by ����,·������
select ����,·������,count(*) from temp2 where ����ϵ��>0.5 and ����ϵ��<=1.5 group by ����,·������
select ����,·������,count(*) from temp2 where ����ϵ��>1.5 and ����ϵ��<=3 group by ����,·������
select ����,·������,count(*) from temp2 where ����ϵ��>3 and ����ϵ��<=5 group by ����,·������
select ����,·������,count(*) from temp2 where ����ϵ��>0.2 group by ����,·������

select ����,·������,count(*) from temp2 where ����ϵ��>0 group by ����,·������

select * from lltj0703 where ecgi='460-00-841822-131'

create table  lltj0703(���� varchar(100),ECGI varchar(100),С������ varchar(100),���� varchar(100),Ƶ�� varchar(100),���� varchar(100),��ЧRRC����ƽ���� float,��ЧRRC��������� float,RRC����ƽ���� float,RRC��������� float,���������� float,���������� float,CCEռ���� float,��������MB float,��������MB float) 
create table  lltj0703n(���� varchar(100),ECGI varchar(100),С������ varchar(150),���� varchar(150),Ƶ�� varchar(100),���� varchar(100))

drop table lltj0703
create table  lltj0703n(���� varchar(100),ECGI varchar(100),С������ varchar(150),���� varchar(150),Ƶ�� varchar(100),���� varchar(100))
create table  lltj0703(���� varchar(100),ECGI varchar(100),С������ varchar(150),���� varchar(150),Ƶ�� varchar(30),���� varchar(30),��ЧRRC����ƽ���� numeric(10,2),��ЧRRC��������� numeric(10,2),RRC����ƽ���� numeric(10,2),RRC��������� numeric(10,2),���������� numeric(10,2),���������� numeric(10,2),CCEռ���� numeric(10,2),��������MB numeric(10,2),��������MB numeric(10,2),��������� numeric(10,2)) 


create table  gongcan0708(���� varchar(100),С������ varchar(150),ECGI varchar(100),���� varchar(150),·������ varchar(100)) 

select * from lltj0703

select a.����,a.С������,a.ECGI,a.Ƶ��,a.����,a.��ЧRRC����ƽ����,round(sum(a.��������MB+a.��������MB)/1024,2) as ����GBa.��ЧRRC���������,a.RRC����ƽ����,a.RRC���������,a.���������,,b.����,b.·������ into lltjnew0703
from lltj0703 a,gongcan0708 b where a.ecgi=b.ecgi group by a.����,a.С������,a.ECGI,a.Ƶ��,a.����,a.��ЧRRC����ƽ����,a.��ЧRRC���������,a.RRC����ƽ����,a.RRC���������,a.���������,b.����,b.·������

select ����,sum(����GB)/count(*) as ��С������ into dxqll0703  from lltjnew0703 group by ����

select * from dxqll0703

select a.[����],a.[С������],a.ecgi,a.����,round(a.����GB/b.[��С������],2) as [����ϵ��] into llmxfx0703  from lltjnew0703 a,dxqll0703 b where a.[����]=b.[����] group by a.[����],a.[С������],a.ecgi,a.����GB,b.[��С������],a.����


select * from llmxfx0703





select A.ID,A.VALUE,A.TYPE,A.NAME,B.KEY,B.ID,B.VALUE,B.NAME min(VALUE),max(VALUE) from A left join B on A.ID = B.IDwhere B.NAME="�����������" and B.VALUE > (select min(VALUE) from B where NAME="�����������")) and B.VALUE < (select min(VALUE) from B where NAME="�����������"))��