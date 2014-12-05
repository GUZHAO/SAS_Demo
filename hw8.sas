/*question 1 solution*/
proc iml;
start q1;
A1=A-shape(A[:,],nrow(A),ncol(A));
finish;


A={1 2 3,4 5 6,7 8 9};
run q1;
print A,A1;
quit;

/*question 2 solution*/
proc iml;
start q2(x,y,z);
x=diag(shape(x,nrow(y),ncol(y)));
z=x+y;
finish;

A={1 2 3,4 5 6,7 8 9};
run q2(2,A,A2);
print A2;
quit;

/*question 3 solution*/
proc iml;
  start q3(x,y,z);
    if nrow(x)=ncol(x) & nrow(y)=ncol(y) & nrow(z)=ncol(z) then do;
       if nrow(x)=nrow(y) & nrow(x)=nrow(z) then do;
         detx=det(x);
         dety=det(y);
         detz=det(z);
         if detx > dety     then det=x;   else det=y;
	     if det(det) > detz then det=det; else det=z;
	   end;
	   else print "Violaton of The Same Matrices Size";
    end;
    else print "Violation of Square Matrices";
  return (det);
  finish;

A={1 2 3,4 5 6,7 8 9};
B={2 3 1,5 6 4,8 9 7};
C={3 1 2,6 4 5,9 7 8};
max=q3(A,B,C);
print max;
quit;


/*question 4 solution*/
data one;
input x1 x2;
cards;
1 2
4 5
7 8
3 8
9 7
6 3
;
run;

proc iml;
use one; 
read all var {x1,x2};

start q4(x1,x2);
x1bar=x1[:,];
x2bar=x2[:,];
e1=x1-j(nrow(x1),1,x1bar);
e2=x2-j(nrow(x2),1,x2bar);
var1=e1`*e1/(nrow(x1)-1);
var2=e2`*e2/(nrow(x2)-1);
s=sqrt((var1+var2)/nrow(x1));
t=(x1bar-x2bar)/s;
df=2*nrow(x1)-2;
p=(1-probt(abs(t),df))*2;
print t,df,p;
finish;

run q4(x1,x2);
quit;
