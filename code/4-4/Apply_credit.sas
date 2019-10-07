8.信用卡申请信息表Apply_credit装载操作步骤号： 
（1）登陆数据仓库ORCL，创建Apply_credit表，其创建表语句如下：
Create  table  apply_credit
(
  aplication_bh   char(8),
  application_dte date,
  apl_name        varchar2(10),
  birth_dte       date,
  sex             char(1),
  zj_type         char(1),
  zj_id           varchar2(18),
  education       varchar2(10),
  marr_status     char(1),
  mobile          char(11),
  xz_addr         varchar2(30),
  phone           varchar2(12),
  work_dw         varchar2(30),
  xz_work_y       integer,
  zc              varchar2(16),
  year_earn       number(9),
  gz_year         number(2),
  sq_ed           number(9),
  father          varchar2(10),
  mother          varchar2(10),
  fm_phone        varchar2(12),
  zx              char(1),
  sp_bh           char(8),
  sp_name         varchar2(8),
  pf_value        integer,
  pf_jg           char(1),
  jy_ed           number(9)
)
tablespace  tbs_cust2;
（2）外部数据文件apply.dat装载到目标表apply_credit的SAS程序如下：
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*建立连接数据库的逻辑库*/
LIBNAME  qh 'd:\qh'; /*定义逻辑库*/
%let  lj= D:\qh\apply;/*定义外部文件路径*/
%let  gsm=.dat; /*文件格式定义*/
%let  filename= "&lj&gsm";
DATA  qh.apply (drop=application_dte_1 birth_dte_1 );  /*数据集存储到指定逻辑库*/
	Infile  &filename  dlm='|'  dsd  missover  lrecl=248 ; 
input  aplication_bh      :$8.
       application_dte_1  :$8.
       apl_name        :$10.
       birth_dte_1     :$8.
       sex             :$1.
       zj_type         :$1.
       zj_id           :$18.
       education       :$10.
       marr_status     :$1.
       mobile          :$12.
       xz_addr         :$30.
       phone           :$12.
       work_dw         :$30.
       xz_work_y       :2.
       zc              :$16.
       year_earn       :9.
       gz_year         :2.
       sq_ed           :9.
       father          :$10.
       mother          :$10.
       fm_phone        :$12.
       zx              :$1.
       sp_bh           :$8.
       sp_name         :$8.
       pf_value        :3.
       pf_jg           :$1.
       jy_ed           :9.

		        ;
	length  application_dte 8;
	if   application_dte_1<'19771231' then application_dte=input('19771231',anydtdte8.);
		else  do;
		 if  application_dte_1> '21001231' then application_dte=input('21001231',anydtdte8.);
			else  application_dte =input(application_dte_1,anydtdte8.);
	end;
	length  birth_dte 8;
	if   birth_dte_1<'19771231' then birth_dte=input('19771231',anydtdte8.);
		else  do;
		 if  birth_dte_1> '21001231' then birth_dte=input('21001231',anydtdte8.);
			else  birth_dte =input(birth_dte_1,anydtdte8.);
	end; 
	
	  
run;            
proc  append  base=qhlj.apply_credit 
	( bulkload=no 
	  dbsastype=(
	  application_dte = 'date'
	  birth_dte	      = 'date'
	  xz_work_y	      ='numeric'
	  year_earn	      ='numeric'
	   gz_year	      ='numeric'
	  sq_ed	          ='numeric'
	  pf_value	      ='numeric'
	  jy_ed	          ='numeric'
	)             
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.apply;
	run;
