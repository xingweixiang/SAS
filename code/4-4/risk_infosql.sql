prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating RISK_INFO...
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
;

prompt Loading RISK_INFO...
insert into RISK_INFO (CARD_ID, CUSTER_ID, CARDER_ID, CARD_TYPE, NAME, WY_TYPE, QK_ED, QK_YX, ZD_DATE, ZHHK_DATE, SJHK_DATE, WY_DAYS)
values ('1004567872365618', '10000012', '1234567892341669', '1         ', '懂轻轻', 'A', 3980, '忘记还款', to_date('08-03-2011', 'dd-mm-yyyy'), to_date('26-04-2011', 'dd-mm-yyyy'), to_date('29-04-2011', 'dd-mm-yyyy'), 12);
insert into RISK_INFO (CARD_ID, CUSTER_ID, CARDER_ID, CARD_TYPE, NAME, WY_TYPE, QK_ED, QK_YX, ZD_DATE, ZHHK_DATE, SJHK_DATE, WY_DAYS)
values ('1004567872365616', '10000011', '1234567892341665', '2         ', '马东风', 'C', 6500, '恶意欠款', to_date('12-06-2011', 'dd-mm-yyyy'), to_date('12-07-2011', 'dd-mm-yyyy'), to_date('23-08-2011', 'dd-mm-yyyy'), 35);
insert into RISK_INFO (CARD_ID, CUSTER_ID, CARDER_ID, CARD_TYPE, NAME, WY_TYPE, QK_ED, QK_YX, ZD_DATE, ZHHK_DATE, SJHK_DATE, WY_DAYS)
values ('1004567872365612', '10000016', '1234567892341663', '0         ', '古天月', 'B', 7800, '没有钱', to_date('09-05-2011', 'dd-mm-yyyy'), to_date('18-06-2011', 'dd-mm-yyyy'), to_date('16-09-2011', 'dd-mm-yyyy'), 26);
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
