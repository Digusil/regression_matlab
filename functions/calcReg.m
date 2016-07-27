%% regression: train a regression with bias

function [fit_data] = calcReg(data, userhypothesis, theta0, options)

	if nargin > 3
		options_tmp = optimset('Display','off');
		options = optimset(options_tmp, options);
	else
		options = optimset('Display','off');
	end

	regoptions.solver =  options;

	lambda_list = [0, 10.^linspace(-6,3,1e2)];

	costfun = @(theta, lambda) costfunction(data.inputs.train, data.targets.train, theta, userhypothesis, lambda);
	[theta, J, lambda, flag] = train(costfun, lambda_list, theta0, options);

	fit_data = regressiondata(userhypothesis, theta, lambda, data, 'common', regoptions);

end