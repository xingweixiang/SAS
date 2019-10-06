# SAS

## 目录
* [SAS](#SAS)
	* [一、SAS数据步](#一SAS数据步)
		* [1、SET语句](#1SET语句)
		* [2、MERGE语句](#2MERGE语句)
		* [3、数据集](#3数据集)
		* [4、oracle数据处理](#4oracle数据处理)
	* [二、SAS过程步](#二SAS过程步)
	    * [1、print过程](#1print过程)
	    * [2、means过程](#2means过程)
	    * [3、copy过程](#3copy过程)
	    * [4、SQL过程](#4SQL过程)
	    * [5、report过程](#5report过程)
	    * [6、freq过程](#6freq过程)
### 一、SAS数据步
数据步以data为开始，run为结束标志。
### 1、SET语句
- SET语句用在数据步，从一个或几个已经存在的数据集中读取数据，对生成的一个或多个数据集进行处理，可对多个数据集进行复制或纵向合并<br>
- 实例内容：对数据集students处理，取students数据集中的一条记录，保留字段name、sex、address，生成数据集stu
```
DATA  stu; 
Set  students  (keep=name  sex  address  obs=1 ) ;
/* Set语句读数据集students,括号内keep=选项语句取保留的字符，obs=1取数据集的第一条记录*/
RUN;
```
### 2、MERGE语句
- MERGE语句将两个或多个数据集进行模向合并<br>
- 实例内容：学生信息表inf_stu，学生成绩表score_stu，需求需要得到一个学生信息与成绩的数据集inf_score，保留字段为id(学号)、姓名和总成绩
```
DATA   inf_stu;
length   address $30.; 
/*对应字符类型的变量其长度超过默认长度8个字符要通过length语句先定义变量*/
input  id  name $  sex $  class  address;/*定义变量，其中address为length语句中定义好的变量*/
cards;/*读cards 后的数据*/
1001 高溪红 F 1 北京市西城区广外大街
1002 张明明 M 2 北京市东城区
; 
RUN; 
DATA   score_stu;
input  id  score;
cards;
1001 600
1002 890 
; 
RUN; 
PROC sort  data=inf_stu; /*对数据集排序*/
by  id;
RUN; 
PROC sort  data=score_stu;/*对数据集排序*/
by  id;
RUN; 
*根据学号横向合并数据集inf_stu和score_stu，生成数据集inf_score;
DATA  inf_score(keep=id name score);/*keep=语句取保留字段*/
merge  inf_stu  score_stu;
by  id;  /*根据学号横向合并*/
RUN;
```
### 3、数据集
- 实际开发中业务需求需要对各类数据综合处理，而不是单独的，简单的数据处理<br>
- 实例内容：数据集条件过滤
```
%let   dir= 'd:\jx\custer.dat';
filename   sj  "(&dir)";
LIBNAME  jx   'd:\jx';
DATA  jx.card138;
           infile   sj dsd missover;   
       input  @20   card_type  $3. 
              @; /*行控制指针符号，使数据取到card_type之后执行下面if语句，做判断*/
        if  card_type='138'  then do;   /*取card_type='138'类型的条件数据*/
           input  @1  qh     $3.					
                  @4  card_nm  $16.
				  @23 name $8. 
				  @31 address :$20.
	              ;
	 	           output  jx.card138;
		           end;
RUN;
PROC print  noobs;/*打印输出窗口不显示标号*/
RUN;
```
### 4、oracle数据处理
- 实际开发中SAS系统经常与oracle关系数据库交互应用<br>
- 实例内容：通过SAS程序处理rd_fgwj.dat外部文件，并装载到oracle数据库目标表rd_test中
```
%let   dir= 'd:\jx\inf_cust.dat';/*文件存储路径宏变量*/
filename   sj  "(&dir)";/*定义逻辑文件名*/
libname csj 'd:\jx';/*定义存储数据集逻辑库*/
%macro loadfile(v_lib);/*宏过程开始，并定义宏变量*/
  DATA &v_lib.inf_custer;
        infile sj firstobs=2 end=final LENGTH=length;/*firstobs=2表示从文件第二条数据开始读取*/
         input @1 qh 3.
               @4 card_nm $16.
               @20 card_type $3.
               @23 name $8.
               @31 address :$20.
			   ;      
  RUN;
%mend;
%loadfile(csj.);/*调宏过程，传实参逻辑库名，注意这里实参传逻辑库名加个.*/
```
### 二、SAS过程步
过程步对所调用的过程进行辅助分析，通过对过程语句的选择，使分析和处理数据集的功能更强大。
### 1、print过程
- print过程属于打印输出过程，一般用print过程查看生成的数据集<br>
- 实例内容：打印输出学生数据集中各科成绩都大于80分的学生信息
```
DATA score;
input id name $ class math english chinese;
cards;
1001 高名 1 89.2 78.3 89
1002 仲小海 1 76 99 78
1003 刘海洋 1 88 56 66
1004 杨小帅 1 99 89 98
1005 赵小红 1 87 86 83
1006 马西瑞 1 89 58 43
;
RUN;
/*过程步调用print过程打印输出各科成绩都大于80分的学生信息*/
PROC print data=score noobs;
where math>80 and english>80 and chinese>80;
/*where条件语句，and语句表示且，三者都符合才取出数据打印输出*/
title '各科成绩大于80分的学生信息';
/*title语句指定标题*/
RUN; 
```
### 2、means过程
- means过程是SAS提供的一个数据汇总统计过程，提供单个或多个变量的简单描述统计分析<br>
- 实例内容：某奶厂用自动装奶机装奶，在装奶机正常工作时，每瓶奶净重450G，某日随机抽取了10瓶成品，称重分别为452 436 447 439 445 460 442 456 447 440，请问这时的装奶机是否正常工作？
- 分析：若装奶机正常，当前已经装奶的全部净重与450G无统计意义差异。将分析变量的值减去正常值，得到一组新样本，做均值为零的T检验。
```
DATA tcheck;
input milck @@;
milck=milck-450;/*与正常值的差*/
cards;
452 436 447 439 445 460 442 456 447 440
;
RUN;
/*调用means过程进行T检验*/
PROC means data=tcheck t prt;/*T检验*/
RUN;
```
- 结论：T检验中p=0.1737>0.05，假设成立，因此装奶机正常
### 3、copy过程
- copy过程可以复制一个逻辑库下的所有数据集到另一个逻辑库下或者从一个文件复制到另一个文件，也可以有选择地复制逻辑库下的数据集。<br>
- 实例内容：复制jx逻辑库中的数据集stu和stu2到逻辑库mb中，并从sy逻辑库删除stu和stu2数据集
```
libname jx 'd:\jx';/*创建源逻辑库*/
libname sy 'd:\test';/*创建目标逻辑库*/
data jx.stu;
input id name $ class;
cards;
1001 晚上 1
1002 白天 1
;
run;
data jx.stu2;
input id name $ class;
cards;
1001 李三 2
1002 张四 2
;
run;
/*调用copy过程复制数据集到目标逻辑库*/
PROC copy in=jx out=sy move;
/*in=指定源逻辑库名，out=目标逻辑库名,move选择指定复制成功从源逻辑库删除复制的数据集*/
select stu stu2;
/*选择复制的数据集名*/
run;
```
### 4、SQL过程
- SQL过程，相当于数据库里的存储过程，可以对数据集或关系数据库的表进行查询、修改，实现创建表、删除数据、插入数据和更新数据等功能<br>
- 实例内容：查询学生成绩数据集stu_score，语文成绩大于60分小于80分的显示及格，大于等于80分的显示优秀，其他显示不及格；数学成绩大于60分小于80分的显示及格，大于等于80分的显示优秀，其他显示不及格；英语成绩大于60分小于80分的显示及格，大于等于80分的显示优秀，其他显示不及格。
```
DATA stu_score;
input id name $ chinese math english;
cards;
1001 张三 58 78 90
1002 李四 78 38 88
1003 刘务华 89 90 87
1004 董小 60 80 52
1005 杨三 38 45 51
1006 张信 99 89 87
;
RUN;
/*调用sql过程，通过case when语句实现*/
PROC sql;
select name as 姓名,(case when chinese>=80 then '优秀' 
                  when chinese>=60 then '及格'
				     else '不及格' end) as 语文,
			 (case when math>=80 then '优秀' 
                  when math>=60 then '及格'
				     else '不及格' end) as 数学,
			(case when english>=80 then '优秀' 
                  when english>=60 then '及格'
				     else '不及格' end) as 英语
	from stu_score;
	QUIT;
```
### 5、report过程
- report过程，是制作报表的工具，将print、means和tabulate过程的特点与DATA步报告写法的特点结合起来组合成了一个强大的生成报表的工具<br>
- 实例内容：房价经济指数数据，环比与同比、定基数据生成报表
```
libname re 'd:\jx';
data re.house;
input city $ hb_index same_index def_index;
cards;
北京 99.9 100.3 102.4
天津 99.8 100.2 103.1 
秦皇岛 99.8 100.5 106.3 
石家庄 99.7 101.3 107.7 
包头 99.8 100.0 103.9 
太原 100.0 100.9 101.7  
;
RUN;
proc print data=re.house;
run;
/*调用report过程生成报表*/
PROC report data=re.house headline headskip;
title '六个大中城市住宅销售价格指数 (2012年2月)';
title2 '单月城市销售价格';
column city hb_index same_index def_index dif;
define city /order format=$6. width=6 '城市';
define hb_index/display format=5.1 width=5 '环比';
define same_index/display format=5.1 width=5 '同比';
define def_index/display format=5.1 width=5 '定基';
define  dif/computed format=5.1 width=5 '差比';
compute dif ; 
dif=same_index-hb_index;
endcomp;
RUN;
```
### 6、freq过程
- freq过程，主要用于两个目的，一是描述分析，二是统计推断
- 实例内容：根据班级分组，求出每个班级的频数
```
libname jx 'd:\jx';
data jx.class;
input class name $ math english chiness;
cards;
1 高洪 89 78 99
1 王红与 78 45 32
1 李小心 74 72 78
2 马小名 87 98 86
2 刘小红 56 82 83
2 董西幂 88 91 92
3 杨小青 78 56 87
3 张峰余 56 78 23
3 赵晓霞 90 98 96
;
RUN;
/*调用freq过程对数据集分析*/
PROC FREQ data=jx.class;
   by class;/*按class班级分组，求出每个班级的频数*/
RUN; 
```