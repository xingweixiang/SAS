# SAS

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
	    * [5、因子分析](#5因子分析)
	    * [6、生存分析](#6生存分析)
	    * [7、聚类分析](#7聚类分析)
	    * [8、判别分析](#8判别分析)
	* [四、综合实例](#四综合实例)
	    * [1、客户流失分析](#1客户流失分析)
	    * [2、ODS输出HTML文件](#2ODS输出HTML文件)
	    * [3、信用卡交易流水提取](#3信用卡交易流水提取)
	    * [4、信用卡管理系统](#4信用卡管理系统)
	    * [5、评分卡模型开发](#5评分卡模型开发)
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
### 5、因子分析
因子分析是指研究从变量群中提取共性因子的统计技术，因子分析主要应用在社会学、经济学、心理学和医学等领域中
- 实例内容：通过人的健康状况、教育程度、人均国民收入等指标，去衡量一个国家或地区的社会发展总体状况以及国民生活质量的总水平
```
DATA Human_e;
title "国民生活质量人文与经济指标分析";
input area $ Human_e1-Human_e5 ;
cards;
上海 10827 23019148 11.6 15258 74
天津 10399 12938224 10.3 7979 76
北京 10377 19612368 12.6 18300 75
江苏 7779 78659903 8.2 5817 76
浙江 7524 54426891 8.3 9279 70
内蒙 6978 24706321 7.5 3518 73
广东 6440 104303132 8.9 7482 72
辽宁 6232 43746323 7.3 4448 75 
山东 6040 95793065 8.1 3919 73
福建 5900 36894216 8.3 6250 74
;
RUN;
/*因子分析过程调用*/
PROC factor data=Human_e nfactors=3 score out=analy_hum_e;
RUN;
```
- 分析结论：从输出结果分析推断出人均GDP、房价和预期寿命是影响国民人文与经济满意度的主要原因，需要加强改善这些指标，以便于提高国民生活质量
### 6、生存分析
生存分析主要应用在医学、生物学、保险学、可靠性工程学、社会学、经济学等方面。是对生存资料的分析，根据试验或调查得到的数据对生物或人的生存时间进行分析和推断
- 实例内容：调取某月份销售情况数据，对某类夏服装生存期分析。
```
 DATA summer_cloth;
input t sale days;
cards;
1 30  1
2	37	2
3	42	3
4	46	4
5	48	5
6	52	6
7	67	7
8	70	8
9	32	9
10	23	10
11	10	11
12	0	12
;
RUN;
PROC lifetest data=summer_cloth method=KM plots=(s);/*method=PL/KM/LT/LIFE/ACT指定生存率估计方法*/
 time t*sale(0);/*必须语句，设置生存时间变量和生存结局变量，括号内为删失值*/
RUN;
```
- 分析结论：从输出结果分析服装退出市场11，终检1件服装占总服装数12的8.33%
### 7、聚类分析
聚类分析是研究事物分类的一种统计方法，目标是在相似的基础上收集数据来分类
- 实例内容：收集全国9省市民2011年支出情况数据汇总资料，主要涉及生活消费支出情况的8个指标
```
DATA diaocha;
input diqu $ shipin house yiliao jiaotong education;
cards;
天津 1117.72 1200.16 6000.10 800.32 6800.87 
北京 2300.12 1600.88 7898.92 1300.89 12000.56 
吉林 1020.00 780.08 5456.21 678.21 4000.32 
上海 2287.15 1889.23 8356.21 1500.23 15000.21 
江苏 1317.88 467.62 163.16 293.07 6700.21 
浙江 1838.57 798.88 326.12 496.86 8900.96 
福建 1408.54 430.14 136.40 306.06 7680.09 
山东 1100.13 560.97 1678.85 221.93 298.23 
广东 1681.68 1700.21 8700.19 900.23 12000.26 
;
RUN;
PROC cluster data =diaocha standard method =ward
    outtree =jltree  pseudo;
    copy diqu;
RUN;
PROC tree data =jltree  horizontal;
  ID diqu;
RUN;
```
### 8、判别分析
判别分析是一种进行统计鉴别和分组的技术手段
- 实例内容：农业样本抽样检验，对病菌蔬菜用1标识，非病菌蔬菜用2标识，两类样本各抽样5例化验4项指标，用逐步判别法对10个样品进行判别归类
```
DATA vegetable; 
input group v1-v4; 
cards; 
1 228 134 20 11 
1 245 134 10 40 
1 200 167 12 27 
1 170 150 7 8 
1 100 167 20 14 
2 185 115 5 19 
2 170 125 6 4 
2 165 142 5 3 
2 135 108 2 12 
2 100 117 7 2 
;
RUN;
PROC stepdisc data=vegetable; /* proc stepdisc逐步判别进行变量删选*/ 
class group; /*分组变量*/
var v1-v4;/*分析变量*/ 
RUN; 
/*输出结果保留变量集为{v2,v3,v4}*/ 
PROC discrim data=vegetable list; 
class group;/*分组变量*/ 
var v2 v3 v4;/*根据stepdisc过程选择出的变量进行变量分析*/  
RUN; 
```
- 分析结论：运用判别分析过程DISCRIM对3个指标变量v2、v3和v4进行分析，看出这3个变量对蔬菜病菌影响起到了主要的作用，应严格对这3个变量指标进行跟踪。
### 四、综合实例
### 1、客户流失分析
- 实例内容：根据信用卡客户数据分析客户流失原因
```
*对外部数据处理;
%let  path= D:\jx\lius;  /*定义外部文件路径*/
%let  type=.txt;
%let  fil= "&path&type";
LIBNAME  jx 'd:\jx';  /*定义逻辑库*/
DATA  jx.lius;  /*数据集存储到指定逻辑库*/
	Infile  &fil dlm='|'  dsd  missover; 
	input h  :$4. type  :1. times :3.;
RUN;
PROC discrim data=jx.lius list; 
class type;/*分组变量为投诉类型*/ 
var times;/*对times投诉次数分析*/  
RUN;
```
- 分析结论：根据收集的信息卡数据进行判别分析，客服服务态度差和还款不方便为客户流失的主要原因，因此只有对客服服务态度差和还款不方便两个因素采取措施，才能挽留住客户。
### 2、ODS输出HTML文件
- 实例内容：对孩子的身高与父母身高的关系进行回归分析，结果以HTML网页的方式存储到目录文件夹下
```
ods listing close;
ods results off;
ods html path='d:\jx'
         body='shengao_bo.html'(title='父母与孩子身高关系')
         contents='shengao_con.html'(title='身高分析')
         frame='shengao_fram.html'(title='父母与孩子身高公式')
         newfile=proc;
*对外部数据处理;
%let  path= D:\jx\shengao;  /*定义外部文件路径*/
%let  type=.txt;
%let  fil= "&path&type";
LIBNAME  jx 'd:\jx';  /*定义逻辑库*/
DATA  jx.shengao;  /*数据集存储到指定逻辑库*/
	Infile  &fil dlm='|'  dsd  missover; 
	input   haizi :4. father  :4. mother :4.;
RUN;
/*调corr过程分析*/
PROC corr data=jx.shengao nosimple;
var father mother haizi;
RUN;
ods html close;
ods results off;
ods listing;
```
### 3、信用卡交易流水提取
- 实例内容：从Oracle数据库交易表trans_flow中提取客户卡号为100000000000000008，时间为201207-01到2012-31期间的数据，分析客户消费行为。
```
1. SAS程序实现外部数据装载到ORACLE数据库。
*外部数据处理，生成SAS数据集;
libname  jx  oracle  user=chiran  password=chiran  path=orcl;       
%let  f1 =d:\jx\tran_flow.dat;                                  
%let  filjx = "&f1";                                            
data transflow;                                
Infile  &filjx  dlm='|'  lrecl=82  dsd  missover  ;
input  cust_id          :6.                  
      card_num        :$18.      
      name            :$10.     
      jiaoyie            :7.2     
      jiaoyi_dt         :yymmdd10.      
      jiaoyi_address   :$30.     
      jiaoyi_type      :$1.        
;
run;
*生成的SAS数据集transflow装载到ORACLE数据库目标表trans_flow;
proc  append  base=jx.trans_flow 
	( bulkload=no
	  dbsastype=(	
	   cust_id      ='NUMERIC'
	   jiaoyie        ='NUMERIC'
		jiaoyi_dt       ='DATE'     
	)
	nullchar=NO /*告诉SAS系统缺失值是以NULLCHARVAL=指定值替换*/
	nullcharval=" "
	)                                                       
	data=transflow;
	run;
2. 提取ORACLE数据仓库目标表trans_flow数据分析。
Libname  jx  oracle user=chiran password=chiran path=orcl;
proc sql noprint;
  select  begi_dt  format  50.  into  :v_begidt   from  jx.begi_end_sj;
/*查询变量日期赋值给变量v_begidt*/
  select  end_dt  format  50.  into  :v_enddt  from  jx.begi_end_sj;
/*查询变量日期赋值给变量v_enddt*/
quit;
data  trans201207;
set  jx.trans_flow;
where  &v_begidt<jiaoyi_dt<&v_enddt  and  card_num='100000000000000008';
 /*查询条件*/
run;
5. 调用过程分析。
/*调用means过程分析*/
proc  means  data=trans201207 ;
var  jiaoyie;
run;
```
- 分析：此客户月平均刷卡消费为1547.14元，最高消费额为3020.13元，最低消费额为320.13元
### 4、信用卡管理系统
- 信用卡业务发展呈现特点：1）信用卡市场规模逐步扩大 2）信用卡行业竞争激烈
- 信用卡业务面临的风险有：信用风险、操作风险、欺诈风险等
- 信用卡客户管理数据仓库系统的主要功能是利用业务系统所积累的有关信用卡客户的各类数据来获取信息，从各系统提取数据装载到目标数据仓库中，为前端应用层提供联机分析的数据，满足不同的分析需求。
- ETL层数据处理：以客户为中心的信用卡管理系统数据仓库的数据来自OLTP（联机事物处理）、外部数据文件、各分行
- 数据挖掘信贷风险案例：包括从数据挖掘业务定位、目标定位、数据准备、模型开发与算法应用以及SAS/EM工具的实现
- [源码](/code/4-4)
### 5、评分卡模型开发
- 响应评分卡模型是针对客户对某一种产品的响应概率进行预测的模型
- 包括数据准备（历史数据）、变量处理、模型建立（logistic回归）、评分转换、模型评估(K—S)、模型应用