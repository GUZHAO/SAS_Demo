data original;
infile 'C:\Users\gu\Downloads\13chil.txt';
input word & $200. ;
if _n_ = 1 then call symputx ('title', word);
if _n_ = 2 then call symputx ('author', word);	
if _n_ ge 3 then output original;
run;

data sentence words ;
set original end=eof;
default = countw(word, '');
output sentence;
do i = 1 to default;
var = scan(word, i, q);
v_comp = compress(var, ', " ? ! . : - ');
v_low = lowcase(v_comp);
count = 1;
output words;
end;
run;

proc freq data=words;
table v_low /out=freqcount; 
weight count;
run;





