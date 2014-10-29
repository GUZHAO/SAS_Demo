data wordc;
infile 'C:\Users\gz056\Downloads\13chil.txt';
input word & $200. ;
if _n_ = 1 then call symputx ('title', word);
if _n_ = 2 then call symputx ('author', word);	
if _n_ ge 3 then do;

run;


%macro test(string);                                                                                                                    
  %let word_cnt=%sysfunc(countw(%superq(string)));                                                                                      
  %do i = 1 %to &word_cnt;                                                                                                              
    %let var&i=%qscan(%superq(string),&i,%str( ));                                                                                      
    %put &&var&i;                                                                                                                       
  %end;                                                                                                                                 
%mend;   
                   
%test(a b c d e)


%macro wordcount;


data wordc;
infile 'C:\Users\gz056\Downloads\13chil.txt';
input word & $200. ;
if _n_ = 1 then call symputx ('title', word);
if _n_ = 2 then call symputx ('author', word);	
if _n_ ge 3 then do;
 %let word_cnt=%sysfunc(countw(%superq(word)));                                                                                      
  %do i = 1 %to &word_cnt;                                                                                                              
    %let var&i=%qscan(%superq(string),&i,%str( ));                                                                                                                                                                                                             
  %end;

run;
