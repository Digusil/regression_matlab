%% prepareRegression: prepare the date to calculate a common regression
function [data] = prepareRegression(inputs, targets, scaling, id_data)
	
	if nargin < 3
		scaling = true;
	end

	if scaling
		[inputs_data, inputs_mu, inputs_sigma]  = dataScale(inputs);
		[targets_data, targets_mu, targets_sigma]  = dataScale(targets);
	else
		inputs_data = inputs;
		inputs_mu = zeros(1,size(inputs_data, 2));
		inputs_sigma = ones(1,size(inputs_data, 2));

		targets_data = targets;
		targets_mu = zeros(1,size(targets_data, 2));
		targets_sigma = ones(1,size(targets_data, 2));
	end

	if nargin < 4
		[tmpdata, id_data] = splitDataRandom(inputs_data, targets_data, [60, 20, 20]);
	else
		[tmpdata, id_data] = splitDataRandom(inputs_data, targets_data, [60, 20, 20], id_data);
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