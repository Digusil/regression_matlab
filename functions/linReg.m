%% linReg: calculate a linear regression

function [fit_data] = linReg(data, lambda_list)

	if nargin < 2
		lambda_list = [0, 10.^linspace(-6,3,1e3)];
	end

	lambda = inf;
	J = inf;

	for idl = 1:length(lambda_list)
		[tmp_theta, tmp_J] = trainLinear(data.inputs.train, data.targets.train, lambda_list(idl));

		if tmp_J < J
			theta = tmp_theta;
			lambda = lambda_list(idl);
			J = tmp_J;
		end
	end

	foo = @(inputs, theta) inputs*theta;

	fit_data = regressiondata(foo, theta, lambda, data, 'linear');

end