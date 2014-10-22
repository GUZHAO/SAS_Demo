/*question 1 */
%macro gen (n, start, end);
data random;
do i = 1 to &n;
ranint=int(ranuni(1)*(&end-&start+1)+&start);
output;
end;
proc print data=random;
run;
%mend;
%gen(5,1,100)

/*question 2 solution*/
%macro sample(n);
data randselect;
infile 'C:\Users\GU\Desktop\auto2.dat' dsd;
input make $ mpg rep78 weight foreign;
random=ranuni(1);
run;
proc sort data=randselect out=auto2;
by random;
run;
proc print data=auto2(obs=&n);
run;
%mend;
%sample(3)

/*question 3 solution*/
%macro car(var,highlow);
data auto;
infile 'C:\Users\zhaogu0212\Desktop\auto2.dat' dsd;
input make $ mpg rep78 weight foreign;
run;
proc sort data=auto;
by descending &var;
run;
%if &highlow=high %then %do;
data &highlow;
set auto;
if _n_ = 1 then do; 
call symput ('v',&var);
call symput ('m',make);
end;
run;
%end;
%if &highlow=low %then %do;
data &highlow;
set auto end=done;
if done then do;
call symput ('v',&var);
call symput ('m',make);
end;
run;
%end;
proc print data=&highlow;
where make="&m" and &var=&v;
title "Car &m has the &highlow.est &var";
run;
%mend;
%car(mpg,high)
%car(mpg,low)

