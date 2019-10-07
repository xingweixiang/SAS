9.������Ϣ��risk_infoװ�ز�������ţ� 
��1����½���ݲֿ�ORCL������risk_info���䴴����������£�
-- Create table
create table RISK_INFO
(
  CARD_ID   CHAR(16),
  CUSTER_ID CHAR(8),
  CARDER_ID CHAR(16),
  CARD_TYPE CHAR(10),
  NAME      VARCHAR2(10),
  WY_TYPE   CHAR(1),
  QK_ED     NUMBER(9),
  QK_YX     VARCHAR2(30),
  ZD_DATE   DATE,
  ZHHK_DATE DATE,
  SJHK_DATE DATE,
  WY_DAYS   NUMBER(3)
)
tablespace TBS_CUST3;
��2���ⲿ�����ļ�risk.datװ�ص�Ŀ���risk_info��SAS�������£�
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*�����������ݿ���߼���*/
LIBNAME  qh 'd:\qh'; /*�����߼���*/
%let  lj= D:\qh\risk;/*�����ⲿ�ļ�·��*/
%let  gsm=.dat; /*�ļ���ʽ����*/
%let  filename= "&lj&gsm";
DATA  qh.risk  (drop=zd_date_1 zhhk_date_1 sjhk_date_1);  /*���ݼ��洢��ָ���߼���*/
	Infile  &filename  dlm='|'  dsd  missover ; 
/*�˴���dlm='|'�ָ���������ȡ�ָ��ļ����ļ���¼���ȳ���256��lrecl=ָ������*/
	   input   card_id      :$16.
            custer_id         :$8.
            carder_id         :$16.
            card_type         :$10.
            name              :$10.
            wy_type           :$1.
            qk_ed             :9.
            qk_yx             :$30.
            zd_date_1         :$8.
            zhhk_date_1       :$8.
            sjhk_date_1       :$8.
            wy_days           :3.


		        ; 
length  zd_date  8;
	if   zd_date_1<'19771231' then zd_date=input('19771231',anydtdte8.);
		else  do;
		 if zd_date_1> '21001231' then zd_date=input('21001231',anydtdte8.);
			else  zd_date =input(zd_date_1,anydtdte8.);
	end; 
	length  zhhk_date  8;
	if  zhhk_date_1<'19771231' then zhhk_date=input('19771231',anydtdte8.);
		else  do;
		 if  zhhk_date_1> '21001231' then zhhk_date=input('21001231',anydtdte8.);
			else  zhhk_date =input(zhhk_date_1,anydtdte8.);
	end;
	length  sjhk_date  8;
	if   sjhk_date_1<'19771231' then sjhk_date=input('19771231',anydtdte8.);
		else  do;
		 if  sjhk_date_1> '21001231' then sjhk_date=input('21001231',anydtdte8.);
			else  sjhk_date =input(sjhk_date_1,anydtdte8.);
	end; 
run;            
proc  append  base=qhlj.risk_info 
	( bulkload=no 
	  dbsastype=(
	 
	  qk_ed	           ='numeric'
	   zd_date	       = 'date'
	  zhhk_date	       = 'date'
	  sjhk_date	       = 'date'	
	  wy_days	 ='numeric'	
	)             
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.risk;
	run;
