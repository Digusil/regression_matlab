function [data, id_data] = splitDataRandom(inputs, targets, varargin)

	defaultdatasplit = [60, 20, 20];

	p = inputParser();
	p.KeepUnmatched = true;

	addRequired(p, 'inputs', @isnumeric);
	addRequired(p, 'targets', @(x) isnumeric(x) & size(x,2) == 1);
	addOptional(p, 'id_data', [], @(x) isempty(x) | iscell(x));

	if exist('OCTAVE_VERSION', 'builtin') ~= 0
		addParamValue(p, 'datasplit', [], @(x) isempty(x) | (isnumeric(x) & all(size(x,2) == [1,3])));
	elseif verLessThan('matlab', '8.2')
		addParamValue(p, 'datasplit', [], @(x) validateattributes(x,{'numeric'},{'size',[1,3]}));
	else
		addParameter(p, 'datasplit', [], @(x) validateattributes(x,{'numeric'},{'size',[1,3]}));
	end

	parse(p, inputs, targets, varargin{:});

	if ~isempty(p.Results.datasplit) & ~isempty(p.Results.id_data)
		warning('id_data overrides the setted data split distribution')
	end

	if isempty(p.Results.datasplit)
		datasplit = defaultdatasplit;
	else
		datasplit = p.Results.datasplit;
	end

	id_data = p.Results.id_data;

	m = size(p.Results.inputs, 1);

	indeces_perm = randperm(m);

	N = numel(datasplit);
	M = sum(datasplit);

	ind = 0;

	for k = 1:N-1
		if isempty(p.Results.id_data)
			id_data{k} = indeces_perm(1:floor(m*datasplit(k)/M));
			indeces_perm = indeces_perm(length(id_data{k})+1:end);
		end
		data{k}.inputs = p.Results.inputs(id_data{k},:);
		data{k}.targets = p.Results.targets(id_data{k},:);
	end

	if isempty(p.Results.id_data)
		id_data{N} = indeces_perm;
	end
	data{N}.inputs = p.Results.inputs(id_data{N},:);
	data{N}.targets = p.Results.targets(id_data{N},:);
end
