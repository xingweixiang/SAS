10.Ӫ����Ϣ��Marketing_infoװ�ز�������ţ� 
��1����½���ݲֿ�ORCL������Marketing_info���䴴����������£�
-- Create table
create table MARKETING_INFO
(
  YX_ID       CHAR(8),
  YX_TYPE     CHAR(1),
  YX_BRANCHID CHAR(8),
  YX_ADDR     VARCHAR2(30),
  YX_NAME     VARCHAR2(10),
  YXY_ID      CHAR(8),
  YXHZ_SH     VARCHAR2(30),
  YX_CP       VARCHAR2(30),
  YX_PJ       VARCHAR2(30)
)
tablespace TBS_CUST3;
��2���ⲿ�����ļ�apply.datװ�ص�Ŀ���Marketing_info��SAS�������£�
LIBNAME  qhlj  oracle  user=chiran  password=chiran  path=orcl;
/*�����������ݿ���߼���*/
LIBNAME  qh 'd:\qh'; /*�����߼���*/
%let  lj= D:\qh\market;/*�����ⲿ�ļ�·��*/
%let  gsm=.dat; /*�ļ���ʽ����*/
%let  filename= "&lj&gsm";
DATA  qh.market;  /*���ݼ��洢��ָ���߼���*/
	Infile  &filename  dlm='|'  dsd  missover ; 
/*�˴���dlm='|'�ָ���������ȡ�ָ��ļ����ļ���¼���ȳ���256��lrecl=ָ������*/
	  input  yx_id       :$8.
           yx_type     :$1.
           yx_branchid :$8.
           yx_addr     :$30.
           yx_name     :$10.
           yxy_id      :$8.
           yxhz_sh     :$30.
           yx_cp       :$30.
           yx_pj       :$30.
		        ; 
run;            
proc  append  base=qhlj.marketing_info 
	( bulkload=no 
	nullchar=no   
	nullcharval=" "
	)                                                       
	data=qh.market;
	run;
