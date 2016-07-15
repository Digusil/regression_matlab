# regression_matlab
A simple set of functions to calculate a regression.
Pairs of input and target values are randomly distributed in training,
validation and test set. Using the training set values of theta can be calculated
for any hypothesis. Lambda is determined by detecting an optimum of the costfunction.
Afterwards the coefficient of determination is computed for the test set.

This script is under construction.

=======
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
The reason for programming this set of functions was to obtain full control over the calculation of the Regression. As well the advanced User should get an insight, what is happening behind function calls. In addition, a special feature of the set is the extension of the range of functions to Kernel Regression and Logistic Regression. All Regression Models can be implemented the same, easy way through the unification of the parameters and input variables.

The development of the program is ensured by constant self-use and research requirements. 

## Usage
Run calcReg.m in Matlab. Load input and target values in your workspace and choose
a hypothesis, initial values for theta and required options.

## License
See LICENSE file for more information.

## Contributors
Digusil, vy03ravo, simshain, beebee94
