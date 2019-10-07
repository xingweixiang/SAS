# SAS
=========
## 说明
     个人学习记录，有需要原数据学习的可私下联系我 245130833@qq.com
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
	    * [7、summary过程](#7summary过程)
	    * [8、compare过程](#8compare过程)
	    * [9、datasets过程](#9datasets过程)
	    * [10、surveyselect抽样过程](#10surveyselect抽样过程)
	    * [11、format过程](#11format过程)
	    * [12、sort过程](#12sort过程)
	* [三、统计分析](#三统计分析)
	    * [1、描述性统计](#1描述性统计)
	    * [2、方差分析](#2方差分析)
	    * [3、相关分析](#3相关分析)
	    * [4、回归分析](#4回归分析)
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
### 7、summary过程
- summary过程，主要用来对数值变量计算单个变量的基本统计量，使用语句与means过程类似
- 实例内容：学校学生体检数据的分析
```
Data students; 
Input group age height weight sex $ ;
Cards; 
2 35 162 42 f 
1 31 173 43 m 
2 42 156 56 f 
1 53 152 39 f 
1 42 173 63 m 
1 28 165 55 f 
2 33 157 66 f 
2 17 162 46 f 
1 16 173 45 m 
1 25 180 66 m 
; 
RUN;
/*调用 sort过程首先对数据集排序*/
PROC sort data=students; 
by group ; /*; by 分组变量名串; 对by 变量的值排序(字母升序)*/ 
/*调用summary过程*/
PROC Summary data=students mean std n max min range stderr cv ; 
/*指定统计关键量mean求均值，std*/
var age height weight; /*指定分析变量*/
class sex; /*指定分类变量，class 产生三类: 不分fm(以空白显示)及 f,m */ 
by group ;/*by指定分组变量，产生二类:1,2 以上二行语句分成6 个水平组合进行统计*/ 
output out=stu_analy ; 
PROC print data=stu_analy; /*打印分析结果*/
RUN; 
```
### 8、compare过程
- compare过程，主要用来比较两个数据集的内容
- 实例内容：比较学生信息数据集stu1和stu2的差异
```
 Data stu1; 
Input  group  age  height  weight  sex $ ;
Cards; 
2 35 162 42 f 
1 31 173 43 m 
2 42 156 56 f 
1 53 152 39 f 
; 
RUN;
Data  stu2; 
Input  group2  age  height  weight  sex  $ ;
Cards; 
2 35 162 42 f 
1 31 173 43 m 
2 42 156 56 f 
; 
RUN;
PROC  compare  base=stu1  c=stu2  out=cy  brief;/*brief选项打印差异摘要信息*/
Var  group;
With  group2;
RUN;
```
### 9、datasets过程
- datasets过程，主要用来对SAS逻辑库中的SAS文件进行列表、复制、换名、添加和删除等操作。具有append过程、contents过程和copy过程的功能
- 实例内容：删除逻辑库jx中的表afmsg和adomsg
```
 libname jx 'd:\jx\test';
PROC DATASETS library=jx memtype=data;
    delete afmsg adomsg;/*把jx逻辑库中的数据集afmsg和adomsg删除*/
QUIT;
```
### 10、surveyselect抽样过程
- surveyselect抽样过程，常用的抽样有单纯随机抽样、系统抽样、分层抽样、整群抽样等
- 实例内容：从1万个样本中按随机数100抽取数据，选择简单随机抽样
```
DATA  sj ;
Do  i = 1  to 10000 ;
output ;
end ;
RUN;
/*随机抽样*/
PROC  surveyselect 
      data =sj
      method = srs 
      n = 100 
      out=cysj  seed =100;
RUN;
```
### 11、format过程
- format过程，主要用来定义数值或符号文字的输出和输入格式
- 实例内容：学生成绩显示应用，小于60分显示不及格，大于等于60分小于80分为良好，大于等于80分为优秀
```
PROC format;
value scor_desc  0-<60='不及格' 
            60-<80='良好'
            other='优秀';
		  RUN;
		DATA stu_score;
		input id name $ score;
		cards;
		1001 高宏 58
		1002 马小名 60
		1003 刘晓华 80
		1004 董青青 90
		1005 杨峰 78
		;
		RUN;
/*打印过程调用format过程定义的类型，通过foramt语句引用类型*/
PROC PRINT DATA=stu_score;
format score scor_desc.;/*format语句引用format过程定义的类型*/
RUN;
```
### 12、sort过程
- sort过程，将数据集中某一个变量或几个变量按升序或降序重新排列，并把结果存储到输出数据集中
- 实例内容：去除学生数据集中姓名相同的记录，并按姓名降序排列，输出到数据集st_order
```
DATA stu;
input id name $ score;
    cards;
    1001 高宏 58
    1002 马小名 60
    1003 刘晓华 80
    1004 董青青 90
    1005 杨峰 78
    1006 杨峰 98
    1003 刘晓华 80
    ;
    RUN;
/*SORT过程通过noduprecs 去除完全相同的记录，结果输出到数据集stu_order*/
PROC sort data=stu out=st_order noduprecs ;
by descending name;
RUN;
```
### 三、统计分析
### 1、描述性统计
- 实例内容：调查某个地区50个人的年收入情况，求出年收入最小值、最大值、均值和全距。利用means过程进行简单的描述性统计
```
*对外部数据处理;
%let  path= D:\jx\sr;  /*定义外部文件路径*/
%let  type=.txt;
%let  fil= "&path&type";
LIBNAME  jx 'd:\jx';  /*定义逻辑库*/
DATA  jx.sr;  /*数据集存储到指定逻辑库*/
	Infile  &fil  ; 
	input  id  :$4. year_money ;
RUN;
PROC means data=jx.sr min max mean range; /*统计关键字min、max、mean和range*/
 var year_money;/*指定分析变量*/
RUN;
```
- 分析结论：根据means过程统计分析输出，可看出此调查数据中全距比较大，用年收入均值不能反映出某地区的年收入均值，应用众数最好
- 实例内容：根据地区分析刷卡交易年违约情况
```
*对外部数据处理;
%let  path= D:\jx\weiyue;  /*定义外部文件路径*/
%let  type=.txt;
%let  fil= "&path&type";
LIBNAME  jx 'd:\jx';  /*定义逻辑库*/
DATA  jx.weiyue;  /*数据集存储到指定逻辑库*/
	Infile  &fil dlm='|'  dsd  missover; 
	input   diqu  :$4. year  :4. times :5. description :$30. ;
RUN;
*各区属各年伤害信用违约次数;
proc freq data=jx.weiyue formchar(1,2,7)='|-+' ;
table year*times/ nopct ;
run;
```
### 2、方差分析
方差分析是检验两个或两个以上样本均数差异是否具有统计意义的一种
- 实例内容：研究正常人体重与非正常人体重的差异
```
*对外部数据处理;
%let  path= D:\jx\sg_tz;  /*定义外部文件路径*/
%let  type=.txt;
%let  fil= "&path&type";
LIBNAME  jx 'd:\jx';  /*定义逻辑库*/
DATA  jx.sg_tz;  /*数据集存储到指定逻辑库*/
	Infile  &fil dlm='|'  dsd  missover; 
	input  group  :1. sg  :3. tz :8. ;
RUN;
/*调anova过程分析*/
PROC anova data=jx.sg_tz;
class group;
model tz=group;
RUN;
means group/duncan;
RUN;
QUIT;
```
- 分析结论：从输出结果看变量group的F值，F=12.75，P=0。0031<0.01，可以得出两组体重有显著性差异
### 3、相关分析
相关分析是为了检验分析变量之间是否存在某种联系，以及变量之间联系的密切程度，其联系的密切程序通过相关系数衡量。在医学、经济领域以及产品检验领域经常用到
- 实例内容：研究遗传学身高，测量20名学生的身高与其父母的身高数据
```
*对外部数据处理;
%let  path= D:\jx\shengao;  /*定义外部文件路径*/
%let  type=.txt;
%let  fil= "&path&type";
LIBNAME  jx 'd:\jx';  /*定义逻辑库*/
DATA  jx.shengao;  /*数据集存储到指定逻辑库*/
	Infile  &fil dlm='|'  dsd  missover; 
	input  haizi :4. father  :4. mother :4.;
RUN;
/*调corr过程分析*/
PROC corr data=jx.shengao nosimple;
var father mother haizi;
RUN;
```
- 分析结论：通过分析可以看出孩子的身高与父母的身高是正相关的
### 4、回归分析
回归分析是对具有相关关系的两个或两个以上变量之间的依存关系进行测定，通过自变量的变化预测因变量的变化趋势
- 实例内容：根据客户购买电子产品的数据分析哪类人员购买电子产品比较多，以便于营销人员有针对性的推广
```
*对外部数据处理;
%let  path= D:\jx\dianzi;  /*定义外部文件路径*/
%let  type=.txt;
%let  fil= "&path&type";
LIBNAME  jx 'd:\jx';  /*定义逻辑库*/
DATA  jx.dianzi;  /*数据集存储到指定逻辑库*/
	Infile  &fil ; 
/*文件记录长度超过256用lrecl=指定长度*/
input  id $ name $ education  yincome  work_period goumai_days goumai_type; 
label goumai_type='购买标识' ;
RUN;
PROC logistic data=jx.dianzi desc;/*逻辑回归分析，降序排列目标变量*/
     model goumai_type=education yincome work_period /noint
               selection=stepwise
               sle=0.2
               sls=0.1
               details
               stb;
    output out=jx.goumai_analy;  /*指定输出分析结果到存储目录数据集*/
RUN;
```
- 分析结论：从输出结果分析可以看出教育、工作年限和年收入这三个自变量参数可以用来判断哪些客户经常购买电子产品、对这历低、工作年限时间不长、年收入低的客户建议不做推广销售。
