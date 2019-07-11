data eval_raw_data;
	input admin_id $ 1-7 test $ 8-12;
	datalines;
1234567 abcd
1234567 bcde
1234567 cdef
7654321 abcd
7654321 bcde
7654321 cdef
	;
run;

* Using macro to create dataset for each person who was eval'd;
%macro each_admin;
	proc sql noprint;
	  select distinct admin_id into :admins separated by '|'
	  from eval_raw_data;
	quit;

	%let admin_num = 1;
	%let admin_id = %scan(&admins, &admin_num, |);
	%do %while (&admin_id ne );
		data admin_&admin_id;
			set eval_raw_data;
			where admin_id = "&admin_id.";
		run;
		%let admin_num = %eval(&admin_num + 1);
		%let admin_id = %scan(&admins, &admin_num, |);
	%end;
%mend;

%each_admin
