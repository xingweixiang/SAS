proc  logistic  data=input_train;
	model  response(event='1')=var1-var50
			/selection=STEPWISE
          details
          outroc=ROC;
	weight WEIGHT;
run;
