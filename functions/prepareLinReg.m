%% prepareLinReg: prepare the date to calculate a linear regression
function [data, id_data] = prepareLinReg(inputs, targets, varargin)

	p = inputParser;

	addRequired(p, 'inputs', @isnumeric);
	addRequired(p, 'targets', @(x)validateattributes(x,{'numeric'},{'column'}));
	addOptional(p, 'id_data', [], @iscell);

	if verLessThan('matlab', '8.2.0.29')
		addParamValue(p, 'scaling', true, @islogical);
		addParamValue(p, 'datasplit', [60, 20, 20], @(x)validateattributes(x,{'numeric'},{'size',[1,3]}));
	else
		addParameter(p, 'scaling', true, @islogical);
		addParameter(p, 'datasplit', [60, 20, 20], @(x)validateattributes(x,{'numeric'},{'size',[1,3]}));
	end

	parse(p, inputs, targets, varargin{:});

	if p.Results.scaling
		[inputs_data, inputs_mu, inputs_sigma]  = dataScale([ones(size(p.Results.inputs,1),1),p.Results.inputs]);
		[targets_data, targets_mu, targets_sigma]  = dataScale(p.Results.targets);
	else
		inputs_data = [ones(size(p.Results.inputs,1),1),p.Results.inputs];
		inputs_mu = zeros(1,size(inputs_data, 2));
		inputs_sigma = ones(1,size(inputs_data, 2));

		targets_data = p.Results.targets;
		targets_mu = zeros(1,size(targets_data, 2));
		targets_sigma = ones(1,size(targets_data, 2));
	end
	
	if isempty(p.Results.id_data)
		[tmpdata, id_data] = splitDataRandom(inputs_data, targets_data, p.Results.datasplit);
	else
		[tmpdata, id_data] = splitDataRandom(inputs_data, targets_data, p.Results.datasplit, p.Results.id_data);
	end

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