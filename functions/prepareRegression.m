%% prepareRegression: prepare the date to calculate a common regression
function [data, id_data] = prepareRegression(inputs, targets, varargin)

	p = inputParser();
%	p.KeepUnmatched = true;

	addRequired(p, 'inputs', @isnumeric);
	addRequired(p, 'targets', @(x) isnumeric(x) & size(x,2) == 1);
	addOptional(p, 'id_data', [], @(x) iscell(x) | isempty(x));

	if exist('OCTAVE_VERSION', 'builtin') ~= 0
		addParamValue(p, 'scaling', true, @islogical);
		addParamValue(p, 'datasplit', [], @(x) isempty(x) | (isnumeric(x) & all(size(x,2) == [1,3])));
	elseif verLessThan('matlab', '8.2')
		addParamValue(p, 'scaling', true, @islogical);
		addParamValue(p, 'datasplit', [], @(x) validateattributes(x,{'numeric'},{'size',[1,3]}));
	else
		addParameter(p, 'scaling', true, @islogical);
		addParameter(p, 'datasplit', [], @(x) validateattributes(x,{'numeric'},{'size',[1,3]}));
	end

	parse(p, inputs, targets, varargin{:});

	if p.Results.scaling
		[inputs_data, inputs_mu, inputs_sigma]  = dataScale(p.Results.inputs);
		[targets_data, targets_mu, targets_sigma]  = dataScale(p.Results.targets);
	else
		m = size(p.Results.inputs, 2);
		[inputs_data, inputs_mu, inputs_sigma]  = dataScale(p.Results.inputs,...
															zeros(1, m),...
															ones(1, m));

		m = size(p.Results.targets, 2);
		[targets_data, targets_mu, targets_sigma]  = dataScale(p.Results.targets,...
															   zeros(1, m),...
															   ones(1, m));
	end

	[tmpdata, id_data] = splitDataRandom(inputs_data, targets_data, varargin{:});

	data.inputs.mu = inputs_mu;
	data.inputs.sigma = inputs_sigma;
	data.inputs.train = tmpdata{1}.inputs;
	data.inputs.validate = tmpdata{2}.inputs;
	data.inputs.test = tmpdata{3}.inputs;

	data.targets.mu = targets_mu;
	data.targets.sigma = targets_sigma;
	data.targets.train = tmpdata{1}.targets;
	data.targets.validate = tmpdata{2}.targets;
	data.targets.test = tmpdata{3}.targets;

end