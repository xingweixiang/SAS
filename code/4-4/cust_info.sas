1.�ͻ���Ϣ��cust_infoװ�ز�������ţ� 
��1�����ȵ�½���ݲֿ�ORCL������cust_info���䴴����������£�
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
��ע�⡿�����������Ҫ��tablespace ��Ӧ��ռ�TBS_CUST1���ɶ����Լ������ݲֿ��Ӧ�ı�ռ䡣
��2���ⲿ�����ļ�Cust.datװ�ص�Ŀ���cust_info��SAS�������£�
  LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*�����������ݿ���߼���*/
LIBNAME  qh  'd:\qh'; /*�����߼���*/
%let  lj= D:\qh\cust;/*�����ⲿ�ļ�·��*/
%let  gsm=.dat; /*�ļ���ʽ����*/
%let  filename= "&lj&gsm";
DATA  qh.custinf  (drop=birth_1 sq_date_1 zd_date_1 );  /*���ݼ��洢��ָ���߼���*/
	Infile  &filename  dlm='|'  dsd  missover  lrecl=269 ; 
/*�˴���dlm='|'�ָ���������ȡ�ָ��ļ����ļ���¼���ȳ���256��lrecl=ָ������*/
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
