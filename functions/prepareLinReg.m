%% prepareLinReg: prepare the date to calculate a linear regression
function [data, id_data] = prepareLinReg(inputs, targets, varargin)

	[data, id_data] = prepareRegression([ones(size(inputs,1),1),inputs], targets, varargin{:});

end