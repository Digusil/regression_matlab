%% regression: train a kernel-regression

% ToDo: data reduction for eval function
function [fit_data] = kernelReg(data, varargin)

	p = inputParser();
%	p.KeepUnmatched = true;

	addRequired(p, 'data', @isstruct);
	addOptional(p, 'options', [], @(x) isempty(x) | isstruct(x));

	if exist('OCTAVE_VERSION', 'builtin') ~= 0
		addParamValue(p, 'kernelname', 'gaussian', @ischar);
		addParamValue(p, 'kernelscaling', 'unscaled', @ischar);
		addParamValue(p, 'mode', 'single', @ischar);
	elseif verLessThan('matlab', '8.2')
		addParamValue(p, 'kernelname', 'gaussian', @ischar);
		addParamValue(p, 'kernelscaling', 'unscaled', @ischar);
		addParamValue(p, 'mode', 'single', @ischar);
	else
		addParameter(p, 'kernelname', 'gaussian', @ischar);
		addParameter(p, 'kernelscaling', 'unscaled', @ischar);
		addParameter(p, 'mode', 'single', @ischar);
	end

	parse(p, data, varargin{:});

	regoptions.kernelname = p.Results.kernelname;
	regoptions.kernelscaling = p.Results.kernelscaling;
	regoptions.mode = p.Results.mode;

	u_feature_train = krFeature(data.inputs.validate, data.inputs.train);
	
	switch p.Results.kernelname
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

	regoptions.kernel = kernelFunction;
	
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

%	theta = train(u_feature_train, data.targets.validate, kernel_hypothesis, 0, theta0, p.Results.options);

	costfun = @(theta, lambda) costfunction(u_feature_train, data.targets.validate, theta, kernel_hypothesis, lambda);
	[theta, J, lambda, flag] = train(costfun, 0, theta0, p.Results.options);

%	kernel_hypothesis = @(x, theta) nadarayaWatsonEstimator(krFeature(x, data.inputs.train),...
%															data.targets.train,...
%															kernelFunction,...
%															theta,...
%															p.Results.kernelscaling);

	kernel_hypothesis = @(x, theta, itrain, ttrain, kernel, kernelscaling)...
						nadarayaWatsonEstimator(krFeature(x, itrain),...
												ttrain,...
												kernel,...
												theta,...
												kernelscaling);

	fit_data = regressiondata(kernel_hypothesis, theta, [], data, 'kernel', regoptions, 'hypoarg',...
							  {data.inputs.train,...
							  data.targets.train,...
							  kernelFunction,...
							  p.Results.kernelscaling});

end