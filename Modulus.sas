data remainder;
	Dividend = 10;
	Divisor = 3;
	Remainder = mod(dividend, divisor);
run;

proc print data = remainder nobs;
run;
