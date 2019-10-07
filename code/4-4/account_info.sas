2.帐户信息表account_info装载操作步骤号： 
（1）登陆数据仓库ORCL，创建account_info表，其创建表语句如下：
-- Create table
create  table  ACCOUNT_INFO
(
  CUSTER_ID  CHAR(8),
  ACCOUNT_ID CHAR(16),
  CARD_ID    CHAR(16),
  CARD_TYPE  CHAR(10),
  NAME       VARCHAR2(10),
  ZD_DATE    DATE,
  BRANCH_ID  CHAR(9),
  OPEN_DATE  DATE,
  ZH_STATUS  NUMBER,
  STATUS     CHAR(1),
  CARD_LEVEL CHAR(1),
  HY_FLAG    CHAR(1),
  EV_ED      NUMBER(9),
  KX_DAYS    NUMBER(4)
)
tablespace  TBS_CUST2;
（2）外部数据文件account.dat装载到目标表account_info的SAS程序如下：
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*建立连接数据库的逻辑库*/
LIBNAME  qh  'd:\qh'; /*定义逻辑库*/
%let  lj= D:\qh\account;/*定义外部文件路径*/
%let  gsm=.dat; /*文件格式定义*/
%let  filename= "&lj&gsm";
DATA  qh.account  (drop=zd_date_1 open_date_1);  /*数据集存储到指定逻辑库*/
	Infile  &filename  dlm='|'  dsd  missover  lrecl=102 ; 
/*此处用dlm='|'分隔符参数读取分隔文件，文件记录长度超过256用lrecl=指定长度*/
 Input  custer_id    :$8.
       account_id   :$16.
       card_id      :$16.
       card_type    :$10.
       name        :$10.
       zd_date_1    :$8.
       branch_id    :$9.
       open_date_1  :$8.
       zh_status      :1.
       status        :$1.
       card_level     :$1.
       hy_flag       :$1.
       ev_ed        :9.
       kx_days       :4.
		        ; 
length  zd_date  8;
	if   zd_date_1<'19771231'  then  zd_date=input('19771231',anydtdte8.);
		else  do;
		 if  zd_date_1> '21001231'  then  zd_date=input('21001231',anydtdte8.);
			else   zd_date =input(zd_date_1,anydtdte8.);
	end; 
	length  open_date  8;
	if   open_date_1<'19771231'  then  open_date=input('19771231',anydtdte8.);
		else  do;
		 if  open_date_1> '21001231'  then  open_date=input('21001231',anydtdte8.);
			else  open_date =input(open_date_1,anydtdte8.);
	end; 
run;            
proc  append  base=qhlj.account_info 
	( bulkload=no 
	  dbsastype=(
	  zd_date	       = 'date'
	  open_date	       = 'date'
	  zh_status	       ='numeric'
	  ev_ed	       = 'numeric'	
	  kx_days	 ='numeric'	
	)             
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.account;
	run;
