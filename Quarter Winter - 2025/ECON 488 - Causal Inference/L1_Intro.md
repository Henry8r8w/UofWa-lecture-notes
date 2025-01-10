### Another example
In the preceeding example, we saw that
- ICU risk among vacc’d < ICU risk among unvacc’d

This relationship held for each group:
- ICU risk among elderly vacc’d < ICU rate among elderly unvacc’d,
- ICU risk among young vacc’d < ICU rate among young unvacc’d

However it might be possible that ignoring age groups might have
lead to the opposite conclusion, that is: “ICU risk is higher among
the vacc’d, even though ICU risk within each age group is lower
among the vacc’d.”
- This is called the Yule-Simpson paradox 

A classic example of this paradox is from a study on the effect of
different treatments (Z = 0 and Z =1) on successful treatment of
kidney stones (Y =1 iff success)
|                  | Y = 1            |   Y = 0          |
|------------------|------------------|------------------|
| Z = 1            | 273              |  77              |
| Z = 0            | 289              |  61              |
- it looks like no treatment is better off...


However, it turns out the size are kidney stones are not euqlaly distributed among them 

small stone (X = 1)

|                  | Y = 1            |   Y = 0          |
|------------------|------------------|------------------|
| Z = 1            | 81               |  6               |
| Z = 0            | 234              |  36              |

big stone (X = 0)

|                  | Y = 1            |   Y = 0          |
|------------------|------------------|------------------|
| Z = 1            | 192              |  77              |
| Z = 0            | 55               |  25              |

Notice people with larger stone receive tend to receive treatment

Success rate among Z =0 and X =0 (55/80) < Success rate among Z =1 and X =0 (192/269)
Success rate among Z =0 and X =1 (243/270) < Success rate among Z =1 and X = 0 (81/87)

Now we see how Success rate among Z =0 >Success rate among Z =1 is contradicted

This is a clear example of a confounding variable: Kidney stone size
confounds the relationship between the treatment and success.
- Intuitively: Treatment 1 is better for each group, but treatment 0 is made to look better overall since less severe cases tend to receive treatment 0 more often

$X \to (0) Z, X \to (1) Y, Z \to (1) Y$

### An introductory Example

Example (Covid Data)
In the summer of 2021 a viral Facebook post went around, reporting on counts of patients in ICUs in Israel. Israel had started immunization against COVID19 early and had achieved very high coverage. The post contained a table like this (not the actual figures)

Table 1

| Type of Patient  | Patients in ICUs |
|------------------|------------------|
| Vaccinated (V)   | 2,000            |
| Not Vaccinated (NV) | 100          |

- From this table, some make the argument: 2000> 100, so the vaccination does not reduce ICU risk

Table 2 (revised from table 1)
| Type  | # in ICUs | Population | Risk By Type        |
|-------|-----------|------------|---------------------|
| V     | 2,000     | 2 M        | 2,000 / 2,000,000 = 0.1% |
| NV    | 100       | 100 K      | 100 / 100,000 = 1%       |

- From this table, some make the argument: immunization is reposible for the 10-fold reduction of ICU risk (1% to 0.1%)

Table 3( revised from table 2)

| Type | Sub-Type | # in ICUs | Population | ICU Risk             |
|------|----------|-----------|------------|----------------------|
| V    | < 60y    | 1,900     | 1.9 M      | 1,900 / 1,900,000 = 0.1% |
| V    | ≥ 60y    | 100       | 100 K      | 100 / 100,000 = 0.1%      |
| NV   | < 60y    | 18        | 9 K        | 18 / 9,000 = 0.2%         |
| NV   | ≥ 60y    | 82        | 1 K        | 82 / 1,000 = 8.2%         |

- From this table, some finalized the argument: immunization caused a 2-fold reduction in ICU risk for the < 60y group (from 0.2% down to 0.1%) and an 80 fold reduction for the >=60y group


HOWEVER, we cannot make this conclusion as econometrician. We do not know if the vaccinated indivisual are more health awared indinvsula s.t. they may have other factors in their live (ex. healthy lifestyle, mindset, and financial wealth etc) that contribute to the ICU percent reduction

