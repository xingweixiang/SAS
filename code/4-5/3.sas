proc sql;
	create  table  input_basic  as  select 
		a.*, b.*, бнбн
	from input_basic_1 as a
		left  join  inpug_basic_2  as  b  on b.user_id=a.user_id and  b.month_nbr=a.month_nbr
		left  join
order  by user_id,month_nbr;
	quit;
