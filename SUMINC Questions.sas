data _null_;
 length k count 8;
 length total 8;
 declare hash myhash(suminc: 'count');
 myhash.defineKey('k');
 myhash.defineDone();

 k = 99;
 count = 1;
 myhash.add();


/* COUNT is given the value 2.5 and the */ 
/* FIND sets the summary to 3.5*/ 
 count = 2.5;
 myhash.find();

/* The COUNT of 3 is added to the FIND and */
/* sets the summary to 6.5. */
 count = 3;
 myhash.find();


/* The COUNT of -1 sets the summary to 5.5. */
 count = -1;
 myhash.find();

/* The SUM method gives the current value of */
/* the key summary to the variable TOTAL. */
 myhash.sum(sum: total);

/* The PUT statement prints total=5.5 in the log. */
 put total=;
 run;

data _null_;
 length k count 8;
 length total 8;
 declare hash myhash(suminc: 'count');
 myhash.defineKey('k');
 myhash.defineDone();
k = 99;
 count = 1;
 myhash.add();
 /* key=99 summary is now 1 */

 k = 100;
 myhash.add();
 /* key=100 summary is now 1 */

 k = 99;
 myhash.find();
 /* key=99 summary is now 2 */

 count = 2;
 myhash.find();
 /* key=99 summary is now 4 */

 k = 100;
 myhash.find();
 /* key=100 summary is now 3 */

 myhash.sum(sum: total);
 put 'total for key 100 = ' total;

 k = 99;

myhash.sum(sum:total);
 put 'total for key 99 = ' total;
 run;
