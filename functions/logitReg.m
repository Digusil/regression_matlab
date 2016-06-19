%% regression: train a regression with bias

% ToDo: savable fit object
function [fit_data] = logitReg(data, theta0, options)

	%data = prepareRegression(inputs, targets);

	lambda_list = 10.^linspace(-6,3,1e3);

	lambda = inf;
	J = inf;

	count_flag = 0;

	for idl = 1:length(lambda_list)

		if count_flag >= 3
			break
		end
		
		[tmp_theta, tmp_J, flag] = trainlogit(data.inputs.train, data.targets.train, lambda_list(idl), theta0, options);

%		tmp_J = logitcostfunction(data.inputs.validate, data.targets.validate, tmp_theta, lambda_list(idl));

		if flag == 0
			count_flag = count_flag +1;
		elseif flag < 0
			count_flag = 0;
		end

		if tmp_J < J
			theta = tmp_theta;
			lambda = lambda_list(idl);
			J = tmp_J;
		end
	end

	fit_data.function = @(x) hypothesis([ones(size(x,1),1), x], theta, data);
	fit_data.theta = theta;
	fit_data.lambda = lambda;
%	fit_data.R2 = getR2(theta, logithypothesis, data);
	fit_data.data = data;
	fit_data.df = size(data.targets.train, 1) - length(theta) -1;
%	fit_data.adjR2 = 1-(1-fit_data.R2)*(size(data.targets.train, 1)-1)/fit_data.df;

	reglin = regLinearize(data.inputs.test, theta, @logithypothesis);
	fit_data.ase = standardError(data.inputs.test, data.targets.test, fit_data.theta, @logithypothesis, reglin);
	fit_data.pvalue = (1-tcdf(abs(theta./fit_data.ase), fit_data.df))*2;
	fit_data.wald = 1-chi2cdf((theta./fit_data.ase).^2, 1);

%	fit_data.rms = getRMS(theta, logithypothesis, data);

end

%% hypothesis: linear regression hypothesis
function [h] = hypothesis(inputs, theta, data)

	m = size(inputs,1);
	x = (inputs - ones(m,1)*data.inputs.mu)./(ones(m,1)*data.inputs.sigma);

	h = logithypothesis(x, theta);

	h = h.*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;

end