ods pdf pdftoc=1 file="sample graph.pdf";

* Retention: 	 74.7% 74.7% 64.3% 68.3% 85.5% ;
* Enrollment: 	 277 295 282 257 269;
* Degrees Conf.: 37 53 45 45 52;

data total_enrolled;
	input year $ enrollment;
	datalines;
Fall-14 2723
Fall-15 2652
Fall-16 2798
Fall-17 2919
Fall-18 2892
	;
run;

ods _ALL_ select;

*********************************************************************************************
*																							*
* 					Printing results to see if we have desired data 						*
*																							*
*********************************************************************************************;
goptions reset = all cback = white noborder htitle = 12pt htext = 10pt vsize = 4 in hsize = 7.5 in /*colors = (RGBA007F80FF)*/;
pattern1 color = A00808026 value = solid;
symbol1 interpol = join value = dot color = grey height = .5
        pointlabel = (height = 8pt '#enrollment');

axis1 offset = (0,0) minor = none label = none;
axis2 offset = (0,0) minor = none label = none order = (0 to 3000 by 250);

title1 "Student Credit Hour Production";
proc gplot data = total_enrolled;
   plot enrollment * year / haxis = axis1 vaxis = axis2 noframe autovref lvref = 2 areas = 1;
run;
quit;

ods pdf close;
