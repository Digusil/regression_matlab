%% logitcostfunction: costfunction for a binominal logistic regression
function [J, dJ] = logitcostfunction(inputs, targets, theta, lambda)

	m = size(inputs,1);

	h = logithypothesis(inputs, theta);

	theta(1) = 0;
	
	J = 1/m * (-sum(targets.*(log(h)) + (1-targets).*log(1-h)) + lambda * (theta'*theta));

	if nargout > 1
		dJ = 1/m * (-sum((targets-h)*ones(1,size(inputs,2)).*inputs,1)' + lambda*theta);
	end

end