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
values ('12010017', 'A', '10101235', '北京分行', '张东小', '10101001', '大中电器', '笔记本', '刺激了消费，比较好');
insert into MARKETING_INFO (YX_ID, YX_TYPE, YX_BRANCHID, YX_ADDR, YX_NAME, YXY_ID, YXHZ_SH, YX_CP, YX_PJ)
values ('12010016', 'C', '10101259', '天津分行', '刘春国', '10221003', '苏宁电器', '数码相机', '消费量大增，很好');
insert into MARKETING_INFO (YX_ID, YX_TYPE, YX_BRANCHID, YX_ADDR, YX_NAME, YXY_ID, YXHZ_SH, YX_CP, YX_PJ)
values ('12010013', 'D', '10101268', '山东分行', '高庆美', '10531237', '华联', '冬季服装', '消费量一般');
commit;
prompt 3 records loaded
set feedback on
set define on
prompt Done.
