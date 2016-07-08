%% trainLinear: analytic solution for a linear regression
function [theta, J] = trainLinear(inputs, targets, lambda)
	
	E = eye(size(inputs,2));
	E(1,1) = 0;

	theta = pinv(inputs'*inputs + lambda * E) * inputs' * targets;

	if nargout > 1
		J = costfunction(inputs, targets, theta, @linReghypothesis, lambda);
	end
end