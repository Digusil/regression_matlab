%% train: train regression
function [theta, J, flag] = train(inputs, targets, hypothesis, lambda, options)

	options_tmp = optimset('Display','off');
	options = optimset(options_tmp, options);
	
	[theta, J, flag] = fminunc(@(theta) costfunction(inputs, targets, theta, hypothesis, lambda),zeros(size(inputs,2),1), options);
	
	if flag == 0 && strcmp(options.Display, 'off')
		warning('Optimisation:Iterations', 'Optimisation exeeds maximum number of iterations!')
	end
	
end