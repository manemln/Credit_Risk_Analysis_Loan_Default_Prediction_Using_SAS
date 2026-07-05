/* creating formats so numeric order variables appear with readable labels */
proc format;
    value agefmt
        1 = "Under 25"
        2 = "25 to 34"
        3 = "35 to 49"
        4 = "50 and above";

    value amountfmt
        1 = "Low Amount"
        2 = "Medium Amount"
        3 = "High Amount";

    value durationfmt
        1 = "Short Term"
        2 = "Medium Term"
        3 = "Long Term";
run;


/* creating an exploratory analysis dataset with ordered group variables */
data work.cred_eda;
    set work.cred_clean;
    /* numeric order variable for age groups */
    if Age < 25 then Age_Group_Order = 1;
    else if 25 <= Age < 35 then Age_Group_Order = 2;
    else if 35 <= Age < 50 then Age_Group_Order = 3;
    else if Age >= 50 then Age_Group_Order = 4;
    else Age_Group_Order = .;

    /* numeric order variable for loan amount groups */
    if LoanAmount < 1000 then LoanAmount_Group_Order = 1;
    else if 1000 <= LoanAmount < 5000 then LoanAmount_Group_Order = 2;
    else if LoanAmount >= 5000 then LoanAmount_Group_Order = 3;
    else LoanAmount_Group_Order = .;

    /* numeric order variable for loan duration groups */
    if LoanDuration <= 12 then LoanDuration_Group_Order = 1;
    else if 13 <= LoanDuration <= 24 then LoanDuration_Group_Order = 2;
    else if LoanDuration > 24 then LoanDuration_Group_Order = 3;
    else LoanDuration_Group_Order = .;

    label Age_Group_Order = "Age Group"
          LoanAmount_Group_Order = "Loan Amount Group"
          LoanDuration_Group_Order = "Loan Duration Group";

    format Age_Group_Order agefmt.
           LoanAmount_Group_Order amountfmt.
           LoanDuration_Group_Order durationfmt.;
run;

/* summary statistics for important variables */
title "Summary Statistics for Numeric Variables";
proc means data=work.cred_eda n mean median std min q1 q3 max maxdec=2;
    var Age LoanAmount LoanDuration InstallmentPercent
        CurrentResidenceDuration ExistingCreditsCount Dependents
        EmploymentDuration_Num;
run;


/* frequency distribution of the target variable */
title "Credit Risk Distribution";
proc freq data=work.cred_eda;
    tables Risk Default_Flag / missing;
run;


/* frequency distribution of created borrower groups in logical order */
title "Frequency Distribution of Created Borrower Groups";
proc freq data=work.cred_eda order=internal;
    tables Age_Group_Order LoanAmount_Group_Order LoanDuration_Group_Order / missing;
    format Age_Group_Order agefmt.
           LoanAmount_Group_Order amountfmt.
           LoanDuration_Group_Order durationfmt.;
run;

/* frequency distribution of important categorical variables */
title "Frequency Distribution of Important Categorical Variables";
proc freq data=work.cred_eda;
    tables CheckingStatus CreditHistory LoanPurpose ExistingSavings
           EmploymentDuration Housing Job Sex OwnsProperty / missing;
run;

/* checking credit risk distribution by borrower and loan groups */
title "Credit Risk by Borrower and Loan Groups";
proc freq data=work.cred_eda order=internal;
    tables Age_Group_Order*Risk
           LoanAmount_Group_Order*Risk
           LoanDuration_Group_Order*Risk / missing;
    format Age_Group_Order agefmt.
           LoanAmount_Group_Order amountfmt.
           LoanDuration_Group_Order durationfmt.;
run;


/* checking credit risk distribution by financial characteristics */
title "Credit Risk by Financial Characteristics";
proc freq data=work.cred_eda;
    tables CheckingStatus*Risk
           CreditHistory*Risk
           ExistingSavings*Risk
           EmploymentDuration*Risk
           Housing*Risk / missing;
run;

/* histogram for borrower age */
title "Distribution of Borrower Age";
proc sgplot data=work.cred_eda;
    histogram Age;
    density Age;
    xaxis label="Borrower Age";
    yaxis label="Frequency";
run;

/* histogram for loan amount */
title "Distribution of Loan Amount";
proc sgplot data=work.cred_eda;
    histogram LoanAmount;
    density LoanAmount;
    xaxis label="Loan Amount";
    yaxis label="Frequency";
run;

/* histogram for loan duration */
title "Distribution of Loan Duration";
proc sgplot data=work.cred_eda;
    histogram LoanDuration;
    density LoanDuration;
    xaxis label="Loan Duration";
    yaxis label="Frequency";
run;


/* bar chart for credit risk distribution */
title "Bar Chart of Credit Risk";
proc sgplot data=work.cred_eda;
    vbar Risk; /*vertical bar chart*/
    xaxis label="Credit Risk";
    yaxis label="Frequency";
run;


/* bar chart showing credit risk by age group in logical order */
title "Credit Risk by Age Group";
proc sgplot data=work.cred_eda;
    format Age_Group_Order agefmt.;
    vbar Age_Group_Order / group=Risk groupdisplay=cluster; /* vertical seperated by risk displayed next to each other */
    xaxis label="Age Group" type=discrete discreteorder=unformatted;
    yaxis label="Frequency";
run;


/* bar chart showing credit risk by loan amount group in logical order */
title "Credit Risk by Loan Amount Group";
proc sgplot data=work.cred_eda;
    format LoanAmount_Group_Order amountfmt.;
    vbar LoanAmount_Group_Order / group=Risk groupdisplay=cluster;
    xaxis label="Loan Amount Group" type=discrete discreteorder=unformatted;
    yaxis label="Frequency";
run;


/* bar chart showing credit risk by loan duration group in logical order */
title "Credit Risk by Loan Duration Group";
proc sgplot data=work.cred_eda;
    format LoanDuration_Group_Order durationfmt.;
    vbar LoanDuration_Group_Order / group=Risk groupdisplay=cluster;
    xaxis label="Loan Duration Group" type=discrete discreteorder=unformatted;
    yaxis label="Frequency";
run;

/* cleaning current title so it will not appear in later outputs */
title;
