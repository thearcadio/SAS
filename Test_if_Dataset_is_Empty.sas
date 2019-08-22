	data _null_;
	  set sashelp.vtable (where=(libname="<yourlib>" and memname="<yourds>"));
	  if nobs > 0 then call execute('%Do_Report');
	run;
