prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating COLLECTION_INFO...
create table COLLECTION_INFO
(
  ACCOUNT_ID CHAR(16),
  CS_ID      CHAR(10),
  ACOUNT_ID  CHAR(16),
  NAME       VARCHAR2(10),
  WY_TYPE    CHAR(1),
  QK_ED      NUMBER(9),
  QK_YX      VARCHAR2(30),
  CS_LEVEL   CHAR(1),
  CSDZ_ED    NUMBER(9),
  CS_DATE    DATE,
  SFTZ_CS    CHAR(1),
  TZCS_DATE  DATE,
  CSY_ID     CHAR(8),
  CS_NAME    VARCHAR2(10),
  CS_DAYS    NUMBER(8)
)
;

prompt Loading COLLECTION_INFO...
insert into COLLECTION_INFO (ACCOUNT_ID, CS_ID, ACOUNT_ID, NAME, WY_TYPE, QK_ED, QK_YX, CS_LEVEL, CSDZ_ED, CS_DATE, SFTZ_CS, TZCS_DATE, CSY_ID, CS_NAME, CS_DAYS)
values ('1234567892345673', '1010000011', '6234567892345673', '高为花', 'A', 1000, '忘记还款', 'D', 1000, to_date('21-06-2011', 'dd-mm-yyyy'), 'Y', to_date('21-06-2011', 'dd-mm-yyyy'), '10108768', '张风三', 26);
insert into COLLECTION_INFO (ACCOUNT_ID, CS_ID, ACOUNT_ID, NAME, WY_TYPE, QK_ED, QK_YX, CS_LEVEL, CSDZ_ED, CS_DATE, SFTZ_CS, TZCS_DATE, CSY_ID, CS_NAME, CS_DAYS)
values ('5234567892345676', '1010000012', '8234567892345676', '刘小红', 'B', 2000, '没有钱', 'C', 800, to_date('13-05-2011', 'dd-mm-yyyy'), 'N', to_date('31-12-1977', 'dd-mm-yyyy'), '10108769', '高强能', 50);
insert into COLLECTION_INFO (ACCOUNT_ID, CS_ID, ACOUNT_ID, NAME, WY_TYPE, QK_ED, QK_YX, CS_LEVEL, CSDZ_ED, CS_DATE, SFTZ_CS, TZCS_DATE, CSY_ID, CS_NAME, CS_DAYS)
values ('8234567892345671', '1010000013', '9234567892345672', '马卡凯', 'C', 10800, '恶意欠款', 'A', 0, to_date('11-07-2011', 'dd-mm-yyyy'), 'N', to_date('31-12-1977', 'dd-mm-yyyy'), '10108765', '董在山', 69);
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
