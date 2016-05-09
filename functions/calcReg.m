%% regression: train a regression with bias
function [fit_data] = calcReg(data, hypothesis, theta0, options)

	%data = prepareRegression(inputs, targets);

	lambda_list = 10.^linspace(-6,3,1e3);

	lambda = inf;
	J = inf;

	for idl = 1:length(lambda_list)
		tmp_theta = train(data.inputs.train, data.targets.train, hypothesis, lambda_list(idl), theta0, options);

		tmp_J = costfunction(data.inputs.validate, data.targets.validate, tmp_theta, hypothesis, lambda_list(idl));

		if tmp_J < J
			theta = tmp_theta;
			lambda = lambda_list(idl);
			J = tmp_J;
		end
	end

	fit_data.function = @(x) common_hypothesis(x, theta, hypothesis, data);
	fit_data.theta = theta;
	fit_data.lambda = lambda;
	fit_data.R2 = getR2(hypothesis, theta, data);
	fit_data.data = data;
	fit_data.df = size(data.targets.train, 1) - length(theta) -1;
	fit_data.adjR2 = 1-(1-fit_data.R2)*(size(data.targets.train, 1)-1)/fit_data.df;

	reglin = regLinearize(data.inputs.test, theta, hypothesis);
	fit_data.ase = standardError(data.inputs.test, data.targets.test, fit_data.theta, hypothesis, reglin);
	fit_data.pvalue = (1-tcdf(abs(theta./fit_data.ase), fit_data.df))*2;

end

%% common_hypothesis: linear regression hypothesis
function [h] = common_hypothesis(inputs, theta, hypothesis, data)

	m = size(inputs,1);
	x = (inputs - ones(m,1)*data.inputs.mu)./(ones(m,1)*data.inputs.sigma);

	h = hypothesis(x, theta);

	h = h.*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;

end

%% getR2: get goodness of fit
% function [R2] = getR2(fit_data, data)
%
% 	m = size(data.targets.test,1);
%
% 	x = data.inputs.test .* (ones(m,1)*data.inputs.sigma) + ones(m,1)*data.inputs.mu;
% 	y = data.targets.test .* (ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;
%
% 	R2 = calcR2(fit_data.function(x), y);
%
% end
