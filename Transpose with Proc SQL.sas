data given;
	input 	id 	  	  1-7
			var1 	$ 8-9
			var2 	$ 10-11;
	datalines;
1234567abcd
7654321abcd
1234567defg
7654321defg
	;
run;

proc sort data = given;
	by id;
run;

data given;
	set given;
	by id;
	if first.id then n = 0;
	n+1;
run;

proc sql noprint;
	select distinct catt('given (where=(n=',left(put(n,8.)),') rename=(var1=var1',left(put(n,8.)),
		' var2=var2',left(put(n,8.)),'))')
		into :mer separated by ' '
	from given;
quit;

data need;
	merge &mer;
	by id;
	drop n;
run;
