% validation: calculates R2 for the validation data and holds the best lambda
function [lambda_opt] = validation(inputs, targets, theta, lambda)

  inputs_valid = inputs();                    % Import of input and output data for the validation
  targets_valid = targets();

  h_valid = hypothesis(inputs_valid, theta);  % calculation of hypothesis for the current theta-values (for the choosen lambda)

  R2_valid = calcR2(h_valid, targets_valid);  % calculation of R2 for the validation data


  if R2_valid > R2_valid_old

    lambda_opt = lambda;                      % lambda_opt is the best fitting value of all tested lambda

  end

    R2_valid = R2_valid_old;

end