To arrive at a credible answer we need an RCT.
Lacking an RCT, we can utilize some of the methodologies covered in
ECON488 which (in different ways) try to ”correct/account” for the fact that people select into the treatment they receive (immunization).
### Causality: in ECON488
- We limits no expiermental variation to answer causal questions (account for friction)
- We start by revewing how data from RCTS are analzyed and highlight how it solves the seleciton porblme and uncovers the causal effect of a treatment
    - The framework name: Potentail Outcome Model
    - Relevant statsical methods will come in later lectures
The tools that 488 mainly teach
- Regression
- Matching (on Covariates, on Propensity Score)
- Inverse-Probability Weighting
- Imputation/Projection Methods
- Before-and-After Comparisons
- Differences-in-Differences
- Synthetic Controls
- Instrumental Variables
- Regression Discontinuity Design
- Some ML (new topic)
    - to help us with fexlibility and ease out  a-priori/ad-hoc assumptions
### Causality: RCT Limitation
- Implementation hurdles: RCTs are often enormously expensive, take a long time to plan and execute, often raise difficult
ethical issues.
- Lack of generalizability / External validity: results are only valid for the sample of individuals who were assigned to treatment
and control and this sample may be different from the population at large; also they are of no help in predicting the impact
of alternative interventions. Also, if programs are scaled up the supply side implementing the treatment may be different
(e.g. less motivated).
- Attrition Bias: Often individuals leave the RCT before it is complete; this is not a problem if individuals leave randomly but it
may be that those who leave are those for whom the treatment is having negative or less positive effects.
- Hawthorne or John Henry Bias: People may behave differently b/c they are part of an RCT either as experimental or control
subjects.
- Substitution Bias: Control group members may seek substitutes for treatment; this would bias estimated treatment effects
downwards. Can also occur if the RCT frees up resources that can now be concentrated on the control group.
- Compliance Bias: Treatment and control members may comply with the assignment only imperfectly.
- Contamination Bias: Spillover and externality effects may imply that the control group is also indirectly treated

### Causality: RCTs
A first line of attack on the causality problem is a randomized
experiment, often called a randomized control trial (RCT).

Random assignment (RA) is not the same as holding everything else
fixed, but it has the ”same” effect in the following sense
- two groups may have other diemsinoal differneec, but enough indinvuslas with random assignment, we should have a rougly better groups 


RCT by RA essentialy can help us turn association between cause-and-effect into a causal relationship

Some examples of well known controlled social experiments:
- Labor Economics: impact of training programs on earnings and employment.
- Public Finance: impact of transfer programs on labor supply.
- Economics of Education: impact of class size on student learning.
- Health Economics: impact of health insurance on utilization of health care.
- Corporate Finance: impact of managers on firm policies.
- Industrial Organization: impact of marketing on sales.
- Personnel Economics: impact of team size on productivity.
- Development Economics: impact of deworming programs on children


The data produced in conjunction with a RCT is called experimental
data and the variation in the cause induced by a RCT is called
experimental variation

There is also quasi-experimental data, hence quasi-experimental
variation: naturally occurring events (e.g. weather) may induce
variation in the cause that is as good as randomly assigned

### Causality: All Else the Same
Main challenge in addressing a causal effect question (Q2):
- it relies on hypothetical scenario hard to create
- it relies a concrete definition between sample groups

Say now we really want to address question 2, can one use association effect to answer a causla effect question?
- Nope, the confounder effect will exist
- Say we propose that riders who are likely to join with a Ride Pass may expect a high frequency of travel, it it still likely that people who choose to ride without the Pass as they may have a demand for the ride itself but not the incentive to subcribe to the pass 

### Causality: Setting the Stage
There are two main objectives in data analysis:
- being able to harness description of your data and prediction of your data
    - emphasis on the moments/properties of reponse variables, to reflect association but not the causation
- performing causal inference based upon on your data
    - emphasis on measument and/or empierical confirmation of conjectures and propsotions regarding causal behaviours

When we carry a CI, data is used to address the cuase-and-effect questions
- Think of the difference between the two questions

1. Do Uber Ride Pass subscribers make more trips on avg than non-Ride Pass Uber riders? (seeks association)
    - avg # of rides of Ride Pass vs. no Ride Passs members

2. Does having a Uber Ride Pass, all else the same, cause an (avg) Uber rider to make more trips (seeks causation)
    - Uber Ride Pass ubscription $\to$? difference number of rides
note: only comparisons made under ceteris paribus (e.g., all else the same) conditions have a causal interpretations
