data mydata;
 input key;
datalines;
1
2
3
4
5
;
run;


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
run;

data count;
 length total key 8;
 keep key total;

 declare hash myhash(suminc: "count", dataset:"mydata");
 myhash.defineKey('key');
 myhash.defineDone();
 count = 1;

 do while (not done);
   set keys end=done;
   rc = myhash.find();
 end;

 done = 0;
 do while (not done);
   set mydata end=done;
   rc = myhash.sum(sum: total);
   output;
 end;
 stop;
run;
