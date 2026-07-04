/*from raw dataset, checking how many non-missing and missing values exist for the chosen variables */
title "Missing Values for Numeric Variables";
proc means data=work.cred_raw n nmiss; 
    var Age LoanAmount LoanDuration InstallmentPercent 
        CurrentResidenceDuration ExistingCreditsCount Dependents;
run;


/* checking missing values and distributions for categorical variables */
title "Frequency Tables for Categorical Variables";

proc freq data=work.cred_raw;
    tables CheckingStatus CreditHistory LoanPurpose ExistingSavings 
           EmploymentDuration Sex OthersOnLoan OwnsProperty 
           InstallmentPlans Housing Job Telephone ForeignWorker Risk / missing;
run;


/* creating cleaned dataset with new analysis variables */
data work.cred_clean;
    set work.cred_raw;
    /* creating numeric target variable for modeling */
    if Risk = "No Risk" then Default_Flag = 0;
    else if Risk = "Risk" then Default_Flag = 1;

    /* creating readable label for the numeric target */
    label Default_Flag = "Default Indicator: 0 = No Risk, 1 = Risk";
    /* creating age groups */
    length Age_Group $16;

    if Age < 25 then Age_Group = "Under 25";
    else if 25 <= Age < 35 then Age_Group = "25 to 34";
    else if 35 <= Age < 50 then Age_Group = "35 to 49";
    else if Age >= 50 then Age_Group = "50 and above";
    else Age_Group = "Missing";

    /* creating loan amount groups */
    length LoanAmount_Group $20;
    if LoanAmount < 1000 then LoanAmount_Group = "Low Amount";
    else if 1000 <= LoanAmount < 5000 then LoanAmount_Group = "Medium Amount";
    else if LoanAmount >= 5000 then LoanAmount_Group = "High Amount";
    else LoanAmount_Group = "Missing";

    /* creating loan duration groups */
    length LoanDuration_Group $20;
    if LoanDuration <= 12 then LoanDuration_Group = "Short Term";
    else if 13 <= LoanDuration <= 24 then LoanDuration_Group = "Medium Term";
    else if LoanDuration > 24 then LoanDuration_Group = "Long Term";
    else LoanDuration_Group = "Missing";

    /* converting employment duration category into an approximate numeric variable */
    if EmploymentDuration = "unemployed" then EmploymentDuration_Num = 0;
    else if EmploymentDuration = "less_1" then EmploymentDuration_Num = 0.5;
    else if EmploymentDuration = "1_to_4" then EmploymentDuration_Num = 2;
    else if EmploymentDuration = "4_to_7" then EmploymentDuration_Num = 5.5;
    else if EmploymentDuration = "greater_7" then EmploymentDuration_Num = 8;
    else EmploymentDuration_Num = .;

    label EmploymentDuration_Num = "Approximate Employment Duration in Years";

run;


/* checking the structure of the cleaned dataset */
title "Structure of Cleaned Credit Dataset";
proc contents data=work.cred_clean;
run;

/* printing first 10 observations of cleaned dataset */
title "First 10 Observations of Cleaned Credit Dataset";
proc print data=work.cred_clean(obs=10);
run;

/* checking the new target variable */
title "Distribution of Default Flag";
proc freq data=work.cred_clean;
    tables Risk Default_Flag Risk*Default_Flag / missing; /* including missing values */
run;

/* checking created borrower groups */
title "Created Borrower Groups";
proc freq data=work.cred_clean;
    tables Age_Group LoanAmount_Group LoanDuration_Group
            EmploymentDuration*EmploymentDuration_Num / missing;
run;

title;
