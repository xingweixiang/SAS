7.�ͻ�������Ϣ��cust_Integralװ�ز�������ţ� 
��1����½���ݲֿ�ORCL������cust_Integral���䴴����������£�
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
��2���ⲿ�����ļ�integral.datװ�ص�Ŀ���cust_Integral��SAS�������£�
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*�����������ݿ���߼���*/
LIBNAME  qh 'd:\qh'; /*�����߼���*/
%let  lj= D:\qh\integral;/*�����ⲿ�ļ�·��*/
%let  gsm=.dat; /*�ļ���ʽ����*/
%let  filename= "&lj&gsm";
DATA  qh.integral ;  /*���ݼ��洢��ָ���߼���*/
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
