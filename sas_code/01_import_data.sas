/* ============================================================
   01_import_data.sas
   Project: Credit Risk Analysis and Loan Default Prediction Using SAS
   Purpose: Import the German Credit Dataset from GitHub
   ============================================================ */


/* Step 1: Read the CSV file directly from GitHub */

/* 
   IMPORTANT:
   Replace YOUR_USERNAME and YOUR_REPOSITORY_NAME with your real GitHub information.

   Example:
   https://raw.githubusercontent.com/manemln/Credit-Risk-Analysis-and-Loan-Default-Prediction-Using-SAS/main/data/raw/german_credit_data.csv
*/

filename creditcsv url
"https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME/main/data/raw/german_credit_data.csv";


/* Step 2: Import the CSV file into SAS */

proc import datafile=creditcsv
    out=work.credit_raw
    dbms=csv
    replace;
    guessingrows=max;
run;


/* Step 3: Check the structure of the imported dataset */

title "Structure of German Credit Dataset";
proc contents data=work.credit_raw;
run;


/* Step 4: Print the first 10 observations */

title "First 10 Observations of German Credit Dataset";
proc print data=work.credit_raw(obs=10);
run;


/* Step 5: Check the number of rows and columns */

title "Dataset Size";
proc sql;
    select 
        count(*) as Number_of_Rows
    from work.credit_raw;
quit;


title;
