 data in;
      label q = "Quantity"
            p = "Price"
            s = "Price of Substitutes"
            y = "Income"
            u = "Unit Cost";
      drop i e1 e2;
      p = 0; q = 0;
      do i = 1 to 60;
         y = 1 + .05*i  + .15*rannor(123);
         u = 2          + .05*rannor(123) + .05*rannor(123);
         s = 4 - .001*(i-10)*(i-110) + .5*rannor(123);
         e1 = .15 * rannor(123);
         e2 = .15 * rannor(123);
         demandx = 1 + .3 * y + .35 * s + e1;
         supplyx = -1 - 1 * u + e2 - .4*e1;
         q = 1.4/2.15 * demandx + .75/2.15 * supplyx;
         p = ( - q + supplyx ) / -1.4;
         output;
      end;
   run;

   proc syslin data=in sur;
      demand: model q = p y s;
      supply: model q = p u;
   run;

   proc corr data=in;
   var p y s u;
   run;
/*FORSUR model*/


proc import datafile="C:\Users\GU\Downloads\datax.csv" DBMS=CSV 
            out=forsur replace;
			getnames=yes;

run;

ods trace on;
proc corr data=forsur outp=cor;
var _ALL_;
run;
ods trace off;






data cor;
set cor;
if _n_ >= 4;

 
