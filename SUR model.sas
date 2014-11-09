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

ods path work.template(update) sashelp.tmplmst;
proc format;
   value pvalsig low-.05 ="red"
                 .05-high="black";
run;
proc template;
   edit base.corr.stackedmatrix;
      column (RowName RowLabel) (Matrix) * (Matrix2) * (Matrix3) * (Matrix4);
      edit matrix2 ;
         style={foreground=pvalsig.};
      end;
    end;
run;
title;
footnote;

ods noptitle;
ods trace on;
ods escapechar="^";
options orientation=portrait nodate nonumber;  
ods rtf file="spuerbsignificance.rtf" startpage=no style=journal;
ods path sashelp.tmplmst;
ods text="^S={font_face=Arial font_size=11pt font_weight=bold outputwidth=100% just=c}Default output"; 
/* Just show the Pearsoncorr table*/
ods select pearsoncorr; 
proc corr data=forsur;
var _ALL_;
run;
ods text="^S={font_face=Arial font_size=11pt font_weight=bold outputwidth=100% just=c}Highlight significant Pvalues at the 95th Percentile"; 
/* Use the ODS PATH referenced above in order to pick up the changes created by PROC TEMPLATE */
ods path work.template(update) sashelp.tmplmst;
ods select pearsoncorr; 
proc corr data=forsur;
var _ALL_;
run;
ods _all_ close;
ods trace off;
  
/* Delete the edited BASE.CORR.STACKEDMATRIX table so the changes do no persist in later output tables */
proc template; 
   delete base.corr.stackedmatrix;
run;



 
