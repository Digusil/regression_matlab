%% linReg: calculate a linear regression

% ToDo: savable fit object
function [fit_data] = linReg(data, lambda_list)

	%data = prepareLinReg(inputs, targets);

	if nargin < 2
		lambda_list = [0, 10.^linspace(-6,3,1e3)];
	end

	lambda = inf;
	J = inf;

	for idl = 1:length(lambda_list)
		[tmp_theta, tmp_J] = trainLinear(data.inputs.train, data.targets.train, lambda_list(idl));

%		tmp_J = costfunction(data.inputs.validate, data.targets.validate, tmp_theta, @linReghypothesis, lambda_list(idl));

		if tmp_J < J
			theta = tmp_theta;
			lambda = lambda_list(idl);
			J = tmp_J;
		end
	end

%	[m,n] = size(data.inputs.train);

%	foo = @(inputs, theta) inputs*theta;

	fit_data.function = @(x) hypothesis(x, theta, data);
	fit_data.theta = theta;
	fit_data.lambda = lambda;
	fit_data.R2 = getR2(theta, @linReghypothesis, data);
	fit_data.data = data;
	fit_data.df = size(data.targets.train, 1) - length(theta) -1;
	fit_data.adjR2 = 1-(1-fit_data.R2)*(size(data.targets.train, 1)-1)/fit_data.df;

	fit_data.se = standardError(data.inputs.test, data.targets.test, fit_data.theta, @linReghypothesis);
	fit_data.pvalue = (1-tcdf(abs(theta./fit_data.se), fit_data.df))*2;
	
	fit_data.rms = getRMS(theta, @linReghypothesis, data);

end

%% hypothesis: linear regression hypothesis
function [h] = hypothesis(inputs, theta, data)

	m = size(inputs,1);

	inputs = [ones(m,1), inputs];

	x = (inputs - ones(m,1)*data.inputs.mu)./(ones(m,1)*data.inputs.sigma);

	h = x*theta;

	h = h.*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;

end

%% getRMS: get RMS
% function [rms] = getRMS(theta, data)
% 
% 	m = size(data.inputs.test,1);
% %	x = data.inputs.test.*(ones(m,1)*data.inputs.sigma) + ones(m,1)*data.inputs.mu;
% 
% 	h = (data.inputs.test*theta).*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;
% 	y = data.targets.test.*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;
% 
% 	rms = sqrt(mean((y - h).^2));
% 
% end

%% getR2: get goodness of fit
% function [R2] = getR2(theta, data)
% 
% 	m = size(data.targets.test,1);
% 
% 	h = (data.inputs.test*theta).*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;
% 	y = data.targets.test .* (ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;
% 
% 	R2 = calcR2(h, y);
% 
% end