function [data, id_data] = splitDataRandom(inputs, targets, varargin)

    defaultdatasplit = [60, 20, 20];

    p = inputParser;

    addRequired(p, 'inputs', @isnumeric);
    addRequired(p, 'targets', @(x)validateattributes(x,{'numeric'},{'column'}));
    addOptional(p, 'id_data', [], @iscell);

    if verLessThan('matlab', '8.2')
        addParamValue(p, 'scaling', true, @islogical);
        addParamValue(p, 'datasplit', [], @(x)validateattributes(x,{'numeric'},{'size',[1,3]}));
    else
        addParameter(p, 'scaling', true, @islogical);
        addParameter(p, 'datasplit', [], @(x)validateattributes(x,{'numeric'},{'size',[1,3]}));
    end

    parse(p, inputs, targets, varargin{:});

    if ~isempty(p.Results.datasplit) & ~isempty(p.Results.id_data)
        warning('id_data overrides the setted data split distribution')
    end

    if isempty(p.Results.datasplit)
        p.Results.datasplit = defaultdatasplit;
    end

    id_data = p.Results.id_data;

    m = size(p.Results.inputs, 1);    

    indeces_perm = randperm(m);

    N = numel(p.Results.datasplit);
    M = sum(p.Results.datasplit);

    ind = 0;

    for k = 1:N-1
        if isempty(p.Results.id_data)
            id_data{k} = indeces_perm(1:floor(m*p.Results.datasplit(k)/M));
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
