%% trainLinear: analytic solution for a linear regression
function [theta] = trainLinear(inputs, targets, lambda)
	
	E = eye(size(inputs,2));
	E(1,1) = 0;

	theta = pinv(inputs'*inputs + lambda * E) * inputs' * targets;

end