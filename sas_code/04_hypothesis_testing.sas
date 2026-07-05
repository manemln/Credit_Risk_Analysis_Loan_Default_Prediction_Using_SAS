/* general decision rule used in the file

   Alpha level = 0.05
   
   if p-value < 0.05: reject H0
       there is statistically significant evidence of a difference or association
       
   If p-value >= 0.05: do not reject H0
       there is not enough statistical evidence of a difference or association
*/


/* 
   t-tests
   t-test because one variable is numeric and the comparison variable has exactly two groups
   Risk has two groups: "Risk" and "No Risk"
   Using t-tests to compare mean Age, LoanAmount, and
   LoanDuration between the two credit risk groups

   case of equal variances: Pooled method
   case of unequal variances: Satterthwaite method
   
   Checking if Fstat <= Fcrit or equivalently p-value>= 0.05: Variances are not significantly different. Pooled 
   If F statistic > F critical, or equivalently p-value < 0.05:Variances are significantly different. Satterthwaite
 */


/*
   Test 1: Is borrower age connected to credit risk?
   
   Why the question matters: Age may represent financial maturity, income stability, and
   credit experience. If risky borrowers have a significantly different average age, 
   age can support borrower segmentation

   Variables: Risk = categorical variable with 2 groups, Age  = numeric variable
   Test type: Independent samples t-test

   H0: Mean borrower age is equal for Risk and No Risk borrowers.
   H1: Mean borrower age is different for Risk and No Risk borrowers.
 */

title "T-Test 1: Age Difference by Credit Risk";
proc ttest data=work.cred_clean;
    class Risk; /* defines the two comparison groups: Risk and No Risk */
    var Age;    /* numeric variable whose mean is compared between groups */
run;


/* Test 2: Loan Amount and Credit Risk

   Research question:
   Do risky borrowers request or receive different loan amounts?

   Why this question matters:
   Loan amount is important for lender exposure. If risky borrowers
   tend to have larger loan amounts, lenders may face higher financial
   loss if those borrowers default.

   Variables:
   Risk       = categorical variable with 2 groups
   LoanAmount = numeric variable

   Test type:
   Independent samples t-test

   H0: Mean loan amount is equal for Risk and No Risk borrowers.
   H1: Mean loan amount is different for Risk and No Risk borrowers.

   Interpretation:
   If Pr > |t| < 0.05, loan amount differs significantly between
   the two risk groups.
   ============================================================ */

title "T-Test 2: Loan Amount Difference by Credit Risk";

proc ttest data=work.cred_clean;
    class Risk;
    var LoanAmount;
run;


/* ============================================================
   Test 3: Loan Duration and Credit Risk

   Research question:
   Are longer loans connected to higher credit risk?

   Why this question matters:
   Longer repayment periods can increase uncertainty and may increase
   the chance of default. If risky borrowers have longer average loan
   duration, duration becomes an important risk factor.

   Variables:
   Risk         = categorical variable with 2 groups
   LoanDuration = numeric variable

   Test type:
   Independent samples t-test

   H0: Mean loan duration is equal for Risk and No Risk borrowers.
   H1: Mean loan duration is different for Risk and No Risk borrowers.

   Interpretation:
   If Pr > |t| < 0.05, loan duration differs significantly between
   the two risk groups.
   ============================================================ */

title "T-Test 3: Loan Duration Difference by Credit Risk";

proc ttest data=work.cred_clean;
    class Risk;
    var LoanDuration;
run;


/* ============================================================
   PART 2: CHI-SQUARE TESTS OF INDEPENDENCE

   Chi-square tests are used when:
       - both variables are categorical

   In this project, we use chi-square tests to check whether
   credit risk is associated with borrower categories such as
   age group, credit history, savings status, and loan categories.

   How to read SAS output:
   Check the Pearson Chi-Square p-value, shown as Pr > ChiSq.

   If Pr > ChiSq < 0.05:
       Reject H0.
       The two categorical variables are significantly associated.

   If Pr > ChiSq >= 0.05:
       Do not reject H0.
       There is not enough evidence of association.
   ============================================================ */


/* ============================================================
   Test 4: Age Group and Credit Risk

   Research question:
   Is credit risk associated with borrower age category?

   Why this question matters:
   The t-test compares average age, but age groups are easier to
   interpret for business decisions. This test helps identify whether
   certain age groups have different risk patterns.

   Variables:
   Age_Group = categorical variable
   Risk      = categorical variable

   Test type:
   Chi-square test of independence

   H0: Age group and credit risk are independent.
   H1: Age group and credit risk are associated.
   ============================================================ */

