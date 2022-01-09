Bayesian Spatial Propensity Score Matching (BS-PSM)
---------------------------------------------------
Rolando Gonzales Martinez

Updated and tested to run on MatLab 2020a (January 2022)

In order to run the BS-PSM algorithm you will need:

       (1) A n x n spatial contiguity matrix (W)
       (2) A n x 1 binary treatment vector(y)
       (3) A n x p matrix of potential explanatory variables (X)
       (4) A n x 1 variable that measures the impact (I) of the treatment
       
There is a need also to define the parameters of the MCMC simulation:

       - ndraws: number of draws (simulations) of the MCMC
       - nomit: burn-in 
       
By default, the prior of rho is elicitated in the positive range (0,1]
BS-PSM uses some functions of James LeSage Spatial Econometrics Toolbox
To run an example file check BSPSM_poverty_example.m
