function [data, id_data] = splitDataRandom(inputs, targets, splitdistribution, id_data)
    m = size(inputs, 1);    

    indeces_perm = randperm(m);

    N = numel(splitdistribution);
    M = sum(splitdistribution);

    ind = 0;

    for k = 1:N-1
        if nargin < 4
            id_data{k} = indeces_perm(1:round(m*splitdistribution(k)/M));
            indeces_perm = indeces_perm(length(id_data{k}):end);
        end
        data{k}.inputs = inputs(id_data{k},:);
        data{k}.targets = targets(id_data{k},:);
    end

    if nargin < 4
        id_data{N} = indeces_perm;
    end
    data{N}.inputs = inputs(id_data{N},:);
    data{N}.targets = targets(id_data{N},:);
end
