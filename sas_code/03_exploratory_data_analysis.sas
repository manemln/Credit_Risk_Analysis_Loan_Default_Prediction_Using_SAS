/* summary statistics for important variables */
title "Summary Statistics for Numeric Variables";
proc means data=work.cred_clean n mean median std min q1 q3 max maxdec=2;/*some stats with 2 max decimal places */
    var Age LoanAmount LoanDuration InstallmentPercent
        CurrentResidenceDuration ExistingCreditsCount Dependents
        EmploymentDuration_Num;
run;

/* frequency distribution of the target variable */
title "Credit Risk Distribution";
proc freq data=work.cred_clean;
    tables Risk Default_Flag / missing; 
run;

/* frequency distribution of created borrower groups */
title "Frequency Distribution of Created Borrower Groups";
proc freq data=work.cred_clean;
    tables Age_Group LoanAmount_Group LoanDuration_Group / missing;
run;


/* frequency distribution of important categorical variables */
title "Frequency Distribution of Important Categorical Variables";
proc freq data=work.cred_clean;
    tables CheckingStatus CreditHistory LoanPurpose ExistingSavings
           EmploymentDuration Housing Job Sex OwnsProperty / missing;
run;

/* checking credit risk distribution by age group, loan amount group, and loan duration group */
title "Credit Risk by Borrower and Loan Groups";
proc freq data=work.cred_clean;
    tables Age_Group*Risk
           LoanAmount_Group*Risk
           LoanDuration_Group*Risk / missing;
run;

/* checking credit risk distribution by important financial characteristics */
title "Credit Risk by Financial Characteristics";
proc freq data=work.cred_clean;
    tables CheckingStatus*Risk
           CreditHistory*Risk
           ExistingSavings*Risk
           EmploymentDuration*Risk
           Housing*Risk / missing;
run;

/* histogram for borrower age */
title "Distribution of Borrower Age";
proc sgplot data=work.cred_clean;
    histogram Age;
    density Age;
    xaxis label="Borrower Age";
    yaxis label="Frequency";
run;

/* histogram for loan amount */
title "Distribution of Loan Amount";
proc sgplot data=work.cred_clean;
    histogram LoanAmount;
    density LoanAmount;
    xaxis label="Loan Amount";
    yaxis label="Frequency";
run;


/* histogram for loan duration */
title "Distribution of Loan Duration";
proc sgplot data=work.cred_clean;
    histogram LoanDuration;
    density LoanDuration;
    xaxis label="Loan Duration";
    yaxis label="Frequency";
run;


/* bar chart for credit risk distribution */
title "Bar Chart of Credit Risk";
proc sgplot data=work.cred_clean;
    vbar Risk;
    xaxis label="Credit Risk";
    yaxis label="Frequency";
run;


/* bar chart showing credit risk by age group */
title "Credit Risk by Age Group";
proc sgplot data=work.cred_clean;
    vbar Age_Group / group=Risk groupdisplay=cluster; /*vertical bar chart seperated by risk and not one on another but side by side */
    xaxis label="Age Group";
    yaxis label="Frequency";
run;


/* bar chart showing credit risk by loan amount group */
title "Credit Risk by Loan Amount Group";
proc sgplot data=work.cred_clean;
    vbar LoanAmount_Group / group=Risk groupdisplay=cluster; /*seperated by risk side by side vertical*/
    xaxis label="Loan Amount Group";
    yaxis label="Frequency";
run;


/* bar chart showing credit risk by loan duration group */
title "Credit Risk by Loan Duration Group";
proc sgplot data=work.cred_clean;
    vbar LoanDuration_Group / group=Risk groupdisplay=cluster;
    xaxis label="Loan Duration Group";
    yaxis label="Frequency";
run;

/* cleaning current title so it will not appear in later outputs */
title;
