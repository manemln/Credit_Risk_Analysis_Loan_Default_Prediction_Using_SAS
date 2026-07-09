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

/* Is borrower age connected to credit risk?

   Descriptive results
   The No Risk group has 3330 borrowers with a mean age of 32.56. The Risk group has 1670 borrowers with a mean age of 42.86.
   This means that, in this dataset, borrowers classified as Risk are older on average than borrowers classified as No Risk.
   The mean difference is approximately -10.48 when calculated as: No Risk mean age - Risk mean age
   As the difference is negative, it shows that the Risk group has the higher average age. In practical terms, Risk borrowers are
   about 10.48 years older on average than No Risk borrowers.

   Equality of variances
   SAS reports the equality of variances test using the Folded F test.
       Folded F = 1.05
       Pr > F = 0.2350
   The p-value for the equality of variances test is 0.2350, which is greater than alpha = 0.05. 
   Therefore, we do not reject H0 for the variance test.
   Hence, not enough evidence that the two group variances are significantly different.
   Since the variances are not significantly different, the Pooled row should be used for interpreting the t-test.

   T-test result from the Pooled row
       t-Value = -36.73
       Pr > |t| < .0001
   The p-value is less than 0.05, so we reject the null hypothesis.
   Hence, there is statistically significant evidence that mean borrower age differs between the Risk and No Risk groups.

   Confidence interval
   The 95% confidence interval for the mean difference is approximately: -10.96 to -9.85
   The interval does not include 0, which supports the conclusion that
   the age difference between the two risk groups is statistically significant. 
   Since the entire interval is negative, it confirms that
   the No Risk group has a lower mean age than the Risk group.

   Visual interpretation
   The histogram also supports the t-test result. 
   The age distribution for the Risk group is shifted to the right compared with the No Risk
   group, meaning that older borrowers are more common among risky borrowers.

   The Q-Q plots show that age is not perfectly normally distributed,
   especially at the tails, but the points are reasonably close to the diagonal line.
   Also, both groups have large sample sizes, so the t-test is fairly robust.

   Final conclusion
   Borrower age is significantly associated with credit risk in this dataset. 
   Risk borrowers are substantially older on average than No Risk borrowers.
   This suggests that age may be an important factor for borrower risk segmentation and should be considered in later
   modeling and business interpretation.*/

/* test 2: Do risky borrowers request or receive different loan amounts?

   Why the question matters
   Loan amount is important for lender exposure. If risky borrowers tend to have larger loan amounts, 
   lenders may face higher financial loss if those borrowers default.

   Variables
   Risk = categorical variable with 2 groups
   LoanAmount = numeric variable

   Test type
   Independent samples t-test
   H0: Mean loan amount is equal for Risk and No Risk borrowers.
   H1: Mean loan amount is different for Risk and No Risk borrowers.
   If (Pr > |t|) = p-value < 0.05 loan amount differs significantly between the two risk groups.
   */

title "T-Test 2: Loan Amount Difference by Credit Risk";
proc ttest data=work.cred_clean;
    class Risk;
    var LoanAmount;
run;

/* Descriptive results
   The No Risk group has 3330 borrowers with a mean loan amount of 2686.9.
   The Risk group has 1670 borrowers with a mean loan amount of 5062.0.
   This means that borrowers classified as Risk have substantially higher
   loan amounts on average than borrowers classified as No Risk.
   The mean difference is approximately -2375.1 when calculated as: No Risk mean loan amount - Risk mean loan amount
   Because the difference is negative, it shows that the Risk group has the higher average loan amount.

   Equality of variances
   SAS reports the equality of variances test using the Folded F test.
       Folded F = 1.14, Pr > F = 0.0016
   Since Pr > F = 0.0016 is less than alpha = 0.05, we reject H0 for the equality of variances test. 
   This means that the variances are significantly different.

   Therefore, the Satterthwaite row should be used for interpreting the t-test.
   T-test result from the Satterthwaite row: t Value = -34.87, Pr > |t| < .0001
   Since the p-value is less than 0.05, we reject the null hypothesis.
   Hence, there is statistically significant evidence that mean loan amount differs between the Risk and No Risk groups.

   The 95% confidence interval for the mean difference is approximately: -2508.7 to -2241.6
   Interval does not include 0, which supports the conclusion that loan amount difference is statistically significant. 
   Since the entire interval is negative, it confirms that the No Risk group has lower mean loan amount than the Risk group.

   Visual interpretation
   The histogram and boxplot show that the Risk group is shifted toward higher loan amounts compared with the No Risk group. 
   Larger loans are more common among borrowers classified as Risk.

   The Q-Q plots show that LoanAmount is not perfectly normally distributed, especially because of skewness and values near the minimum loan amount.
   However, both groups have large sample sizes, so the t-test is fairly robust. Since variances are significantly different, using the
   Satterthwaite row is appropriate.

   Final conclusion
   This result confirms an expected relationship that borrowers classified as Risk tend to have larger loan amounts.
   Loan amount is significantly associated with credit risk in this dataset. Borrowers classified as Risk have much higher average loan amounts than
   borrowers classified as No Risk. Although this relationship is not surprising, it is still important because
   larger loan amounts increase lender exposure and potential financial loss.
   Therefore, loan amount should be considered in later modeling and business recommendations.
*/

/*
   test 3: Are longer loans connected to higher credit risk?
   Longer repayment periods can increase uncertainty and may increase the chance of default. If risky borrowers have longer average loan
   duration, duration becomes an important risk factor.

   Variables used: Risk = categorical variable with 2 groups, LoanDuration = numeric variable

   Test type:Independent samples t-test
   H0: Mean loan duration is equal for Risk and No Risk borrowers.
   H1: Mean loan duration is different for Risk and No Risk borrowers.

   If (Pr > |t|) = p-value < 0.05, loan duration differs significantly between the two risk groups.
 */


