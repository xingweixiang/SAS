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