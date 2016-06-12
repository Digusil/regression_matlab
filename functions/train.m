%% train: train regression
function [theta, J, flag] = train(inputs, targets, hypothesis, lambda, theta0, options)

	options_tmp = optimset('Display','off');
	options = optimset(options_tmp, options);

	[theta, J, flag] = fminunc(@(theta) costfunction(inputs, targets, theta, hypothesis, lambda),theta0, options);

	% optimisation for cerf hypothesis (log-function)
	%[theta, J, flag] = fmincon(@(theta) costfunction(inputs, targets, theta, hypothesis, lambda),theta0, [],[],[],[],[0;-Inf;-Inf],[1;Inf;Inf], [], options);

	if flag == 0 && strcmp(options.Display, 'off')
		warning('Optimisation:Iterations', 'Optimisation exeeds maximum number of iterations!')
	end

end
