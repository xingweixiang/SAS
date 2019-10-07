data  input_train 
     input_test;
	set  input_derived;
	random_nbr=uniform(123456);
	if  random_nbr>=0.3  then  output  input_train;
	if  random_nbr<0.3  then output  input_test;
run;
