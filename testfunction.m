%testfunction: to calculate the coefficient of determination for computed thetas
function [R2] = testfunction(inputs_test, targets_test, hypothesis, theta)

targets_theta = hypothesis(theta, inputs_test);

R2 = calcR2(targets_test, targets_theta);

end
