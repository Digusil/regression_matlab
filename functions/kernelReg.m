%% regression: train a kernel-regression

% ToDo: savable fit object
function [fit_data] = kernelReg(data, varargin)

	p = inputParser;
%	p.KeepUnmatched = true;

	addRequired(p, 'data', @isstruct);
	addOptional(p, 'options', [], @isstruct);

	if verLessThan('matlab', '8.2')
		addParamValue(p, 'kernel', 'gaussian', @ischar);
		addParamValue(p, 'kernelscaling', 'unscaled', @ischar);
		addParamValue(p, 'mode', 'single', @ischar);
	else
		addParameter(p, 'kernel', 'gaussian', @ischar);
		addParameter(p, 'kernelscaling', 'unscaled', @ischar);
		addParameter(p, 'mode', 'single', @ischar);
	end

	parse(p, data, varargin{:});

	u_feature_train = krFeature(data.inputs.validate, data.inputs.train);
	
	switch p.Results.kernel
		case 'gaussian'
			kernelFunction = @(u) gaussianKernel(u);
			first_h = estimateH(data.inputs.train);
		case 'cauchy'
			kernelFunction = @(u) cauchyKernel(u);
			first_h = estimateH(data.inputs.train);
		case 'picard'
			kernelFunction = @(u) picardKernel(u);
			first_h = estimateH(data.inputs.train);
		case 'cosinus'
			kernelFunction = @(u) cosKernel(u);
			first_h = max(u_feature_train(:));
		case 'triangle'
			kernelFunction = @(u) triangleKernel(u);
			first_h = max(u_feature_train(:));
		case 'uniform'
			kernelFunction = @(u) uniformKernel(u);
			first_h = max(u_feature_train(:));
		case 'epanechnikov1'
			kernelFunction = @(u) epanechnikovKernel(u, 1);
			first_h = max(u_feature_train(:));
		case 'epanechnikov2'
			kernelFunction = @(u) epanechnikovKernel(u, 2);
			first_h = max(u_feature_train(:));
		case 'epanechnikov3'
			kernelFunction = @(u) epanechnikovKernel(u, 3);
			first_h = max(u_feature_train(:));
		otherwise
			error('Wrong kernel function! Choose a valid kernel function.')
	end
	
	switch p.Results.mode
		case 'single'
			theta0 = first_h;
		case 'multi'
			theta0 = ones(size(u_feature_train,2), 1)*first_h;
	end

	kernel_hypothesis = @(u_feature, theta) nadarayaWatsonEstimator(u_feature,...
																	data.targets.train,...
																	kernelFunction,...
																	theta,...
																	p.Results.kernelscaling);

	theta = train(u_feature_train, data.targets.validate, kernel_hypothesis, 0, theta0, p.Results.options);

	%data = prepareRegression(inputs, targets);

	%lambda_list = 10.^linspace(-6,3,1e3);

	%lambda = inf;
	%J = inf;

	%for idl = 1:length(lambda_list)
	%	tmp_theta = train(data.inputs.train, data.targets.train, userhypothesis, lambda_list(idl), theta0, options);

	%	tmp_J = costfunction(data.inputs.validate, data.targets.validate, tmp_theta, userhypothesis, lambda_list(idl));

	%	if tmp_J < J
	%		theta = tmp_theta;
	%		lambda = lambda_list(idl);
	%		J = tmp_J;
	%	end
	%end

	kernel_hypothesis = @(x, theta) nadarayaWatsonEstimator(krFeature(x, data.inputs.train),...
															data.targets.train,...
															kernelFunction,...
															theta,...
															p.Results.kernelscaling);

%	fit_data.function = @(x) hypothesis(x, theta, kernel_hypothesis, data);
%	fit_data.theta = theta;
%	fit_data.lambda = [];
%	fit_data.R2 = getR2(theta, kernel_hypothesis, data);
%	fit_data.data = data;
%	fit_data.df = size(data.targets.train, 1) - length(theta) -1;
%	fit_data.adjR2 = 1-(1-fit_data.R2)*(size(data.targets.train, 1)-1)/fit_data.df;
%
%	reglin = regLinearize(data.inputs.test, theta, kernel_hypothesis);
%	fit_data.ase = standardError(data.inputs.test, data.targets.test, fit_data.theta, kernel_hypothesis, reglin);
%	fit_data.pvalue = (1-tcdf(abs(theta./fit_data.ase), fit_data.df))*2;
%
%	fit_data.rms = getRMS(theta, kernel_hypothesis, data);

	fit_data = regressiondata(kernel_hypothesis, theta, [], data, 'kernel');

end

%% hypothesis: linear regression hypothesis
function [h] = hypothesis(inputs, theta, userhypothesis, data)

	m = size(inputs,1);
	x = (inputs - ones(m,1)*data.inputs.mu)./(ones(m,1)*data.inputs.sigma);

	h = userhypothesis(x, theta);

	h = h.*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;

end