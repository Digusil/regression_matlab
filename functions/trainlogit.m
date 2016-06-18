%% train: train binominla logistic regression
function [theta, J, flag] = trainlogti(inputs, targets, lambda, theta0, options)

	options_tmp = optimset('Display','off');
	options = optimset(options_tmp, options);

	[theta, J, flag] = fminunc(@(theta) logitcostfunction(inputs, targets, theta, lambda),theta0, options);

	if flag == 0 && strcmp(options.Display, 'off')
		warning('Optimisation:Iterations', 'Optimisation exeeds maximum number of iterations!')
	end

end
