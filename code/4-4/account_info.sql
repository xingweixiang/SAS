prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating ACCOUNT_INFO...
create table ACCOUNT_INFO
(
  CUSTER_ID  CHAR(8),
  ACCOUNT_ID CHAR(16),
  CARD_ID    CHAR(16),
  CARD_TYPE  CHAR(10),
  NAME       VARCHAR2(10),
  ZD_DATE    DATE,
  BRANCH_ID  CHAR(9),
  OPEN_DATE  DATE,
  ZH_STATUS  NUMBER(1),
  STATUS     CHAR(1),
  CARD_LEVEL CHAR(1),
  HY_FLAG    CHAR(1),
  EV_ED      NUMBER(9),
  KX_DAYS    NUMBER(4)
)
;

prompt Loading ACCOUNT_INFO...
insert into ACCOUNT_INFO (CUSTER_ID, ACCOUNT_ID, CARD_ID, CARD_TYPE, NAME, ZD_DATE, BRANCH_ID, OPEN_DATE, ZH_STATUS, STATUS, CARD_LEVEL, HY_FLAG, EV_ED, KX_DAYS)
values ('10000001', '2234567892345676', '1234567892345671', '银联      ', '蒋为明', to_date('08-06-2008', 'dd-mm-yyyy'), '123456789', to_date('21-05-2008', 'dd-mm-yyyy'), 0, '0', '0', '1', 3000, 26);
insert into ACCOUNT_INFO (CUSTER_ID, ACCOUNT_ID, CARD_ID, CARD_TYPE, NAME, ZD_DATE, BRANCH_ID, OPEN_DATE, ZH_STATUS, STATUS, CARD_LEVEL, HY_FLAG, EV_ED, KX_DAYS)
values ('10000007', '8234567892345673', '1234567892345677', 'MASTER    ', '王中', to_date('08-04-2008', 'dd-mm-yyyy'), '234567818', to_date('23-08-2008', 'dd-mm-yyyy'), 1, '1', '0', '0', 2000, 53);
insert into ACCOUNT_INFO (CUSTER_ID, ACCOUNT_ID, CARD_ID, CARD_TYPE, NAME, ZD_DATE, BRANCH_ID, OPEN_DATE, ZH_STATUS, STATUS, CARD_LEVEL, HY_FLAG, EV_ED, KX_DAYS)
values ('10000008', '9234567892345675', '1234567892345678', 'VISA      ', '宋玉琴', to_date('08-04-2008', 'dd-mm-yyyy'), '312456786', to_date('26-04-2008', 'dd-mm-yyyy'), 0, '0', '1', '3', 4000, 60);
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
