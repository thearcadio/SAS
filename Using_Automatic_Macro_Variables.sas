* Creating a year macro variable ;
data _NULL_;
	call symput("year", year("&sysdate."d));
run;
* Uncomment this if you need to debug the year macro ;
/*%put WARNING: %cmpres(&year);*/

%let short_year = %substr(%cmpres(&year), 3, 2);

* Uncomment this if you need to debug the short_year macro ;
/*%put WARNING: %cmpres(&short_year);*/
