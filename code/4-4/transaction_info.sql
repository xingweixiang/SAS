prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating TRANSACTION_INF...
create table TRANSACTION_INF
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
;

prompt Loading TRANSACTION_INF...
insert into TRANSACTION_INF (CARD_ID, CUSTER_ID, CAR_ID, CARD_TYPE, NAME, XF_ED, XF_SH, XF_ADDR, XF_DATE, XF_TYPE, BQXF_LJBS, XF_SXF, XF_LX, XF_DQLV, XF_JF, HK_ED, CARD_STATUS)
values ('8234567892345671', '10000001', '1234567892345671', '银联      ', '蒋为明', 4000, '北京华联商场', '北京', to_date('23-03-2011', 'dd-mm-yyyy'), '1', 30, 0, 15.3, .35, 300, 3000, '1');
insert into TRANSACTION_INF (CARD_ID, CUSTER_ID, CAR_ID, CARD_TYPE, NAME, XF_ED, XF_SH, XF_ADDR, XF_DATE, XF_TYPE, BQXF_LJBS, XF_SXF, XF_LX, XF_DQLV, XF_JF, HK_ED, CARD_STATUS)
values ('7234567892345677', '10000007', '1234567892345677', 'MASTER    ', '王中', 3000, '青岛大瑞发', '青岛', to_date('15-02-2011', 'dd-mm-yyyy'), '1', 20, 10, 0, .25, 200, 2000, '0');
insert into TRANSACTION_INF (CARD_ID, CUSTER_ID, CAR_ID, CARD_TYPE, NAME, XF_ED, XF_SH, XF_ADDR, XF_DATE, XF_TYPE, BQXF_LJBS, XF_SXF, XF_LX, XF_DQLV, XF_JF, HK_ED, CARD_STATUS)
values ('6234567892345678', '10000008', '1234567892345678', 'VISA      ', '宋玉琴', 1500, '法国家乐福', '法国', to_date('10-03-2011', 'dd-mm-yyyy'), '2', 15, 30, 23.6, .26, 150, 1500, '0');
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
