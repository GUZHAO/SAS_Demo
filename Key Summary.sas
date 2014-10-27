data keys;
 input key;
datalines;
1
2
1
3
5
2
3
2
4
1
5
1
;
data count;
 length count key 8;
 keep key count;
 if _n_ = 1 then do;
   declare hash myhash(suminc: "count", ordered: "y");
   declare hiter iter("myhash");
   myhash.defineKey('key');
   myhash.defineDone();
   count = 1;
  end;
 do while (not done);
   set keys end=done;
   rc = myhash.ref();
 end;
 rc = iter.first();
 do while(rc = 0);
   rc = myhash.sum(sum: count);
   output;
   rc = iter.next();
 end;
 stop;
run;

proc print data=count;
run;
