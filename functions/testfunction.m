%testfunction: to calculate the coefficient of determination for computed thetas
function [R2] = testfunction(data, hypothesis, theta)

	targets_theta = hypothesis(data.inputs.test, theta);

	R2 = calcR2(targets_theta, data.targets.test);

end
