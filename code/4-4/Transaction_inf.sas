4.������Ϣ��Transaction_infװ�ز�������ţ� 
��1����½���ݲֿ�ORCL������transaction_inf���䴴����������£�
-- Create table
create  table  TRANSACTION_INF
(
  CARD_ID     CHAR(16),
  CUSTER_ID   CHAR(8),
  CAR_ID      CHAR(16),
  CARD_TYPE   CHAR(10),
  NAME        VARCHAR2(10),
  XF_ED       NUMBER(9),
  XF_SH       VARCHAR2(30),
  XF_ADDR     VARCHAR2(30),
  XF_DATE     DATE,
  XF_TYPE     CHAR(1),
  BQXF_LJBS   NUMBER(4),
  XF_SXF      NUMBER(9),
  XF_LX       NUMBER(9,3),
  XF_DQLV     NUMBER(5,3),
  XF_JF       NUMBER(9),
  HK_ED       NUMBER(9),
  CARD_STATUS CHAR(1)
)
tablespace TBS_CUST1;
��2���ⲿ�����ļ�transaction.datװ�ص�Ŀ���transaction_inf��SAS�������£�
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*�����������ݿ���߼���*/
LIBNAME  qh 'd:\qh'; /*�����߼���*/
%let  lj= D:\qh\transaction;/*�����ⲿ�ļ�·��*/
%let  gsm=.dat; /*�ļ���ʽ����*/
%let  filename= "&lj&gsm";
DATA  qh.transaction  (drop=xf_date_1 );  /*���ݼ��洢��ָ���߼���*/
	Infile  &filename  dlm='|'  dsd  missover  lrecl=184 ; 
input   Card_id           :$16.
        Custer_id         :$8.
        Car_id            :$16.
        Card_type         :$10.
        Name              :$10.
        Xf_ed             :9.
        Xf_sh             :$30.
        Xf_addr           :$30.
        xf_date_1         :$8.
        xf_type           :$1.
        bqXf_ljbs         :4.
        Xf_sxf            :9.
        xf_lx             :9.3
        xf_dqlv           :5.3
        xf_jf             :9.
        hk_ed             :9.
        card_status       :$1.

		        ; 
length  xf_date  8;
	if   xf_date_1<'19771231'  then  xf_date=input('19771231',anydtdte8.);
		else  do;
		 if  xf_date_1> '21001231'  then  xf_date=input('21001231',anydtdte8.);
			else   xf_date =input(xf_date_1,anydtdte8.);
	end; 
run;            
proc  append  base=qhlj.transaction_inf 
	( bulkload=no 
	  dbsastype=(
	  Xf_ed	       ='numeric'
	  xf_date	   = 'date'
	  bqXf_ljbs	     ='numeric'	  
	  xf_lx	     ='numeric'
	  xf_dqlv	   ='numeric'
	  xf_jf	   ='numeric'
	  hk_ed	   ='numeric'
	)             
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.transaction;
	run;
