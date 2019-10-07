1.客户信息表cust_info装载操作步骤号： 
（1）首先登陆数据仓库ORCL，创建cust_info表，其创建表语句如下：
  -- Create table
create  table  CUST_INFO
(
  CUSTER_ID      CHAR(8),
  CARD_ID        CHAR(16),
  NAME           VARCHAR2(10),
  SEX            CHAR(1),
  ID             VARCHAR2(18),
  BIRTH          DATE,
  MARITAL_STATUS CHAR(1),
  XL             VARCHAR2(10),
  ZW             VARCHAR2(12),
  WORK_YEAR      NUMBER(2),
  ADDR_1         VARCHAR2(30),
  ADDR_2         VARCHAR2(30),
  ZONE           VARCHAR2(10),
  MOBILE         CHAR(11),
  PHONE          VARCHAR2(12),
  E_MAIL         VARCHAR2(30),
  GJ             VARCHAR2(10),
  SQ_DATE        DATE,
  STATUS         CHAR(1),
  CUST_LEVEL     CHAR(1),
  CREDET_STATU   NUMBER(1),
  ZD_DATE        DATE,
  ZDYJ_ADDR      VARCHAR2(30),
  ZDYJ_FS        CHAR(1)
)
tablespace TBS_CUST1;
【注意】创建表语句中要把tablespace 对应表空间TBS_CUST1换成读者自己的数据仓库对应的表空间。
（2）外部数据文件Cust.dat装载到目标表cust_info的SAS程序如下：
  LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*建立连接数据库的逻辑库*/
LIBNAME  qh  'd:\qh'; /*定义逻辑库*/
%let  lj= D:\qh\cust;/*定义外部文件路径*/
%let  gsm=.dat; /*文件格式定义*/
%let  filename= "&lj&gsm";
DATA  qh.custinf  (drop=birth_1 sq_date_1 zd_date_1 );  /*数据集存储到指定逻辑库*/
	Infile  &filename  dlm='|'  dsd  missover  lrecl=269 ; 
/*此处用dlm='|'分隔符参数读取分隔文件，文件记录长度超过256用lrecl=指定长度*/
	   input  custer_id      :$8.
             card_id        :$16.
             name          :$10.
             sex            :$1.
             id              :$18.
             birth_1         :$8.
             marital_status   :$1.
             xl              :$10.
             zw             :$12.
             work_year      :2.
             addr_1         :$30.
             addr_2         :$30.
             zone           :$10.
             mobile         :$12.
             phone          :$12.
             e_mail         :$30.
             gj             :$10.
             sq_date_1     :$8.
             status         :$1.
             cust_level     :$1.
             credet_statu   :1.
             zd_date_1     :$8.
             zdyj_addr     :$30.
             zdyj_fs        :$1.
		        ; 
length   birth  8;
	if   birth_1<'19771231'  then  birth=input('19771231',anydtdte8.);
		else   do;
		 if   birth_1> '21001231'  then  birth=input('21001231',anydtdte8.);
			else   birth =input(birth_1,anydtdte8.);
	end; 
	length   sq_date  8;
	if   sq_date_1<'19771231'  then  sq_date=input('19771231',anydtdte8.);
		else  do;
		 if   sq_date_1> '21001231'  then  sq_date=input('21001231',anydtdte8.);
			else  sq_date =input(sq_date_1,anydtdte8.);
	end;
	length  zd_date  8;
	if   zd_date_1<'19771231'  then  zd_date=input('19771231',anydtdte8.);
		else  do;
		 if  zd_date_1> '21001231'  then  zd_date=input('21001231',anydtdte8.);
			else  zd_date =input(zd_date_1,anydtdte8.);
	end; 
run;            
proc  append  base=qhlj.cust_info 
	( bulkload=no 
	  dbsastype=(
	  birth	       = 'date'
	  work_year	       ='numeric'
	  sq_date	       = 'date'
	  zd_date	       = 'date'	
	  credet_statu	 ='numeric'	
	)             
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.custinf;
	run;
