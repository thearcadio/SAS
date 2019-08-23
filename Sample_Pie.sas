ods pdf pdftoc=1 file="pie graph.pdf";

data just_current;
	input retained $ percent;
	datalines;
Y 70.3
N 29.7
;
run;

data just_current;
	set just_current;
	if retained = "Y" then do;
		call symput('retper', percent);
	end;
run;

%let label = %trim(&retper);

goptions reset = all colors = (white teal);
pattern1 value = solid;

proc gchart data=just_current gout = sasuser.excat; 
	donut retained / 
	type = sum
	sumvar = percent
	name = "retmaj"
	angle = 90
	slice = none
	DONUTPCT = 60
	label = (color = teal height = 5 justify = center "&label%")
	noheading
	coutline = same;  
run;
quit;

proc greplay tc = work.tempcat nofs;	
	tdef newtemp2 des = "four panel"
	1/  llx = 0    lly = 50
		ulx = 0    uly = 100
		urx = 50   ury = 100
		lrx = 50   lry = 50
		color = white
	2/  llx = 50   lly = 50
		ulx = 50   uly = 100
		urx = 100  ury = 100
		lrx = 100  lry = 50
		color = white
	3/  llx = 0    lly = 0
		ulx = 0    uly = 50
		urx = 50   ury = 50
		lrx = 50   lry = 0
		color = white
	4/  llx = 50   lly = 0
		ulx = 50   uly = 50
		urx = 100  ury = 50
		lrx = 100  lry = 0
		color = white
;
quit;

goptions reset = all vsize = 5.5 in hsize = 5.5in;
ods proclabel "";
proc greplay gout = sasuser.excat igout = sasuser.excat nofs tc = work.tempcat template = newtemp2;
	treplay 1:retmaj 2:retmaj 3:retmaj 4:retmaj;
	delete _all_;
	run;
quit;

ods pdf close;
