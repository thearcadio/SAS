/* Create sample data set */

data missing;
   input n1 n2 n3 n4 n5 n6 n7 n8 c1 $ c2 $ c3 $ c4 $;
   datalines;
1 . 1 . 1 . 1 4 a . c .
1 1 . . 2 . . 5 e . g h
1 . 1 . 3 . . 6 . . k l
;
run;

options symbolgen;

/* Create two macro variables, NUM_QTY and CHAR_QTY, to hold */
/* the number of numeric and character variables, respectively. */
/* These will be used to define the number of elements in the arrays */
/* in the next DATA step. */
data _null_;
   set missing (obs=1);
   array num_vars[*] _NUMERIC_;
   array char_vars[*] _CHARACTER_;
   call symputx('num_qty', dim(num_vars));
   call symputx('char_qty', dim(char_vars));
run;

data _null_;
   set missing end=finished;

   /* Use the reserved word _NUMERIC_ to load all numeric variables  */
   /* into the NUM_VARS array.  Use the reserved word _CHARACTER_ to */ 
   /* to load all character variables into the CHAR_VARS array.      */
   array num_vars[*] _NUMERIC_;
   array char_vars[*] _CHARACTER_;

   /* Create 'flag' arrays for the variables in NUM_VARS and CHAR_VARS. */
   /* Initialize their values to 'missing'.  Values initialized in an   */
   /* ARRAY statement are retained.                                     */
   array num_miss [&num_qty] $ (&num_qty * 'missing');
   array char_miss [&char_qty] $ (&char_qty * 'missing'); 
  
   /* LIST will contain the list of variables to be dropped. */
   /* Ensure that its length is sufficient. */
   length list $ 50; 
  
   /* Check for non-missing values.  Reassign the corresponding 'flag' */
   /* value accordingly.                                               */
   do i=1 to dim(num_vars);
      if num_vars(i) ne . then num_miss(i)='non-miss';
   end;
   do i=1 to dim(char_vars);
      if char_vars(i) ne '' then char_miss(i)='non-miss';
   end;

   /* On the last observation of the data set, if a 'flag' value is still */
   /* 'missing', the variable needs to be dropped.  Concatenate the       */
   /* variable's name onto LIST to build the values of a DROP statement   */
   /* to be executed in another step.                                     */
   if finished then do;
      do i= 1 to dim(num_vars);
         if num_miss(i) = 'missing' then list=trim(list)||' '||trim(vname(num_vars(i)));
      end;
      do i= 1 to dim(char_vars);
         if char_miss(i) = 'missing' then list=trim(list)||' '||trim(vname(char_vars(i)));
      end;
      call symput('mlist',list);
   end;
run;

/* Use the macro variable MLIST in the DROP statement.  PROC DATASETS can */
/* be used to drop the variables instead of a DATA step.                  */
                                                                                                                                  
data notmiss;
   set missing;
   drop &mlist;
run;

proc print;
run;
