6.������Ϣ��collection_infoװ�ز�������ţ� 
��1����½���ݲֿ�ORCL������collection_info���䴴����������£�
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
��2���ⲿ�����ļ�collection.datװ�ص�Ŀ���collection_info��SAS�������£�
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*�����������ݿ���߼���*/
LIBNAME  qh  'd:\qh'; /*�����߼���*/
%let  lj= D:\qh\collection;/*�����ⲿ�ļ�·��*/
%let  gsm=.dat; /*�ļ���ʽ����*/
%let  filename= "&lj&gsm";
DATA  qh.collection  (drop=cs_date_1 tzcs_date_1);  /*���ݼ��洢��ָ���߼���*/
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
