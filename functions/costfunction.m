%% costfunction: costfunction to calculate a regression
function [J, dJ] = costfunction(inputs, targets, theta, hypothesis, lambda)

	m = size(inputs,1);

	if nargout > 1
		[h, dh] = hypothesis(inputs, theta);
	else
		h = hypothesis(inputs, theta);
	end

	tmp = h - targets;
	
	J = 1/(2*m) * (tmp'*tmp + lambda * (theta'*theta));

	if nargout > 1
		dJ = 1/m * (dh'*tmp + lambda*theta);
	end

end