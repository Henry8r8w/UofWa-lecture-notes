### RCM: Estimation by Regression


### RCM: CIA vs IA
If CIA holds but IA does not, erroneous conclusions may be drawn by
ignoring the “C”. Technically, it may be
$$E[Y| D = 1] - E[Y | D = 0] \neq E[Y(1) - Y(0)]$$


We can still recover the ATE via E[CATE(X)], but with CRA we must pass via
the CATEs

Identifiability of CATE & ATE holds if the weaker Conditional Mean
Independence Assumption (20) holds

$$CMIA: E[Y_{ji}\ D_i, xi] = E[Y_{ij}| x_i] \forall j = 0,1; \forallx_i \quad (20)$$

- We proved Identifiability of CATE & ATE under the stronger CIA b/c it is a
key property of data from a RCT with CRA of the treatment.
### RCM: CIA, CATE, and ATE

Under CIA and the Conditional Overlapping Assumption (18):

$$CIA: (Yi(1),Yi(0))⊥Di |Xi$$
$$COC: 0 <Pr(Di =1 |xi =x)<1 ∀x \quad(18)$$

(1) CATE(x)is identified ∀x and can be consistently estimated by the x-cell
difference in avg outcomes;

(2) ATE is given by (19), it is identified, and consistently estimated by a
weighted avg of the estimated CATEs where the weights are given by the
empirical distr. of x.
$$ATE=E[CATE(x)]= \int CATE(x)f(x)dx \quad (19)$$



### RCM: Conditional Average Treatment Effect (CATE)
For each x-cell, a conditional ATE can be identified:
$$CATE = E[ITE_i | x_i = x]$$

