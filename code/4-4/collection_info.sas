6.催收信息表collection_info装载操作步骤号： 
（1）登陆数据仓库ORCL，创建collection_info表，其创建表语句如下：
-- Create table
create  table  COLLECTION_INFO
(
  ACCOUNT_ID CHAR(16),
  CS_ID      CHAR(10),
  ACOUNT_ID  CHAR(16),
  NAME       VARCHAR2(10),
  WY_TYPE    CHAR(1),
  QK_ED      NUMBER(9),
  QK_YX      VARCHAR2(30),
  CS_LEVEL   CHAR(1),
  CSDZ_ED    NUMBER(9),
  CS_DATE    DATE,
  SFTZ_CS    CHAR(1),
  TZCS_DATE  DATE,
  CSY_ID     CHAR(8),
  CS_NAME    VARCHAR2(10),
  CS_DAYS    NUMBER(8)
)
tablespace  TBS_CUST3;
（2）外部数据文件collection.dat装载到目标表collection_info的SAS程序如下：
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*建立连接数据库的逻辑库*/
LIBNAME  qh  'd:\qh'; /*定义逻辑库*/
%let  lj= D:\qh\collection;/*定义外部文件路径*/
%let  gsm=.dat; /*文件格式定义*/
%let  filename= "&lj&gsm";
DATA  qh.collection  (drop=cs_date_1 tzcs_date_1);  /*数据集存储到指定逻辑库*/
	Infile  &filename  dlm='|'  dsd  missover  lrecl=145 ; 
input   account_id    :$16.
        cs_id         :$10.
        acount_id     :$16.
        name          :$10.
        wy_type       :$1.
        qk_ed         :9.
        qk_yx         :$30.
        cs_level       :$1.
        csdz_ed       :9.
        cs_date_1     :$8.
        sftz_cs        :$1.
        tzcs_date_1   :$8.
        csy_id        :$8.
        cs_name       :$10.
        cs_days       :8.

		        ; 
length  cs_date  8;
	if   cs_date_1<'19771231'  then  cs_date=input('19771231',anydtdte8.);
		else  do;
		 if  cs_date_1> '21001231'  then  cs_date=input('21001231',anydtdte8.);
			else  cs_date =input(cs_date_1,anydtdte8.);
	end; 
	
	length  tzcs_date 8;
	if   tzcs_date_1<'19771231'  then  tzcs_date=input('19771231',anydtdte8.);
		else  do;
		 if   tzcs_date_1> '21001231'  then  tzcs_date=input('21001231',anydtdte8.);
			else   tzcs_date =input(tzcs_date_1,anydtdte8.);
	end; 
run;            
proc  append  base=qhlj.collection_info 
	( bulkload=no 
	  dbsastype=(
	  qk_ed	       ='numeric'
	  csdz_ed	     ='numeric'
	  cs_date	     = 'date'	  
	  tzcs_date	   ='date'
	  cs_days	   ='numeric'
	)             
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.collection;
	run;
