function [h, dh] = linReghypothesis(inputs, theta)

	h = inputs*theta;
	
	if nargout > 1
		dh = inputs;
	end

end