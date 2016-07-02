%% logithypothesis: hypothesis for a binominal logistic regression
function [y, dy] = logithypothesis(inputs, theta)

	if nargout > 1
		[h, dh] = linReghypothesis(inputs, theta);
	else
		h = linReghypothesis(inputs, theta);
	end

	tmp = exp(-h);

	y = 1./(1+tmp);

	if nargout > 1
		dy = (tmp./(tmp+1).^2*ones(1,size(dh,2))).*dh;
	end

end