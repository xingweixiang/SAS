prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating CUST_INFO...
create table CUST_INFO
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
;

prompt Loading CUST_INFO...
insert into CUST_INFO (CUSTER_ID, CARD_ID, NAME, SEX, ID, BIRTH, MARITAL_STATUS, XL, ZW, WORK_YEAR, ADDR_1, ADDR_2, ZONE, MOBILE, PHONE, E_MAIL, GJ, SQ_DATE, STATUS, CUST_LEVEL, CREDET_STATU, ZD_DATE, ZDYJ_ADDR, ZDYJ_FS)
values ('10000001', '1234567892345671', '��Ϊ��', 'M', '101000000000000001', to_date('23-03-1982', 'dd-mm-yyyy'), 'Y', '�о���', '��ʦ', 6, '�廪��ѧ', '�廪��ѧ2��¥1��Ԫ301', '100000', '12311100097', '010112345678', 'ylran@163.com', '����', to_date('23-04-2008', 'dd-mm-yyyy'), '0', '1', 2, to_date('08-06-2008', 'dd-mm-yyyy'), '�廪��ѧ����ѧԺ112', '1');
insert into CUST_INFO (CUSTER_ID, CARD_ID, NAME, SEX, ID, BIRTH, MARITAL_STATUS, XL, ZW, WORK_YEAR, ADDR_1, ADDR_2, ZONE, MOBILE, PHONE, E_MAIL, GJ, SQ_DATE, STATUS, CUST_LEVEL, CREDET_STATU, ZD_DATE, ZDYJ_ADDR, ZDYJ_FS)
values ('10000007', '1234567892345677', '����', 'M', '101000000000000007', to_date('29-03-1982', 'dd-mm-yyyy'), 'Y', '����', '����', 6, 'ɽ���Ƽ����޹�˾', 'ɽ������', '270000', '12311100097', '010112345678', 'llran@163.com', '�й�', to_date('23-07-2008', 'dd-mm-yyyy'), '0', '1', 2, to_date('08-04-2008', 'dd-mm-yyyy'), 'ɽ������7��¥1��Ԫ223', '1');
insert into CUST_INFO (CUSTER_ID, CARD_ID, NAME, SEX, ID, BIRTH, MARITAL_STATUS, XL, ZW, WORK_YEAR, ADDR_1, ADDR_2, ZONE, MOBILE, PHONE, E_MAIL, GJ, SQ_DATE, STATUS, CUST_LEVEL, CREDET_STATU, ZD_DATE, ZDYJ_ADDR, ZDYJ_FS)
values ('10000008', '1234567892345678', '������', 'M', '101000000000000008', to_date('11-03-1982', 'dd-mm-yyyy'), 'Y', '����', '��ʦ', 6, 'ɽ����ѧ', 'ɽ����ѧ����ѧԺ', '270000', '12311100097', '010112345678', 'zlran@163.com', '�й�', to_date('23-03-2008', 'dd-mm-yyyy'), '0', '1', 2, to_date('08-04-2008', 'dd-mm-yyyy'), 'ɽ����ѧ2��¥8��Ԫ133', '1');
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