- If $CATE(x) \neq CATE(x')$ for some $x \neq x'$, we say that the treatment is hetergenous depending on x or "treatment interacting with x"

- Krueger (QJE 1999) is an application (described below) in which CIA but not
IA holds: the treatment in Krueger’s RCT is randomized at the school-level
across children but potential outcomes and treatment need not be
independent unconditionally b/c different schools may employ different
randomization probabilities (i.e. $D_i NOT(\perp) x_i$)
### Control group v.s. control variables ('controls')
Two types of control

1. The control group: That is, those with Di =0, and
2. The control variables: That is, the (vector) Xi.

- The latter are often called “controls” since we must ‘control for them’ in
order to attain random assignment.
- With context, the distinction is clear, but keep in mind that “control” can
mean two very different things!

### RCM: RCTs
Some RCTs implement conditional RA (CRA).

CRA is tantamount to the Conditional Independence Assumption (15): the
sample is first ”stratified” based on a pre-determined var x, then RA is
applied within a ”stratum” / an x-cell

$$CIA: (Y_i(1), Y_i(0)) \perp D_i | X_i \quad (15)$$

Each i is characterized by (Di,Yi(1),Yi(0),Xi), an i.i.d. draw from the joint
pop distr. G. 

Thus, (15) says that, conditional on x, the joint distr. of (D_i,Y_i(1),Y_i(0)) can be factored into the product of the (cond. on x ) joint distribution of (Y_i(1),Y_i(0))and the (cond. on x ) distribution of D_i Condition (15) is also
referred to as x-conditional treatment ignorability
```
Select a sample of (not yet Ride Pass) Uber riders at a point in time. Partition
(”stratify”) them based on their tenure, x. In each x - cell, assign Ride Pass
subscription by the flip of a ( n unbalanced) coin that yields Ride Pass status
with probability p(x). Wait.
```
### RCM: ATT and ATU
Two other treatment effect that should be included in discussion
- the Average Treatment Effect on the Treatment (ATT):
$$ATT \equiv E[ITE_i | D_i = 1]$$

- the Average Treatment Effect on the Untreated (ATU):
$$ATU \equiv E[ITE_i | D_i = 0]$$

**Claim**
ATE is a weighted average of ATT and ATU where the weights are given by the treatment assignment probability distribution:

$$ATE = Pr(D_i = 1) x ATT + Pr(D_i = 0) x ATU$$

Under the Independence Assumption and Mean Independence Assumption (which weakens D_i)
$$ATE = ATT = ATU$$
- ATT and ATU thus are identified
    - yeah... it is quite pointless; if D_i is super independent to the outcomes, then there is absolutely no meaning of any control trial; why the pain...ugh

Thus we must come around with a weaker condition than the Independence Assumption and Mean Independence Assumption
```
Suppose the No-treatment Independence Assumption (11) holds. Then, ATT is
identified and is consistently estimated by the treatment-control difference in
avg outcomes.

Suppose the With-treatment Independence Assumption (12) holds. Then, ATU
is identified and is consistently estimated by the treatment-control difference
in avg outcomes.
```
$$IA_0 : Y_i(0) \perp D_i \quad (11)$$

$$IA_1 : Y_i(1) \perp D_i \quad (12)$$



Why may it matter that IA0 suffices for identification of ATT (instead of
requiring the stronger IA)?

In RCTs, IA holds so we don’t care about weakening it to IA0.

With observational data, that is, when treatment is self-selected, the fact
that ATT is identified under IA0 is convenient as it allows for selection on
the ITEi (called selection on gains).

Of course, the proof of the above claim shows that, similarly to an
argument presented above, ATT (respectively ATU) is identified under the
weaker No-treatment Mean Independence Assumption (13) (respectively
With-treatment Mean Independence Assumption (14))

$$MIA_0 : E[Y_i(0)| D_i = 1] = E[Y_i(0)| D_i = 0]$$

$$MIA_0 : E[Y_i(1)| D_i = 1] = E[Y_i(1)| D_i = 0]$$


When are we interested in ATE vs ATT vs ATU? It depends on the question /
intervention.
- E.g., consider the causal effect of (the offer of) training on post-training
earnings of presently unemployed indivs. In such setting we may be more
interested in ATT b/c most people other than the unemployed would not
need job training.

- As an other example, if we are after the causal effect of exercise on blood
pressure, then we most likely are interested in the effect of the treatment
for almost everybody, not just the people who exercise. Then the ATE.

- Say that you have data on an experiment that gives discounts to Uber
drivers. If you want to know the effect of the offer on those who receive the
offer you are after the ATT. If you want to quantify the effect of extending
the discount to all Uber riders you are after the ATE. 


### RCM: RCTs
```
Select a sample of (not yet Ride Pass) Uber riders at a point in time. Assign
Ride Pass subscription by the flip of a coin. Wait. Compute the avg no. of trips
in the two groups. Their difference is a consistent and unbiased estimator of
the ATE of Ride Pass (for existing riders)
```


### RCM: ATE, weaken by Mean Independence Assumption
$$MIA: E[Y_i(a) | D_i = d] = E[Y_i(1)],  E[Y_i(0) | D_i = d] = E[Y_i(0)]$$
- Thus, we can see that under Randomized control trials, the key component should be the random assignment of the treatment, not just the independence assumption

- Independence Assumption may hold in some non-RCT situations alone
    - quasi-experiments: treatment is forced on the subjects by a law /regulation
for reasons independent of ( Yi (1),Yi (0));
    - natural experiments: treatment is forced on the subjects by nature (e.g.
weather, geography)


### Claim: identification of potential outcome distribution is possible
Now, further from the ATE identification, we get the full probability distribution, since

$$Pr(Y_i(d) \leq y) = Pr(Y_i(d) \leq y | D_i = d) = Pr(Y_i \leq y| D_i = d)$$

- However, we would not say that we have the distribution $Pr(Y_i(1) - Y_i(0) \leq t)$ identified, and more specifically $Pr(Y_i(1) - Y_i(0) \geq 0)$
    - Meaning: joint distribution still not identified; only the marginal distribution is



We can know the ATE however, by using the estimator $\hat{ATE} = \bar{y}^{D = 1} - \bar{y}^{D = 0}
- with Law of Large Number, unbiased $E[\hat{ATE}] = ATE$ may achieve


### Claim: ATE's Identifiable
Suppose the independence (aka. unconfoundedness) assumption $(Y_i(1), Y_i(0)) \perp D_i$  and overlapping condition ($0 < P(D_i =1)< 1$)

Observe
$$\text{ATE} \equiv E[Y_i(1) - Y_i(0)] (\text{by ATE definition})= E[Y_i(1)] - E[Y_i(0)] (\text{by linearity of E[.]}) = E[Y_i |D_i = 1] - E[Y_i |D_i = 0]$$


**Note:** The last equation, where \( Y_i \) is expressed without conditioning on \( D_i \), follows from the **overlapping condition**, which ensures that \( Y_i \) is observed for both \( D_i = 1 \) and \( D_i = 0 \), allowing us to estimate expectations from both groups.  

**Note:** The **independence assumption** allows us to treat the assignment of treatment and control as if it were **random**, ensuring that potential outcomes are not influenced by the treatment assignment process. This justifies using the observed outcomes to estimate causal effects.  



### RCM: Average Treatment Effect (ATE)
$$\text{ATE} \equiv E[\text{ITE}_i] = E[Y_i(1) - Y_i(0)]$$

**Without Assumptions**
- ITE is not identified, ATE is impossible
- We could not learn anything on the counterfactual, $Y_i(0)(1 - D_i)$ part of $Y_i = Y_i(0) (1- D_i) + Y_i(1)D_i = Y_i(0) + (Y_i(1) - Y_i(0))D_i$

**With Assumptions**
- ATE is identical, and we can try to learn about the ATE of $(Y_i(1) - Y_i(0))D_i$ part with $E[Y_i(1) - Y_i(0) | D_i = 1]$
$$E[Y_i(1) - Y_i(0) | D_i = 1] = E[Y_i(1)| D_i = 1] - E[Y_i(0) |D_i = 1] = E[Y_i | D_i = 1] - E[Y_i(0)| D_i = 1]$$
    - now, we can say we would know $E[Y_i| D_i =1]$, but not knowing the average counterfactual outcome $E[Y_i(0)|D_i = 1]$
    - we need more assumptions

### RCM: ITE, fundamentals problem in causal inference
- Suppose we observed ($Y_i, D_i$) for all possible units i-- so we could compute the probability distribution of these variables, without any sampling error

- This means that we regard $f(Y_i), f(Y_i |D_i = 1), f(Y_i|D_i = 0)$, and Pr($D_i = 1$), hence moments such as $E[Y_i], E[Y_i | D_i = 1], E[Y_i |D_i = 0]$ etc as known

- In this ideal case we could still not learn about $\text{ITE}_i (Y_i(1)- Y_i(0))$
    - Why? For each i we have ($Y_i, D_i$), giving us $Y_i(1)$(given $D_i = 1$) or $Y_i(0)$(if $D_i = 0$) but never both
    - We could only observe one potential outcome
    - realized outcome, $Y_i(D_i) = Y_i$ will be known, but not the counterfactual outcome $Y_i(0)(1 - D_i)$

- At the same time, we could not known the distribution of $ITE_{i}$
    - however, we do know some features of the distributions such as the mean, median, and alpha-quantile, etc of the distribution



### RCM: Individual Treatment Effect (ITE)
- What is the causal effect of the treatment for i? It is the Individual Treatment Effect, defined as:
 $$\text{ITE}_i \equiv Y_i(1) - Y_i(0)$$
 - ex. using the Uber Ride Pass example, we would say that the ITE_i is the difference in i's number ride with and without Ride Pass subscription
- IF $\text{ITE}_i = \text{ITE}_j  \forall i \neq j$ we say that TE is homogenous / constant / other causes has not effect on our interested treatment/ treatment is same for all. If $\text{ITE}_i \neq \text{ITE}_j$ for some $i \neq j $, we say that TE is heterogenous/ some other causes influences our interested treatment on the / some individual don't get the same treatments
    - note: i and j both arbitrary denotes individual in the treatment
### RCM: Setup
Example: Uber Ride Pass
An Uber rider is a triplet ($Y_i(0), Y_i(1), D_i$) where
$$
D_i = 
\begin{cases}
1 & \text{ if i is a Ride Pass subscriber,}\\
0 & \text{ otherwise}
\end{cases}
$$
The potential outcomes will be:
- $Y_i(1)$ = number of Uber rides with Ride Pass
- $Y_i(0)$ = number of Uber rides without Ride Pass

Any given i is either treated or not. Therefore we either observe $Y_i(0)$ (if he does not get treated) or $Y_i(1)$ 

We call the outcome corresponding to the assigned treatment the **realized outcome** and the outcome corresponding to the treatment not assigned the **counterfactual outcome**

The observed outcome, denoted $Y_i$, can thus be expressed as:
$$Y_i = Y_i(0) (1- D_i) + Y_i(1)D_i = Y_i(0) + (Y_i(1) - Y_i(0))D_i$$

We are interested in the causal effect of the (binary treatment) $D_i$ on $Y_i$, equivalently, in the change in $Y_i$ caused by $D_i$ switching from 1 (with treatment) to 0 (without treatment) all else the same, that is: the causes of ($Y_i(0), Y_i(1)$) but for $D_i$  are kept fixed
- ex. we are interested in the causal effect of Ride Pass subscription on an Uber rider's number of Uber trips over a pre-specified period of time


### RCM: Setup, no spillovers
- In general, we could think that i's hypothetical outcomes in different treatment regimes could depend on $j(\neq i)$'s treatment status

- That is, we could think of writing the potential outcome:
$$Y_i(D_i, D_j)$$

- We will make the assumption (usually implicit), that this is not the case: that i's outcomes do not depend on the treatment of any other j

$$Y_i(D_i, 0) = Y (D_i, 1)$$
    - this assumption is called "no spillovers" and is part of the SUTVA assumption
    - SUTVA: it is lease possible that i's outcome depends on everybody' else's treatment 
### Potential Outcomes
- In most cases, beyond the treatment $D_i$, there will be other variables $X_i$ (observed and unobserved) that affect i's outcomes

- When we define potential outcomes, we 'hold fixed' these other variables:
$$ Y_i(0) = Y_i(D = 0, X_i), Y_i(1) = Y_i(1, X_i)$$
- We can formally that the only difference between the potential outcomes is the **treatment status**. Upon this bases, then one can formally define 'the effect' of $D_i$ on $Y_i$ for each unit

### RCM: Potential Outcomes
Let i denote a subject (e.g., an individual, rider, customer, tax-payer, household, firm, city, villages, etc)

In the simplest RCm there is 1 outcome variable and treatment is :

$$ D_i = 
\begin{cases}
1 & \text{ if i is treated} \\
0 & \text{otherwise}
\end{cases}
$$
- For each i, we also observe their outcome $Y_i$
- These two variables are observed for each unit ($Y_i, D_i$)
    - note: in practice, $X_i$ is used to observe relevant variables, then return to $Y_i$ later
- Beyond the (Event, Treatment) pairs, each i has a pair of outcomes, called potential outcomes: ($Y_i(0), Y_i(1)$)

Where
- $Y_i(0)$ is the outcome experienced by i without the treatment
- $Y_i(1)$ is the outcome experienced by i with the treatment

Potential outcomes are the key theoretical object for causality in economics

### RCM: Setup
RC has two key elements, variously named:
- treatment/intervention/cause/independent variable
- Outcome/response/dependant variable

The term 'treatment' originates from evaluation of new drugs; now, it is used to refer any variable whose impact on some outcome is the object of study; 
- do note that treatment should not be randomly assigned 
- also note that there may be multiple outcome variables and multiple treatment, rather than binary

### Causality: RCM
- Potential Outcome Model is also known as the Rubin Causal Model (RCM)
    - RCM is the framework for the inference and estimation of causal effects in statistics (named in recognition of Rubin). It handles both situations with experimental as well as observational variation in the cause. As such, the RCM is ideally suited to showcase how RCTs are a way to avoid the selection problem
    - We conclude by establishing a link between the RCM and the traditional linear regression-based study of selection bias as applied to the inference and estimation of causal effects