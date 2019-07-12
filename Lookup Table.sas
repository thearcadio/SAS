%let id = 1236;

data sample;
	input id 1-4 name $ 5-11 orders 12-14;
	datalines;
1234John   10
1235Jane   9
1236Arcadio27
	;
run;

data _null_;
	set sample;
	call symputx(cat('name', id), name);
run;

title "Information about &&name&id. - Customer # &id.";
proc print data = sample nobs;
	where id = &id;
run;
title;
