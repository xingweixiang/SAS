3.卡信息表card_info装载操作步骤号： 
（1）登陆数据仓库ORCL，创建card_info表，其创建表语句如下：
  -- Create table
create  table  CARD_INFO
(
  CARD_ID     CHAR(16),
  CUSTER_ID   CHAR(8),
  CARDER_ID   CHAR(16),
  CARD_TYPE   CHAR(10),
  NAME        VARCHAR2(10),
  MASTER_TYPE CHAR(1),
  BRANCH_ID   CHAR(9),
  ED          NUMBER(9),
  LS_ED       NUMBER(9),
  TZ_DATE     DATE,
  QX_ED       NUMBER(9),
  FQ_ED       NUMBER(9),
  SQHK_ED     NUMBER(9),
  SQHK_DATE   DATE,
  BQHK_ED     NUMBER(9),
  BQHK_DATE   DATE,
  QK_ED       NUMBER(9),
  QK_TYPE     CHAR(1),
  WY_DAYS     NUMBER(3),
  WY_TIMES    NUMBER(2),
  WY_FLAG     CHAR(1)
)
tablespace TBS_CUST3;
（2）外部数据文件card.dat装载到目标表card_info的SAS程序如下：
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*建立连接数据库的逻辑库*/
LIBNAME  qh 'd:\qh'; /*定义逻辑库*/
%let  lj= D:\qh\card;/*定义外部文件路径*/
%let  gsm=.dat; /*文件格式定义*/
%let  filename= "&lj&gsm";
DATA  qh.cardinfo  (drop=tz_date_1 sqhk_date_1 bqhk_date_1);  /*数据集存储到指定逻辑库*/
	Infile  &filename  dlm='|'  dsd  missover  lrecl=164 ; 
/*此处用dlm='|'分隔符参数读取分隔文件，文件记录长度超过256用lrecl=指定长度*/
input  card_id       :$16.
       custer_id     :$8.
       carder_id     :$16.
       card_type    :$10.
       name        :$10.
       master_type  :$1.
       branch_id    :$9.
       ed           :9.
       ls_ed        :9.
       tz_date_1    :$8.
       qx_ed        :9.
       fq_ed        :9.
       sqhk_ed      :9.
       sqhk_date_1  :$8.
       bqhk_ed      :9.
       bqhk_date_1  :$8.
       qk_ed        :9.
       qk_type      :$1.
       wy_days      :3.
       wy_times     :2.
       wy_flag      :$1.
		        ; 
length  tz_date  8;
	if   tz_date_1<'19771231'  then  tz_date=input('19771231',anydtdte8.);
		else  do;
		 if  tz_date_1> '21001231'  then  tz_date=input('21001231',anydtdte8.);
			else   tz_date =input(tz_date_1,anydtdte8.);
	end; 
	length  sqhk_date  8;
	if   sqhk_date_1<'19771231'  then  sqhk_date=input('19771231',anydtdte8.);
		else  do;
		 if  sqhk_date_1> '21001231'  then  sqhk_date=input('21001231',anydtdte8.);
			else  sqhk_date=input(sqhk_date_1,anydtdte8.);
	end;
	length  bqhk_date  8;
	if   bqhk_date_1<'19771231'  then  bqhk_date=input('19771231',anydtdte8.);
		else  do;
		 if  bqhk_date_1> '21001231'  then  bqhk_date=input('21001231',anydtdte8.);
			else   bqhk_date=input(bqhk_date_1,anydtdte8.);
	end;  
run;            
proc  append  base=qhlj.card_info 
	( bulkload=no 
	  dbsastype=(
	  ed	       ='numeric'
	  ls_ed	     ='numeric'
	  tz_date	   = 'date'
	  qx_ed	     ='numeric'
	  fq_ed	     ='numeric'
	  sqhk_ed	   ='numeric'
	  sqhk_date  = 'date'
	  bqhk_ed	   ='numeric'
	  bqhk_date	   = 'date'	  
	  qk_ed       = 'numeric'	
	  wy_days	 ='numeric'
	  wy_times	 ='numeric'	
	)             
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.cardinfo;
	run;
