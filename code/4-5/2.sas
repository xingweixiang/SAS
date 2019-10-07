%macro  excel_import (file,sheet,outlib,outpre,varnm=1,range=);
/*_____0.参数处理_______________________________________________________________________*/
%if  %sysfunc(sum(%index(&file.,%str(%')),%index(&file.,%str(%"))))>=1 
%then  %let file=%sysfunc(compress(&file.,%str(%"%')));
   %else  %let  file=%sysfunc(pathname(&file.));
%let  sheet=%lowcase(&sheet.);
%if  %bquote(&outlib.)^=  %then  %let  outlib=%lowcase(&outlib..);
%if %bquote(&outpre.)^=   %then  %let  outpre=%lowcase(&outpre.);
/*sheet变量拆分*/
%local  sheet_ex;
%let  sheet_ex=%scan(%bquote(&sheet.),2,|);
%let  sheet=%scan(%bquote(&sheet.),1,|);
/*sheet_list变量列表*/
%local  sheet_list;
%if  %bquote(&sheet.)=%str(*) %then %do;
	libname  xlsfile  excel  "&file.";  /*excel指定引擎读取xls格式文件，xlsfile指定excel库*/
	proc  contents
	   data=xlsfile._all_ directory
	   memtype=data noprint
	   out=mcr_xls_import_file nodetails;
		run;
	proc  sql;
		select  distinct compress(memname,' $')  into :sheet_list  separated  by  ' '  
from  mcr_xls_import_file;
		quit;
	proc  datasets 
	   mt=data nolist; 
		delete  mcr_xls_import_file;
		run;
	libname  xlsfile  clear;
%end;
%else  %let  sheet_list=&sheet.;
/*从sheet_list、sheet_ex列表拆分*/
%local i j;
%let i=1;
%do  %until(%scan(&sheet_list.,&i.,%str( ))= );
	%local  sheet_list_&i.;
	%let  sheet_list_&i.=%scan(&sheet_list.,&i.,%str( ));
	%let  i=%eval(&i.+1);
%end;
%let  j=1;
%do  %until(%scan(&sheet_ex.,&j.,%str( ))= );
	%local  sheet_ex_&j.;
	%let  sheet_ex_&j.=%scan(&sheet_ex.,&j.,%str( ));
	%let  j=%eval(&j.+1);
%end;

/*_____1.主程序_______________________________________________________________________*/
%local  m n   sheet_nm sheet_tb   sheet_import_flag   out_sn;
%let  out_sn=1;
%do  m=1 %to %eval(&i.-1);
	%let  sheet_import_flag=1;
	/*判断shee_nm是不是在排除范围*/
	%let  sheet_nm=&&sheet_list_&m..$;
	%let  sheet_tb=%sysfunc(compress(&sheet_nm.,_,kad));
	%let  n=1;
	%do  %until(%bquote(&sheet_import_flag.)=0 or &n.=&j.);
		%if  %lowcase(&&sheet_list_&m..)=%lowcase(&&sheet_ex_&n..)  %then  %let  sheet_import_flag=0;
		%let  n=%eval(&n.+1);
	%end;
	/*执行导入数据集操作*/ 
	%if  &sheet_import_flag.=1 %then  %do;
		Proc  import  out=%sysfunc(compress(&outlib.&outpre.&sheet_tb.))
	            datafile= "&file." 
	            dbms=excel replace;
	     range="&sheet_nm.&range.";  /*range="sheet$a1:c9";*/ /*sheet="&sheet_tb.";*/
	     %if  %bquote(&varnm.)=1  %then %str(getnames=yes;);  
%else  %str(getnames=no;);
        mixed=yes; 
		  scantext=yes;
		  usedate=yes;
		quit;
		%put <ok!>_&out_sn.  &file.|&sheet_tb.[%sysfunc(coalescec(&range.,all))] → &outlib.&outpre.&sheet_tb.;
		%let out_sn=%eval(&out_sn.+1);
	%end;  
%end; 
%mend excel_import;
