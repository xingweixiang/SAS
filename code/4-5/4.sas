data  input_derived;
	set  input_basic;
	format  var_1-var_12;
	by  user_id  month_nbr;
/*�������var��Ӧ������*/
	if f irst.user_id  then call missing(of var_1-var_12);
	array  var_ary[1:12] var_1-var_12;
	retain  var_1-var_12;
	var_ary[month_nbr]=var;
/*������������*/
	var_max=max(of var_1-var_12);/*���ֵ*/
	var_min=min(of var_1-var_12);/*��Сֵ*/
	avg_last_3mths=sum(of var_10-var_12)/3;/*���������ƽ��ֵ*/
/*���*/
	if  last.user_id  then output;
	drop  var  month_nbr;
run;
