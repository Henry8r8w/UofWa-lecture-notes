### Claim: identification of potential outcome distribution is possible

**Proof

### Claim: ATE's Identifiable
Suppose the independence assumption $((Y_i(1), Y_i(0)) \independent D_i)$  and overlapping condition ($0 < P(D_i =1)< 1$)

Observe
#TODO: need to find out why OFC ensure the last expression
$$\text{ATE} \equiv E[Y_i(1) - Y_i(0)] (\text{by ATE definition})= E[Y_i(1)] - E[Y_i(0)] (\text{by linearity of E[.]}) = E[Y_i |D_i = 1] - E[Y_i |D_i = 0]

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