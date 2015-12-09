%testfunction: to calculate the coefficient of determination for computed thetas
function [R2] = testfunction(inputs_test, targets_test, hypothesis, theta)

	targets_theta = hypothesis(inputs_test, theta);
	R2 = calcR2(targets_theta, targets_test);

end
