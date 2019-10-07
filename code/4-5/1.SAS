proc  logistic  data=INPUT_TB;
	model  Y(event='1')=X_LIST
			/selection=stepwise
			 slentry=0.05
          slstay=0.05
          details
          outroc=roc;
	weight  weight;
run;
