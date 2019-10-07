7.客户积分信息表cust_Integral装载操作步骤号： 
（1）登陆数据仓库ORCL，创建cust_Integral表，其创建表语句如下：
-- Create table
Create  table  CUST_INTEGRAL
(
  CARD_ID   CHAR(16),
  CUSTER_ID CHAR(8),
  CA_ID     CHAR(16),
  NAME      VARCHAR2(10),
  BZ_TYPE   CHAR(1),
  XF_ED     NUMBER(9),
  JF_TYPE   CHAR(1),
  JF        NUMBER(9),
  JFJS_RULE NUMBER(1),
  BQDH_JF   NUMBER(9),
  BQ_JF     NUMBER(9),
  DH_LX     CHAR(1),
  BQJL_JF   NUMBER(9),
  BQJL_YX   VARCHAR2(30)
)
tablespace TBS_CUST1;
（2）外部数据文件integral.dat装载到目标表cust_Integral的SAS程序如下：
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*建立连接数据库的逻辑库*/
LIBNAME  qh 'd:\qh'; /*定义逻辑库*/
%let  lj= D:\qh\integral;/*定义外部文件路径*/
%let  gsm=.dat; /*文件格式定义*/
%let  filename= "&lj&gsm";
DATA  qh.integral ;  /*数据集存储到指定逻辑库*/
	Infile  &filename  dlm='|'  dsd  missover  lrecl=129 ; 
input   card_id       :$16.
        custer_id     :$8.
        ca_id         :$16.
        name         :$10.
        bz_type       :$1.
        xf_ed        :9.
        jf_type       :$1.
        jf            :9.
        jfjs_rule      :1.
        bqdh_jf      :9.
        bq_jf        :9.
        dh_lx        :$1.
        bqjl_jf        :9.
        bqjl_yx      :$30.
		        ; 
run;            
proc  append  base=qhlj.cust_integral 
	( bulkload=no 
	  dbsastype=(
	  xf_ed	       ='numeric'
	  jf	     ='numeric'
	   jfjs_rule	       ='numeric'
	  bqdh_jf	     ='numeric'
	  bq_jf	       ='numeric'
	  bqjl_jf	     ='numeric'
	)             
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.integral;
	run;
