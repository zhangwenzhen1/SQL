/****** Script for SelectTopNRows command from SSMS  ******/
USE 广东

  select [广东].[dbo].[风景区周报周末-].[日期]
      ,[广东].[dbo].[风景区周报周末-].[省份]
      ,[广东].[dbo].[风景区周报周末-].[景区名称]
      ,[广东].[dbo].[风景区周报周末-].[景区编号ID]
      ,[广东].[dbo].[风景区周报周末-].[小区名称]
      ,[广东].[dbo].[风景区周报周末-].[CGI]
	  ,temp.[mr覆盖率] as MR覆盖率
	  ,temp.[日均流量gb] as '日均4G流量（GB）'
	  ,temp.[上行prb平均利用率]*0.01 as [日峰值上行利用率]
	  ,temp.[上行峰值流量mb] as '上行利用率峰值时段流量（上行流量MB）'
	  ,temp.[下行prb平均利用率]*0.01 as [日峰值下行利用率]
	  ,temp.[下行峰值流量mb] as '下行利用率峰值时段流量（下行流量MB）'
	  ,temp.[pdcch信道cce占用率]*0.01 as [PDCCH信道CCE日峰值利用率]
	  ,temp.[有效rrc连接最大数] as '有效RRC连接最大数（个）'
	  ,temp.[无线接通率]*0.01 as [无线接通率]
	  ,temp.[无线掉线率]*0.01 as [无线掉线率]
	  ,temp.[volte无线接通率]*0.01 as [volte无线接通率]
	  ,temp.[volte无线掉话率]*0.01 as [volte无线掉话率]
	  ,temp.[srvcc切换成功率]*0.01 as [Srvcc切换成功率]
	  ,temp1.是否高负荷待扩容小区 
 into [广东].[dbo].[风景区周报周末报告] from
  (select [cgi]
		  ,[city]
		  ,[mr覆盖率]
		  ,[日均流量gb]
		  ,[上行prb平均利用率]
		  ,[下行prb平均利用率]
		  ,[pdcch信道cce占用率]
		  ,[有效rrc连接最大数]
		  ,[上行峰值流量mb]
		  ,[下行峰值流量mb]
		  ,[无线接通率]
		  ,[无线掉线率]
		  ,[volte无线接通率]
		  ,[volte无线掉话率]
		  ,[srvcc切换成功率]
		 -- ,iif([上行prb平均利用率] >[下行prb平均利用率] and [上行prb平均利用率]>[pdcch信道cce占用率],[上行prb平均利用率],iif([下行prb平均利用率]>[pdcch信道cce占用率],[下行prb平均利用率],[pdcch信道cce占用率])) as 自忙时最大利用率
		  from [广东].[dbo].[weekend_0808] )as temp
		  right join [广东].[dbo].[风景区周报周末-] on [广东].[dbo].[风景区周报周末-].CGI= temp.cgi
		 left join
		  (select 小区ID as 是否高负荷待扩容小区 from [广东].[dbo].[长期高负荷小区]) as temp1
	  on [广东].[dbo].[风景区周报周末-].CGI=temp1.是否高负荷待扩容小区 

  update [广东].[dbo].[风景区周报周末报告] set 是否高负荷待扩容小区='是' where 是否高负荷待扩容小区 is NOT NULL
  update [广东].[dbo].[风景区周报周末报告] set 是否高负荷待扩容小区='否' where 是否高负荷待扩容小区 is  NULL

  update [广东].[dbo].[风景区周报周末报告] set [日峰值上行利用率]=0.993 where [日峰值上行利用率]>1
  update [广东].[dbo].[风景区周报周末报告] set [日峰值下行利用率]=0.993 where  [日峰值下行利用率]>1
  update [广东].[dbo].[风景区周报周末报告] set [PDCCH信道CCE日峰值利用率] =0.993 where [PDCCH信道CCE日峰值利用率]>1
  update [广东].[dbo].[风景区周报周末报告] set [无线接通率]=0.993 where [无线接通率]>1
  update [广东].[dbo].[风景区周报周末报告] set [Srvcc切换成功率]=0.993 where [Srvcc切换成功率]>1
  update [广东].[dbo].[风景区周报周末报告] set [volte无线接通率]=0.993 where [volte无线接通率]>1




/*
update [广东].[dbo].[风景区周报周末报告] set [地市] ='潮州' where 小区名称 like '%潮州%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='东莞' where 小区名称 like '%东莞%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='佛山' where 小区名称 like '%佛山%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='广州' where 小区名称 like '%广州%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='河源' where 小区名称 like '%河源%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='惠州' where 小区名称 like '%惠州%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='江门' where 小区名称 like '%江门%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='揭阳' where 小区名称 like '%揭阳%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='茂名' where 小区名称 like '%茂名%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='梅州' where 小区名称 like '%梅州%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='清远' where 小区名称 like '%清远%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='汕头' where 小区名称 like '%汕头%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='汕尾' where 小区名称 like '%汕尾%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='韶关' where 小区名称 like '%韶关%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='深圳' where 小区名称 like '%深圳%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='阳江' where 小区名称 like '%阳江%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='云浮' where 小区名称 like '%云浮%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='湛江' where 小区名称 like '%湛江%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='肇庆' where 小区名称 like '%肇庆%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='中山' where 小区名称 like '%中山%'
update [广东].[dbo].[风景区周报周末报告] set [地市] ='珠海' where 小区名称 like '%珠海%'
  */

