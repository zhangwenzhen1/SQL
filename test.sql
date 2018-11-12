select a.地市,a.小区名称,a.ecgi,a.路测网格,b.流量系数 into temp2 from gongcanys a, llmxfx b where a.ecgi=b.ecgi group by a.地市,a.小区名称,a.ecgi,a.路测网格,b.流量系数
select * from temp2


select 地市,路测网格, count(*) from temp2 where 流量系数<=0.05  group by 地市,路测网格
select 地市,路测网格,count(*) from temp2 where 流量系数>0.05 and 流量系数<=0.2 group by 地市,路测网格
select 地市,路测网格,count(*) from temp2 where 流量系数>0.2 and 流量系数<=0.5 group by 地市,路测网格
select 地市,路测网格,count(*) from temp2 where 流量系数>0.5 and 流量系数<=1.5 group by 地市,路测网格
select 地市,路测网格,count(*) from temp2 where 流量系数>1.5 and 流量系数<=3 group by 地市,路测网格
select 地市,路测网格,count(*) from temp2 where 流量系数>3 and 流量系数<=5 group by 地市,路测网格
select 地市,路测网格,count(*) from temp2 where 流量系数>0.2 group by 地市,路测网格

select 地市,路测网格,count(*) from temp2 where 流量系数>0 group by 地市,路测网格

select * from lltj0703 where ecgi='460-00-841822-131'

create table  lltj0703(地市 varchar(100),ECGI varchar(100),小区名称 varchar(100),场景 varchar(100),频段 varchar(100),带宽 varchar(100),有效RRC连接平均数 float,有效RRC连接最大数 float,RRC连接平均数 float,RRC连接最大数 float,下行利用率 float,上行利用率 float,CCE占用率 float,上行流量MB float,下行流量MB float) 
create table  lltj0703n(地市 varchar(100),ECGI varchar(100),小区名称 varchar(150),场景 varchar(150),频段 varchar(100),带宽 varchar(100))

drop table lltj0703
create table  lltj0703n(地市 varchar(100),ECGI varchar(100),小区名称 varchar(150),场景 varchar(150),频段 varchar(100),带宽 varchar(100))
create table  lltj0703(地市 varchar(100),ECGI varchar(100),小区名称 varchar(150),场景 varchar(150),频段 varchar(30),带宽 varchar(30),有效RRC连接平均数 numeric(10,2),有效RRC连接最大数 numeric(10,2),RRC连接平均数 numeric(10,2),RRC连接最大数 numeric(10,2),下行利用率 numeric(10,2),上行利用率 numeric(10,2),CCE占用率 numeric(10,2),上行流量MB numeric(10,2),下行流量MB numeric(10,2),最大利用率 numeric(10,2)) 


create table  gongcan0708(地市 varchar(100),小区名称 varchar(150),ECGI varchar(100),网格 varchar(150),路测网格 varchar(100)) 

select * from lltj0703

select a.地市,a.小区名称,a.ECGI,a.频段,a.带宽,a.有效RRC连接平均数,round(sum(a.下行流量MB+a.上行流量MB)/1024,2) as 流量GBa.有效RRC连接最大数,a.RRC连接平均数,a.RRC连接最大数,a.最大利用率,,b.网格,b.路测网格 into lltjnew0703
from lltj0703 a,gongcan0708 b where a.ecgi=b.ecgi group by a.地市,a.小区名称,a.ECGI,a.频段,a.带宽,a.有效RRC连接平均数,a.有效RRC连接最大数,a.RRC连接平均数,a.RRC连接最大数,a.最大利用率,b.网格,b.路测网格

select 地市,sum(流量GB)/count(*) as 单小区流量 into dxqll0703  from lltjnew0703 group by 地市

select * from dxqll0703

select a.[地市],a.[小区名称],a.ecgi,a.网格,round(a.流量GB/b.[单小区流量],2) as [流量系数] into llmxfx0703  from lltjnew0703 a,dxqll0703 b where a.[地市]=b.[地市] group by a.[地市],a.[小区名称],a.ecgi,a.流量GB,b.[单小区流量],a.网格


select * from llmxfx0703





select A.ID,A.VALUE,A.TYPE,A.NAME,B.KEY,B.ID,B.VALUE,B.NAME min(VALUE),max(VALUE) from A left join B on A.ID = B.IDwhere B.NAME="你输入的名字" and B.VALUE > (select min(VALUE) from B where NAME="你输入的名字")) and B.VALUE < (select min(VALUE) from B where NAME="你输入的名字"))；