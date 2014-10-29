/* Create the data set to be used as the data source for */ 
/* the hash table */ 
Data CodeRef; 
 Infile Cards Dlm=',' DSD; 
 Input 
 Code : $2.
 Description $25. 
 ; 
 Output CodeRef; 
Cards; 
01,Bolts 
02,Screws 
03,Taps 
04,Nails 
05,Tacks 
; 
Run; 
/* Create the data set (transaction file) from which the */ 
/* values in its column named, Code, will be used to */ 
/* search the hash table */ 
Data Master; 
 Infile Cards Dlm = ',' DSD; 
 Input 
 Region $ 
 State $ 
 Store : $15. 
 Code $2.
 ; 
 Output Master; 
Cards; 
North,MI,King Hardware,01 
North,MI,King Hardware,03 
North,MI,King Hardware,04 
North,WI,Home Crafts,02 
North,WI,Home Crafts,05 
South,IN,King Hardware,01 
South,IN,King Hardware,02 
South,IN,King Hardware,03 
South,IN,King Hardware,04 
South,IN,King Hardward,05 
South,IL,Home Crafts,01 
South,IL,Home Crafts,03 
South,IL,Home Crafts,05 
; 
Run; 
/* Illustrate the creation of the hash table, the processing of */ 
/* the Master data set, and the searching of the hash table */ 
Data Results(Drop=Rc); 
 /* Define the variables to be used in the hash table declaration */ 
 Length 
 Code $ 2 
 Description $ 25 
 ; 
 /* Build the hash table */ 
 If _N_ = 1 Then 
 Do; 
 Declare Hash MyLkup(Dataset:'CodeRef'); 
 MyLkup.DefineKey('Code'); 
 MyLkup.DefineData('Description'); 
 MyLkup.DefineDone(); 
 Call Missing(Code, Description); 
 End; 
 /* Read an observation from the Master (transaction) file */ 
 Set Master; 
 /* Using the value of Code from the current Master file observation, */ 
 /* search the hash table defined above */ 
 Rc = MyLkup.Find(Key:Code); 
 /* Upon a successful search, write an observation to the output data set */ 
 If Rc = 0 Then 
 Do; 
 Output Results; 
 End; 
Run; 