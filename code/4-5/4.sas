data  input_derived;
	set  input_basic;
	format  var_1-var_12;
	by  user_id  month_nbr;
/*定义变量var对应的数组*/
	if f irst.user_id  then call missing(of var_1-var_12);
	array  var_ary[1:12] var_1-var_12;
	retain  var_1-var_12;
	var_ary[month_nbr]=var;
/*计算衍生变量*/
	var_max=max(of var_1-var_12);/*最大值*/
	var_min=min(of var_1-var_12);/*最小值*/
	avg_last_3mths=sum(of var_10-var_12)/3;/*最近三个月平均值*/
/*输出*/
	if  last.user_id  then output;
	drop  var  month_nbr;
run;