title "Chi-Square Test 1: Association Between Age Group and Credit Risk";

proc freq data=work.cred_clean;
    tables Age_Group*Risk / chisq expected cellchi2;
run;


/* ============================================================
   Test 5: Loan Amount Group and Credit Risk

   Research question:
   Is credit risk associated with loan amount category?

   Why this question matters:
   This helps determine whether low, medium, or high loan amounts
   contain different proportions of risky borrowers.

   Variables:
   LoanAmount_Group = categorical variable
   Risk             = categorical variable

   Test type:
   Chi-square test of independence

   H0: Loan amount group and credit risk are independent.
   H1: Loan amount group and credit risk are associated.
   ============================================================ */

title "Chi-Square Test 2: Association Between Loan Amount Group and Credit Risk";

proc freq data=work.cred_clean;
    tables LoanAmount_Group*Risk / chisq expected cellchi2;
run;


/* ============================================================
   Test 6: Loan Duration Group and Credit Risk

   Research question:
   Is credit risk associated with loan duration category?

   Why this question matters:
   Longer loans may be riskier because repayment uncertainty increases
   over time. This test checks whether short, medium, and long-term
   loans have different risk patterns.

   Variables:
   LoanDuration_Group = categorical variable
   Risk               = categorical variable

   Test type:
   Chi-square test of independence

   H0: Loan duration group and credit risk are independent.
   H1: Loan duration group and credit risk are associated.
   ============================================================ */

title "Chi-Square Test 3: Association Between Loan Duration Group and Credit Risk";

proc freq data=work.cred_clean;
    tables LoanDuration_Group*Risk / chisq expected cellchi2;
run;


/* ============================================================
   Test 7: Credit History and Credit Risk

   Research question:
   Is credit history associated with credit risk?

   Why this question matters:
   Credit history is expected to be one of the strongest indicators
   of default risk. Borrowers with delayed payments or outstanding
   credit may have a higher probability of being risky.

   Variables:
   CreditHistory = categorical variable
   Risk          = categorical variable

   Test type:
   Chi-square test of independence

   H0: Credit history and credit risk are independent.
   H1: Credit history and credit risk are associated.
   ============================================================ */

title "Chi-Square Test 4: Association Between Credit History and Credit Risk";

proc freq data=work.cred_clean;
    tables CreditHistory*Risk / chisq expected cellchi2;
run;


/* ============================================================
   Test 8: Checking Account Status and Credit Risk

   Research question:
   Is checking account status associated with credit risk?

   Why this question matters:
   Checking account status may reflect liquidity. Borrowers with
   low or negative checking balances may have higher repayment risk.

   Variables:
   CheckingStatus = categorical variable
   Risk           = categorical variable

   Test type:
   Chi-square test of independence

   H0: Checking account status and credit risk are independent.
   H1: Checking account status and credit risk are associated.
   ============================================================ */

title "Chi-Square Test 5: Association Between Checking Status and Credit Risk";

proc freq data=work.cred_clean;
    tables CheckingStatus*Risk / chisq expected cellchi2;
run;


/* ============================================================
   Test 9: Existing Savings and Credit Risk

   Research question:
   Is savings status associated with credit risk?

   Why this question matters:
   Savings may act as a financial buffer. Borrowers with low savings
   may have less ability to handle repayment difficulties.

   Variables:
   ExistingSavings = categorical variable
   Risk            = categorical variable

   Test type:
   Chi-square test of independence

   H0: Existing savings status and credit risk are independent.
   H1: Existing savings status and credit risk are associated.
   ============================================================ */

title "Chi-Square Test 6: Association Between Existing Savings and Credit Risk";

proc freq data=work.cred_clean;
    tables ExistingSavings*Risk / chisq expected cellchi2;
run;


/* ============================================================
   Test 10: Employment Duration and Credit Risk

   Research question:
   Is employment duration associated with credit risk?

   Why this question matters:
   Employment duration may represent income stability. Borrowers
   with shorter or unstable employment may have higher default risk.

   Variables:
   EmploymentDuration = categorical variable
   Risk               = categorical variable

   Test type:
   Chi-square test of independence

   H0: Employment duration and credit risk are independent.
   H1: Employment duration and credit risk are associated.
   ============================================================ */

title "Chi-Square Test 7: Association Between Employment Duration and Credit Risk";

proc freq data=work.cred_clean;
    tables EmploymentDuration*Risk / chisq expected cellchi2;
