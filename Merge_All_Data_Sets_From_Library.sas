* Fill in the library with all caps into the two spaces and this program will set all of them data sets the library
contains into one massive data set ;
proc sql noprint;
  select catx('.','ALL_CAPS_LIBRARY',memname) into : set separated by ' '
    from dictionary.tables
        where libname='ALL_CAPS_LIBRARY';
quit;

data first_generation;
	set &set;
run;
