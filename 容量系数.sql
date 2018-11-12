USE [容量]
GO

SELECT 小区性能.["所属地市"]
       ,小区性能.[CGI]
       ,小区性能.[小区名称]
       ,小区性能.[经度]
       ,小区性能.[纬度]
	   ,小区工参.PCI
       ,小区性能.[开始时间]
       ,小区性能.[结束时间]
       ,小区性能.[小区用户面上行字节数(KByte)]
       ,小区性能.[小区用户面下行字节数(KByte)]
       ,小区性能.[下行PRB平均利用率(%)]
       ,小区性能.[无线利用率(%)]
        into 性能  from 小区工参,小区性能 where 小区工参.CGI=小区性能.[CGI]

	 /* ,cast(case when 小区性能.[小区用户面上行字节数(KByte)] = '' or 小区性能.[小区用户面上行字节数(KByte)] = null then 0.0 else 小区性能.[小区用户面上行字节数(KByte)] end as numeric(20,8)) as aaa
	   FROM 小区性能 */
	   /*where 
	    (小区性能.[小区用户面上行字节数(KByte)] != '' and 小区性能.[小区用户面上行字节数(KByte)] != null)*/
		

GO

/**(cast(小区性能.[小区用户面上行字节数(KByte)] as numeric(18,6))+ cast (小区性能.[小区用户面下行字节数(KByte)] as numeric(18,6)))/1024/1024/7 as aaa**/
