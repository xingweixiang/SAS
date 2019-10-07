10.营销信息表Marketing_info装载操作步骤号： 
（1）登陆数据仓库ORCL，创建Marketing_info表，其创建表语句如下：
-- Create table
create table MARKETING_INFO
(
  YX_ID       CHAR(8),
  YX_TYPE     CHAR(1),
  YX_BRANCHID CHAR(8),
  YX_ADDR     VARCHAR2(30),
  YX_NAME     VARCHAR2(10),
  YXY_ID      CHAR(8),
  YXHZ_SH     VARCHAR2(30),
  YX_CP       VARCHAR2(30),
  YX_PJ       VARCHAR2(30)
)
tablespace TBS_CUST3;
（2）外部数据文件apply.dat装载到目标表Marketing_info的SAS程序如下：
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*建立连接数据库的逻辑库*/
LIBNAME  qh 'd:\qh'; /*定义逻辑库*/
%let  lj= D:\qh\market;/*定义外部文件路径*/
%let  gsm=.dat; /*文件格式定义*/
%let  filename= "&lj&gsm";
DATA  qh.market;  /*数据集存储到指定逻辑库*/
	Infile  &filename  dlm='|'  dsd  missover ; 
/*此处用dlm='|'分隔符参数读取分隔文件，文件记录长度超过256用lrecl=指定长度*/
	  input  yx_id       :$8.
           yx_type     :$1.
           yx_branchid :$8.
           yx_addr     :$30.
           yx_name     :$10.
           yxy_id      :$8.
           yxhz_sh     :$30.
           yx_cp       :$30.
           yx_pj       :$30.
		        ; 
run;            
proc  append  base=qhlj.marketing_info 
	( bulkload=no 
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.market;
	run;
