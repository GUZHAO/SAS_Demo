%macro find(key);
data _null_;
length d $20;
length k $20;

if _N_ = 1 then do;
   declare hash h();
   rc = h.defineKey('k');
   rc = h.defineData('d');
   rc = h.defineDone();
   call missing (k, d);
end;

rc = h.add(key: 'Homer', data: 'Odyssey');
rc = h.add(key: 'Joyce', data: 'Ulysses');
 
rc = h.find(key: "&key");
if (rc = 0) then
   put d= ;
else
   put "Key &key not found.";
run;
%mend find;
%find(key=Joyce)
