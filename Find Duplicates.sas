data dup;
   length key data 8;
   input key data;
   datalines;
   1 101234327
   2 11
   1 15
   3 20
   2 16
   2 9
   3 100
   5 5
   1 5
   4 6
   5 99
   ;
data _null_;
   declare hash h(dataset:'dup', multidata: 'y');
   h.definekey('key');
   h.definedata('key', 'data');
   h.definedone();
   /* avoid uninitialized variable notes */
   call missing (key, data);
   do key = 1 to 5; 
      rc = h.find();
      if (rc = 0) then do;
         put key= data=;
         rc = h.find_next();
         do while(rc = 0);
            put 'dup ' key= data=;
            rc = h.find_next();
         end;
      end;
   end;
 run;
