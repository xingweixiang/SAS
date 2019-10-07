prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating CUST_INFO_TEMP...
create table CUST_INFO_TEMP
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

prompt Loading CUST_INFO_TEMP...
prompt Table is empty
set feedback on
set define on
prompt Done.
