prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating CARD_INFO...
create table CARD_INFO
(
  CARD_ID     CHAR(16),
  CUSTER_ID   CHAR(8),
  CARDER_ID   CHAR(16),
  CARD_TYPE   CHAR(10),
  NAME        VARCHAR2(10),
  MASTER_TYPE CHAR(1),
  BRANCH_ID   CHAR(9),
  ED          NUMBER(9),
  LS_ED       NUMBER(9),
  TZ_DATE     DATE,
  QX_ED       NUMBER(9),
  FQ_ED       NUMBER(9),
  SQHK_ED     NUMBER(9),
  SQHK_DATE   DATE,
  BQHK_ED     NUMBER(9),
  BQHK_DATE   DATE,
  QK_ED       NUMBER(9),
  QK_TYPE     CHAR(1),
  WY_DAYS     NUMBER(3),
  WY_TIMES    NUMBER(2),
  WY_FLAG     CHAR(1)
)
;

prompt Loading CARD_INFO...
insert into CARD_INFO (CARD_ID, CUSTER_ID, CARDER_ID, CARD_TYPE, NAME, MASTER_TYPE, BRANCH_ID, ED, LS_ED, TZ_DATE, QX_ED, FQ_ED, SQHK_ED, SQHK_DATE, BQHK_ED, BQHK_DATE, QK_ED, QK_TYPE, WY_DAYS, WY_TIMES, WY_FLAG)
values ('2234567892345676', '10000001', '1234567892345671', '银联      ', '蒋为明', '0', '123456789', 7000, 9000, to_date('21-07-2009', 'dd-mm-yyyy'), 4000, 3000, 3000, to_date('21-06-2009', 'dd-mm-yyyy'), 2000, to_date('21-08-2009', 'dd-mm-yyyy'), 1000, '1', 30, 2, '1');
insert into CARD_INFO (CARD_ID, CUSTER_ID, CARDER_ID, CARD_TYPE, NAME, MASTER_TYPE, BRANCH_ID, ED, LS_ED, TZ_DATE, QX_ED, FQ_ED, SQHK_ED, SQHK_DATE, BQHK_ED, BQHK_DATE, QK_ED, QK_TYPE, WY_DAYS, WY_TIMES, WY_FLAG)
values ('8234567892345673', '10000007', '1234567892345677', 'MASTER    ', '王中', '1', '234567818', 5000, 6000, to_date('23-08-2009', 'dd-mm-yyyy'), 8000, 2000, 1000, to_date('23-07-2009', 'dd-mm-yyyy'), 3000, to_date('23-09-2009', 'dd-mm-yyyy'), 0, '0', 0, 0, '0');
insert into CARD_INFO (CARD_ID, CUSTER_ID, CARDER_ID, CARD_TYPE, NAME, MASTER_TYPE, BRANCH_ID, ED, LS_ED, TZ_DATE, QX_ED, FQ_ED, SQHK_ED, SQHK_DATE, BQHK_ED, BQHK_DATE, QK_ED, QK_TYPE, WY_DAYS, WY_TIMES, WY_FLAG)
values ('9234567892345675', '10000008', '1234567892345678', 'VISA      ', '宋玉琴', '0', '312456786', 8000, 9000, to_date('20-04-2009', 'dd-mm-yyyy'), 6000, 4000, 2000, to_date('20-03-2009', 'dd-mm-yyyy'), 1000, to_date('20-05-2009', 'dd-mm-yyyy'), 0, '0', 0, 0, '0');
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
