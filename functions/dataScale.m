function [y, mu, sigma] = dataScale(x, varargin)

    p = inputParser();
    p.KeepUnmatched = true;

    addRequired(p, 'x', @isnumeric);
    addOptional(p, 'mu', [], @(x) isempty(x) | isnumeric(x));
    addOptional(p, 'sigma', [], @(x) isempty(x) | isnumeric(x));

    if exist('OCTAVE_VERSION', 'builtin') ~= 0
        addParamValue(p, 'mode', 'std', @ischar);
    elseif verLessThan('matlab', '8.2')
        addParamValue(p, 'mode', 'std', @ischar);
    else
        addParameter(p, 'mode', 'std', @ischar);
    end

    parse(p, x, varargin{:});

    assert(~xor(isempty(p.Results.mu), isempty(p.Results.sigma)), 'mu and sigma cannot exist allone.');

    m = size(p.Results.x,1);
    mu = p.Results.mu;
    sigma = p.Results.sigma;
    
    if isempty(p.Results.mu)     
        switch p.Results.mode
            case 'std'
                mu = nanmean(x,1);
                sigma = nanstd(x,[],1);
            case 'range'
                mu = mean(x,1);
                sigma = range(x,1);
            case 'unsigned'
                mu = min(x,[],1);
                sigma = range(x,1);
            otherwise
                error('Wrong mode! Please use std or range.')
        end
    end
    
    mu(sigma==0) = 0;
    sigma(sigma==0) = 1;
    
    y = (x-ones(m,1)*mu)./(ones(m,1)*sigma);
end