title "T-Test 3: Loan Duration Difference by Credit Risk";

proc ttest data=work.cred_clean;
    class Risk;
    var LoanDuration;
run;

/* Descriptive results: The No Risk group has 3330 borrowers with a mean loan duration of 17.90.
   The Risk group has 1670 borrowers with a mean loan duration of 28.36.
   This means that, in this dataset, borrowers classified as Risk have longer loan durations on average than borrowers classified
   as No Risk. The mean difference is approximately -10.46 when calculated as: No Risk mean loan duration - Risk mean loan duration
   Because the difference is negative, it shows that the Risk group has the higher average loan duration. In practical terms, Risk
   borrowers have loan durations about 10.46 units longer on average. If LoanDuration is measured in months, this means Risk borrowers
   have loans about 10.46 months longer on average.

   Equality of variances: SAS reports the equality of variances test using the Folded F test.
   Folded F = 1.01, Pr > F = 0.8465 hence the p-value for the equality of variances test is 0.8465, which is
   greater than alpha = 0.05. Therefore, we do not reject H0 for the variance test, 
   hence there is not enough evidence that the two group variances are significantly different.

   Since the variances are not significantly different, the Pooled row should be used for interpreting the t-test.
   T-test result from the Pooled row: t Value = -34.84, Pr > |t| < .0001, we get p-value less than 0.05, so we reject the null hypothesis.
   There is statistically significant evidence that mean loan duration differs between the Risk and No Risk groups.

   Confidence interval:The 95% confidence interval for the mean difference is approximately: -11.05 to -9.87
   The interval does not include 0, which supports the conclusion that the loan duration difference between the two risk groups is
   statistically significant. Since the entire interval is negative, it confirms that No Risk has a lower mean loan duration than the Risk group.

   Visual interpretation: The histogram and boxplot also support the t-test result. 
   The Risk group distribution is shifted to the right compared with the No Risk group,
   meaning that longer loan durations are more common among borrowers classified as Risk.
   The boxplot shows that the center of the Risk group is higher than the center of the No Risk group. 
   This supports the conclusion that Risk borrowers generally have longer repayment periods.

   The Q-Q plots show that LoanDuration is not perfectly normally distributed, especially at the lower and upper tails. 
   However,the points are reasonably close to the diagonal line in the middle of the distribution.
   Also, both groups have large sample sizes, so the t-test is fairly robust.

   In conclusion, loan duration is significantly associated with credit risk in this dataset. 
   Borrowers classified as Risk have substantially longer loan durations on average than borrowers classified as No Risk.
   This is an important insight as longer repayment periods create more uncertainty for lenders. 
   The longer the loan remains active, the more time there is for changes in the borrower's financial situation, such as job loss, 
   income instability, or other repayment difficulties. Therefore, loan duration should be considered an important variable in later recommendations.
 */





















/* not checked yet, to be continued */


/*
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
 */


/* 
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
*/

title "Chi-Square Test 1: Association Between Age Group and Credit Risk";

proc freq data=work.cred_clean;
    tables Age_Group*Risk / chisq expected cellchi2;
run;


/*
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
 */

title "Chi-Square Test 2: Association Between Loan Amount Group and Credit Risk";

proc freq data=work.cred_clean;
    tables LoanAmount_Group*Risk / chisq expected cellchi2;
run;


/* 
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
  */

title "Chi-Square Test 3: Association Between Loan Duration Group and Credit Risk";

proc freq data=work.cred_clean;
    tables LoanDuration_Group*Risk / chisq expected cellchi2;
run;


/* 
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
 */

title "Chi-Square Test 4: Association Between Credit History and Credit Risk";

proc freq data=work.cred_clean;
    tables CreditHistory*Risk / chisq expected cellchi2;
run;


/*
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
  */

title "Chi-Square Test 5: Association Between Checking Status and Credit Risk";

proc freq data=work.cred_clean;
    tables CheckingStatus*Risk / chisq expected cellchi2;
run;


/* 
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
 */

title "Chi-Square Test 6: Association Between Existing Savings and Credit Risk";

proc freq data=work.cred_clean;
    tables ExistingSavings*Risk / chisq expected cellchi2;
run;


/*
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
    */

title "Chi-Square Test 7: Association Between Employment Duration and Credit Risk";

proc freq data=work.cred_clean;
    tables EmploymentDuration*Risk / chisq expected cellchi2;
run;


/* 
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
 */


/* 
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
 */

title "ANOVA Test 1: Loan Amount by Credit History";

proc glm data=work.cred_clean;
    class CreditHistory;
    model LoanAmount = CreditHistory;
    means CreditHistory / hovtest=levene welch tukey;
run;
quit;


/* 
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
 */

title "ANOVA Test 2: Loan Duration by Checking Account Status";

proc glm data=work.cred_clean;
    class CheckingStatus;
    model LoanDuration = CheckingStatus;
    means CheckingStatus / hovtest=levene welch tukey;
run;
quit;


/* 
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
*/

title "ANOVA Test 3: Loan Amount by Existing Savings";

proc glm data=work.cred_clean;
    class ExistingSavings;
    model LoanAmount = ExistingSavings;
    means ExistingSavings / hovtest=levene welch tukey;
run;
quit;


/*
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
 */

title "ANOVA Test 4: Age by Employment Duration";

proc glm data=work.cred_clean;
    class EmploymentDuration;
    model Age = EmploymentDuration;
    means EmploymentDuration / hovtest=levene welch tukey;
run;
quit;


/* cleaning current title so it will not appear in later outputs */
title;