run;


/* ============================================================
   PART 3: ONE-WAY ANOVA TESTS

   ANOVA is used when:
       - one variable is numeric
       - the grouping variable has 3 or more categories

   ANOVA tells us whether at least one group mean is different.

   How to read SAS output:
   Check the ANOVA table and the p-value shown as Pr > F.

   If Pr > F < 0.05:
       Reject H0.
       At least one group mean is significantly different.

   If Pr > F >= 0.05:
       Do not reject H0.
       There is not enough evidence that the group means differ.

   Tukey test:
       ANOVA tells us that at least one group differs.
       Tukey helps identify which specific groups differ.

   Levene test:
       Checks whether group variances are equal.

   Welch ANOVA:
       Useful when equal variance assumption is questionable.
   ============================================================ */


/* ============================================================
   ANOVA Test 1: Loan Amount by Credit History

   Research question:
   Does average loan amount differ across credit history categories?

   Why this question matters:
   Borrowers with different credit histories may request or receive
   different loan amounts. This can reveal whether borrowing behavior
   changes across credit history profiles.

   Variables:
   CreditHistory = categorical variable with more than 2 groups
   LoanAmount    = numeric variable

   Test type:
   One-way ANOVA

   H0: Mean loan amount is equal across all credit history groups.
   H1: At least one credit history group has a different mean loan amount.

   Interpretation:
   Check Pr > F.
   If Pr > F < 0.05, reject H0.
   ============================================================ */

title "ANOVA Test 1: Loan Amount by Credit History";

proc glm data=work.cred_clean;
    class CreditHistory;
    model LoanAmount = CreditHistory;
    means CreditHistory / hovtest=levene welch tukey;
run;
quit;


/* ============================================================
   ANOVA Test 2: Loan Duration by Checking Account Status

   Research question:
   Does average loan duration differ across checking account statuses?

   Why this question matters:
   Checking status may reflect borrower liquidity. If loan duration
   differs across checking status groups, it may show different loan
   behavior among borrowers with different financial conditions.

   Variables:
   CheckingStatus = categorical variable with more than 2 groups
   LoanDuration   = numeric variable

   Test type:
   One-way ANOVA

   H0: Mean loan duration is equal across all checking status groups.
   H1: At least one checking status group has a different mean loan duration.

   Interpretation:
   Check Pr > F.
   If Pr > F < 0.05, reject H0.
   ============================================================ */

title "ANOVA Test 2: Loan Duration by Checking Account Status";

proc glm data=work.cred_clean;
    class CheckingStatus;
    model LoanDuration = CheckingStatus;
    means CheckingStatus / hovtest=levene welch tukey;
run;
quit;


/* ============================================================
   ANOVA Test 3: Loan Amount by Existing Savings

   Research question:
   Does average loan amount differ across savings categories?

   Why this question matters:
   Savings can act as a financial buffer. Borrowers with different
   savings levels may request or be approved for different loan amounts.

   Variables:
   ExistingSavings = categorical variable with more than 2 groups
   LoanAmount      = numeric variable

   Test type:
   One-way ANOVA

   H0: Mean loan amount is equal across all savings groups.
   H1: At least one savings group has a different mean loan amount.

   Interpretation:
   Check Pr > F.
   If Pr > F < 0.05, reject H0.
   ============================================================ */

title "ANOVA Test 3: Loan Amount by Existing Savings";

proc glm data=work.cred_clean;
    class ExistingSavings;
    model LoanAmount = ExistingSavings;
    means ExistingSavings / hovtest=levene welch tukey;
run;
quit;


/* ============================================================
   ANOVA Test 4: Age by Employment Duration

   Research question:
   Does average borrower age differ across employment duration groups?

   Why this question matters:
   Employment duration may be connected to age, career stability,
   and borrower profile. This test helps describe borrower segments.

   Variables:
   EmploymentDuration = categorical variable with more than 2 groups
   Age                = numeric variable

   Test type:
   One-way ANOVA

   H0: Mean age is equal across all employment duration groups.
   H1: At least one employment duration group has a different mean age.

   Interpretation:
   Check Pr > F.
   If Pr > F < 0.05, reject H0.
   ============================================================ */

title "ANOVA Test 4: Age by Employment Duration";

proc glm data=work.cred_clean;
    class EmploymentDuration;
    model Age = EmploymentDuration;
    means EmploymentDuration / hovtest=levene welch tukey;
run;
quit;


/* Clear current title so it will not appear in later outputs */
title;
