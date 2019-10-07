5.客户消费行为信息表Consumer_behavior装载操作步骤号： 
（1）登陆数据仓库ORCL，创建Consumer_behavior表，其创建表语句如下：
-- Create table
create  table  CONSUMER_BEHAVIOR
(
  CARD_ID   CHAR(16),
  CUSTER_ID CHAR(8),
  C_ID      CHAR(16),
  CARD_TYPE CHAR(10),
  NAME      VARCHAR2(10),
  XF_ED     NUMBER(9),
  XF_SH     VARCHAR2(30),
  XF_ADDR   VARCHAR2(30),
  XF_DATE   DATE,
  XF_TYPE   CHAR(1),
  XF_BS     NUMBER(4),
  DAYS_BS   NUMBER(3),
  DAYS_ED   NUMBER(9),
  MONTH_BS  NUMBER(3),
  MONTH_ED  NUMBER(9),
  YEAR_BS   NUMBER(3),
  YEAR_ED   NUMBER(9)
)
tablespace TBS_CUST2;
（2）外部数据文件consumer.dat装载到目标表Consumer_behavior的SAS程序如下：
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*建立连接数据库的逻辑库*/
LIBNAME  qh 'd:\qh'; /*定义逻辑库*/
%let  lj= D:\qh\consumer;/*定义外部文件路径*/
%let  gsm=.dat; /*文件格式定义*/
%let  filename= "&lj&gsm";
DATA  qh.consumer  (drop=xf_date_1);  /*数据集存储到指定逻辑库*/
	Infile  &filename  dlm='|'  dsd  missover  lrecl=178 ; 
/*此处用dlm='|'分隔符参数读取分隔文件，文件记录长度超过256用lrecl=指定长度*/
input   card_id      :$16.
        custer_id    :$8.
        c_id         :$16.
        card_type    :$10.
        name        :$10.
        xf_ed         :9.
        xf_sh        :$30.
        xf_addr      :$30.
        xf_date_1    :$8.
        xf_type       :$1.
        xf_bs         :4.
        days_bs      :3.
        days_ed      :9.
        month_bs     :3.
        month_ed     :9.
        year_bs      :3.
        year_ed      :9.
		        ; 
length  xf_date  8;
	if   xf_date_1<'19771231'  then  xf_date=input('19771231',anydtdte8.);
		else  do;
		 if  xf_date_1> '21001231'  then  xf_date=input('21001231',anydtdte8.);
			else   xf_date =input(xf_date_1,anydtdte8.);
	end; 
run;            
proc  append  base=qhlj.consumer_behavior 
	( bulkload=no 
	  dbsastype=(
	  xf_ed	       ='numeric'
	  xf_date	   = 'date'
	  xf_bs	     ='numeric'
	  days_bs	     ='numeric'
	  days_ed	   ='numeric'
	  month_bs  = 'numeric'
	  month_ed	   ='numeric'	  
	  year_bs       = 'numeric'	
	  year_ed 	 ='numeric'
	)             
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.consumer;
	run;
