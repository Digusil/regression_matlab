# regression_matlab
A simple set of functions to calculate a regression.
Pairs of input and target values are randomly distributed in training,
validation and test set. Using the training set values of theta can be calculated
for any hypothesis. Lambda is determined by detecting an optimum of the costfunction.
Afterwards the coefficient of determination is computed for the test set.

## Examples
**example_linReg.m** calculates the regression for a linear hypothesis.

The structure *fitdata* gives back the chosen hypothesis, a vector for theta,
the best fitting value of lambda and the calculated coefficient of determination.

    function: @(x)hypothesis(x,theta,data)
       theta: [6x1 double]
      lambda: 1.0000e-06
          R2: 1

**example_calcReg** calculates the regression for a hypothesis given in
**example_hypothesis.m**.

## Motivation
Reasons for implementing this regression code:
- follow every step of the calculation
- get a significant fit by distributing the applied values in sets
- apply code for different hypotheses without changing the environment

## Usage
Run calcReg.m in Matlab. Load input and target values in your workspace and choose
a hypothesis, initial values for theta and required options.

## License
See LICENSE file for more information.

## Contributors
Digusil, vy03ravo, simshain
