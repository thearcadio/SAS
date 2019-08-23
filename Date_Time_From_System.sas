* Tests to see if the month is September - December and sets year accordingly ;
data test;
	if month(input("&sysdate9.", date9.)) ge 9 then do;
		test = year(input("&sysdate9.", date9.));
	end;
	else do;
		test = year(input("&sysdate9.", date9.)) - 1;
	end;
run;
