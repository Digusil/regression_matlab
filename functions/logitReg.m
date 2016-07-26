%% regression: train a regression with bias

% ToDo: savable fit object
function [fit_data] = logitReg(data, theta0, options)

	%data = prepareRegression(inputs, targets);

	if nargin > 2
		options_tmp = optimset('Display','off');
		options = optimset(options_tmp, options);
	else
		options = optimset('Display','off');
	end

	regoptions.solver =  options;

	lambda_list = [0, 10.^linspace(-6,3,1e2)];

	costfun = @(theta, lambda) logitcostfunction(data.inputs.train, data.targets.train, theta, lambda);
	[theta, J, lambda, flag] = train(costfun, lambda_list, theta0, options);

	fit_data = regressiondata(@logithypothesis, theta, lambda, data, 'logit', regoptions);

end