data sample;
	input id 1-4 name $ 5-11 orders 12-14;
	datalines;
1234John   10
1235Jane   9
1236Arcadio27
	;
run;

%let id = 1236;

data _null_;
	set sample;
	where id = &id;
	call symputx('name', name);
run;

title "Information about &name. - Customer # &id.";
proc print data = sample nobs;
	where id = &id;
run;
