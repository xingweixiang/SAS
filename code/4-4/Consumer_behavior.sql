prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating CONSUMER_BEHAVIOR...
create table CONSUMER_BEHAVIOR
(
  CARD_ID   CHAR(16),
  CUSTER_ID CHAR(8),
  C_ID      CHAR(16),
  CARD_TYPE CHAR(10),
  NAME      VARCHAR2(10),
  XF_ED     NUMBER(9),
  XF_SH     VARCHAR2(30),
  XF_ADDR   VARCHAR2(30),
  XF_DATE   DATE,
  XF_TYPE   CHAR(1),
  XF_BS     NUMBER(4),
  DAYS_BS   NUMBER(3),
  DAYS_ED   NUMBER(9),
  MONTH_BS  NUMBER(3),
  MONTH_ED  NUMBER(9),
  YEAR_BS   NUMBER(3),
  YEAR_ED   NUMBER(9)
)
;

prompt Loading CONSUMER_BEHAVIOR...
insert into CONSUMER_BEHAVIOR (CARD_ID, CUSTER_ID, C_ID, CARD_TYPE, NAME, XF_ED, XF_SH, XF_ADDR, XF_DATE, XF_TYPE, XF_BS, DAYS_BS, DAYS_ED, MONTH_BS, MONTH_ED, YEAR_BS, YEAR_ED)
values ('8234567892345671', '10000001', '1234567892345671', '银联      ', '蒋为明', 4000, '北京华联商场', '北京', to_date('23-03-2011', 'dd-mm-yyyy'), '1', 30, 10, 600, 26, 3800, 200, 78000);
insert into CONSUMER_BEHAVIOR (CARD_ID, CUSTER_ID, C_ID, CARD_TYPE, NAME, XF_ED, XF_SH, XF_ADDR, XF_DATE, XF_TYPE, XF_BS, DAYS_BS, DAYS_ED, MONTH_BS, MONTH_ED, YEAR_BS, YEAR_ED)
values ('7234567892345677', '10000007', '1234567892345677', 'MASTER    ', '王中', 3000, '青岛大瑞发', '青岛', to_date('15-02-2011', 'dd-mm-yyyy'), '1', 20, 5, 500, 30, 2687, 300, 54679);
insert into CONSUMER_BEHAVIOR (CARD_ID, CUSTER_ID, C_ID, CARD_TYPE, NAME, XF_ED, XF_SH, XF_ADDR, XF_DATE, XF_TYPE, XF_BS, DAYS_BS, DAYS_ED, MONTH_BS, MONTH_ED, YEAR_BS, YEAR_ED)
values ('6234567892345678', '10000008', '1234567892345678', 'VISA      ', '宋玉琴', 1500, '法国家乐福', '法国', to_date('10-03-2011', 'dd-mm-yyyy'), '2', 10, 6, 300, 28, 3200, 150, 32980);
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
