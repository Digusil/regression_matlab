# regression_matlab
A set of functions that make it possible to calculate different regression-models. The choices are Linear, Logistic and Kernel Regression. The script can be implemented in MATLAB and Octave.

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

## Installation
1. Download this repository and save it anywhere on your computer
2. Open the included "startup.m"-file in an editor and fill in the placeholder with the path where the downloaded folder exists
3. Save your changes
4. Copy the "startup.m"-file in the original MATLAB folder (if there is already an existing "startup.m"-file unite the code in one file)
5. Now the library should load automatically and the functions are available for your calculations

## License
See LICENSE file for more information.

## Contributors
Digusil, vy03ravo, simshain, beebee94
