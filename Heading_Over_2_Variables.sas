* Shows the difference a little bit of formatting can do ;
%let path = C:\Users\amatos\Desktop\Fact Book Temp Files\College Fact Books\Sample SAS Scripts;

data sample;
	input College $ 1-5 y1n 6-9 y1r $ 10-14 y2n 15-18 y2r $ 19-23;
	datalines;
COB   87668.7% 87668.7%
COE   75267.2% 75267.2%
COHFA 90070.1% 90070.1%
COS  132467.5%132467.5%
UC    28073.4% 28068.4%
	;
run;

proc sort data = sample;
	by descending y2r;
run;

data sample;
	set sample;
	if _N_ = 1 then do;
		call symput("maxval", y2r);
		call symput("maxcol", college);
	end;
run;

proc sort data = sample;
	by college;
run;

ods _all_ close;
ods noproctitle;
ods pdf file = "&path.\sample_reports.pdf" startpage = no;
ods escapechar = "^";
options nodate nonumber;

ods text = "^{style[font_weight=bold fontsize=11pt just=center]Normal Report No Formatting}";
proc report data = sample;
run;

ods text = "^{style[font_weight=bold fontsize=11pt just=center paddingtop = 80]Report With Formatting and 2-Variable Header}";
proc report data = sample split = "*"
	style(header) = {just = c background = teal color = white font_face = arial 
	verticalalign = c font_weight = bold}
	style(report) = {cellspacing = 0 cellpadding = 8 bordercolor = A808080AD};
	column (college ("2017" y1n y1r) ("2018" y2n y2r));
	define college / style(column) = {background = A00808026 font_face = arial font_weight = bold};
	define y1n / display "N";
	define y2n / display "N";
	define y1r / display "Retention*Rate" style(column) = {just = r};
	define y2r / display "Retention*Rate" style(column) = {just = r};
	compute y2r;
		if y2r = "&maxval." then call define (_row_,"style","style={color = teal background = LIGGR}");
	endcomp;
	format y1n y2n comma5.;
run;
ods text = "^{style[fontsize=9pt just=center]&maxcol. had the highest retention: &maxval.}";

ods pdf close;
ods select all;
ods html path = "%qsysfunc(pathname(work))"; /* Re-open the default HTML path */
