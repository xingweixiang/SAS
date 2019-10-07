prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating APPLY_CREDIT...
create table APPLY_CREDIT
(
  APLICATION_BH   CHAR(8),
  APPLICATION_DTE DATE,
  APL_NAME        VARCHAR2(10),
  BIRTH_DTE       DATE,
  SEX             CHAR(1),
  ZJ_TYPE         CHAR(1),
  ZJ_ID           VARCHAR2(18),
  EDUCATION       VARCHAR2(10),
  MARR_STATUS     CHAR(1),
  MOBILE          CHAR(11),
  XZ_ADDR         VARCHAR2(30),
  PHONE           VARCHAR2(12),
  WORK_DW         VARCHAR2(30),
  XZ_WORK_Y       INTEGER,
  ZC              VARCHAR2(16),
  YEAR_EARN       NUMBER(9),
  GZ_YEAR         NUMBER(2),
  SQ_ED           NUMBER(9),
  FATHER          VARCHAR2(10),
  MOTHER          VARCHAR2(10),
  FM_PHONE        VARCHAR2(12),
  ZX              CHAR(1),
  SP_BH           CHAR(8),
  SP_NAME         VARCHAR2(8),
  PF_VALUE        INTEGER,
  PF_JG           CHAR(1),
  JY_ED           NUMBER(9)
)
;

prompt Loading APPLY_CREDIT...
insert into APPLY_CREDIT (APLICATION_BH, APPLICATION_DTE, APL_NAME, BIRTH_DTE, SEX, ZJ_TYPE, ZJ_ID, EDUCATION, MARR_STATUS, MOBILE, XZ_ADDR, PHONE, WORK_DW, XZ_WORK_Y, ZC, YEAR_EARN, GZ_YEAR, SQ_ED, FATHER, MOTHER, FM_PHONE, ZX, SP_BH, SP_NAME, PF_VALUE, PF_JG, JY_ED)
values ('12300101', to_date('09-08-2011', 'dd-mm-yyyy'), '���·�', to_date('23-06-1981', 'dd-mm-yyyy'), 'm', '0', '88991236', '����', 'N', '13111234567', '����������', '010-61234567', '�����廪��ѧ', 5, '����', 100000, 8, 6000, '���췢', '������', '010-1235678', '0', '12345678', '���·�', 80, '3', 8000);
insert into APPLY_CREDIT (APLICATION_BH, APPLICATION_DTE, APL_NAME, BIRTH_DTE, SEX, ZJ_TYPE, ZJ_ID, EDUCATION, MARR_STATUS, MOBILE, XZ_ADDR, PHONE, WORK_DW, XZ_WORK_Y, ZC, YEAR_EARN, GZ_YEAR, SQ_ED, FATHER, MOTHER, FM_PHONE, ZX, SP_BH, SP_NAME, PF_VALUE, PF_JG, JY_ED)
values ('12300102', to_date('10-08-2011', 'dd-mm-yyyy'), '��С��', to_date('21-11-1983', 'dd-mm-yyyy'), 'm', '1', '101025198311215816', '�о���', 'N', '18723456789', 'ɽ���ൺ', '0532-1234567', '�ൺ��ѧ', 8, '��ʦ', 80000, 11, 5000, '����ҵ', '������', '0532-2345678', '0', '12345679', '����', 70, '2', 6000);
insert into APPLY_CREDIT (APLICATION_BH, APPLICATION_DTE, APL_NAME, BIRTH_DTE, SEX, ZJ_TYPE, ZJ_ID, EDUCATION, MARR_STATUS, MOBILE, XZ_ADDR, PHONE, WORK_DW, XZ_WORK_Y, ZC, YEAR_EARN, GZ_YEAR, SQ_ED, FATHER, MOTHER, FM_PHONE, ZX, SP_BH, SP_NAME, PF_VALUE, PF_JG, JY_ED)
values ('12300103', to_date('07-08-2011', 'dd-mm-yyyy'), 'ʢ����', to_date('16-03-1978', 'dd-mm-yyyy'), 'f', '1', '380029197803163128', '��ʿ', 'Y', '13412367890', '����������', '010-81234569', '���������о���', 7, '�߼�����ʦ', 120000, 9, 8000, 'ʢ��ΰ', '������', '010-45678912', '0', '12345676', '����', 65, '0', 3000);
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
