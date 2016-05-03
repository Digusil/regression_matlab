function se = standardError(inputs, targets, theta, hypothesis, reglin)

	tmp = hypothesis(inputs, theta) - targets;

	sigma = sqrt(tmp'*tmp/(length(targets)-size(inputs,2)-1));

	if nargin < 5
		se = sigma * sqrt(diag(inv(inputs'*inputs)));
	else
		se = sigma * sqrt(diag(inv(reglin'*reglin)));
	end

end