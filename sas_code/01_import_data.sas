/* Reading CSV file from GitHub,having credcsv fileref for it */
filename credcsv url
"https://raw.githubusercontent.com/manemln/Credit_Risk_Analysis_Loan_Default_Prediction_Using_SAS/main/data/raw/german_credit_data.csv";

/* Importing CSV file into SAS */

proc import datafile=credcsv
    out=work.cred_raw  /* file needs to be there, where work is the library in sas for that session usage, credit_raw is the name of new dataset*/
    dbms=csv 
    replace; /* if work.credit_raw already exists, replacing it with new imported version */
    guessingrows=max; /* looking at as many rows as possible before deciding variable types */
run;


/* checking the structure of the imported dataset */
title "Structure of German Credit Dataset";
proc contents data=work.cred_raw;/* shows dataset structure, including variables/columns */
run;

/* printing the first 10 observations */
title "First 10 Observations of German Credit Dataset";
proc print data=work.cred_raw(obs=10);
run;

/* checking the number of rows with sql select statement and count aggregation */
title "Dataset Size";
proc sql; /* sql procedure */
    select count(*) as Number_of_Rows
    from work.cred_raw;
quit; /* end of sql procedure, used for procs which need explicit closing */

title; /* cancel current title so "Dataset Size" will not be used as title */
