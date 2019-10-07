prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating CUST_INTEGRAL...
create table CUST_INTEGRAL
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
;

prompt Loading CUST_INTEGRAL...
insert into CUST_INTEGRAL (CARD_ID, CUSTER_ID, CA_ID, NAME, BZ_TYPE, XF_ED, JF_TYPE, JF, JFJS_RULE, BQDH_JF, BQ_JF, DH_LX, BQJL_JF, BQJL_YX)
values ('3234567892345629', '10120012', '7234567892345672', '杨新雨', 'B', 8000, '1', 19000, 1, 300, 16000, 'w', 0, '无奖励');
insert into CUST_INTEGRAL (CARD_ID, CUSTER_ID, CA_ID, NAME, BZ_TYPE, XF_ED, JF_TYPE, JF, JFJS_RULE, BQDH_JF, BQ_JF, DH_LX, BQJL_JF, BQJL_YX)
values ('1234567892345612', '10103013', '6234567892345675', '赵小东', 'W', 9000, '2', 10000, 2, 100, 9000, 'm', 300, '客护生日');
insert into CUST_INTEGRAL (CARD_ID, CUSTER_ID, CA_ID, NAME, BZ_TYPE, XF_ED, JF_TYPE, JF, JFJS_RULE, BQDH_JF, BQ_JF, DH_LX, BQJL_JF, BQJL_YX)
values ('6234567892345683', '10105016', '3234567892345671', '王东于', 'B', 90800, '1', 21000, 1, 50, 181600, 'w', 100, '节日刷卡消费');
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
