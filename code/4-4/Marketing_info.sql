prompt PL/SQL Developer import file
set feedback off
set define off
prompt Creating MARKETING_INFO...
create table MARKETING_INFO
(
  YX_ID       CHAR(8),
  YX_TYPE     CHAR(1),
  YX_BRANCHID CHAR(8),
  YX_ADDR     VARCHAR2(30),
  YX_NAME     VARCHAR2(10),
  YXY_ID      CHAR(8),
  YXHZ_SH     VARCHAR2(30),
  YX_CP       VARCHAR2(30),
  YX_PJ       VARCHAR2(30)
)
;

prompt Loading MARKETING_INFO...
insert into MARKETING_INFO (YX_ID, YX_TYPE, YX_BRANCHID, YX_ADDR, YX_NAME, YXY_ID, YXHZ_SH, YX_CP, YX_PJ)
values ('12010017', 'A', '10101235', '��������', '�Ŷ�С', '10101001', '���е���', '�ʼǱ�', '�̼������ѣ��ȽϺ�');
insert into MARKETING_INFO (YX_ID, YX_TYPE, YX_BRANCHID, YX_ADDR, YX_NAME, YXY_ID, YXHZ_SH, YX_CP, YX_PJ)
values ('12010016', 'C', '10101259', '������', '������', '10221003', '��������', '�������', '�������������ܺ�');
insert into MARKETING_INFO (YX_ID, YX_TYPE, YX_BRANCHID, YX_ADDR, YX_NAME, YXY_ID, YXHZ_SH, YX_CP, YX_PJ)
values ('12010013', 'D', '10101268', 'ɽ������', '������', '10531237', '����', '������װ', '������һ��');
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
