%% train: train binominla logistic regression
function [theta, J, flag] = trainlogti(inputs, targets, lambda, theta0, options)

	if nargin > 4
		options_tmp = optimset('Display','off');
		options = optimset(options_tmp, options);
	else
		options = optimset('Display','off');
	end

	[theta, J, flag] = fminunc(@(theta) logitcostfunction(inputs, targets, theta, lambda),theta0, options);

	if flag == 0 && strcmp(options.Display, 'off')
		warning('Optimisation:Iterations', 'Optimisation exeeds maximum number of iterations!')
	end

end
