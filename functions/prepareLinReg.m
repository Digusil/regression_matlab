%% prepareLinReg: prepare the date to calculate a linear regression
function [data, id_data] = prepareLinReg(inputs, targets, id_data)
	
	[inputs_data, inputs_mu, inputs_sigma]  = dataScale([ones(size(inputs,1),1),inputs]);
	[targets_data, targets_mu, targets_sigma]  = dataScale(targets);
	
	if nargin < 3
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