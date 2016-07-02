function [h, dh] = testhypothesis(inputs, theta)

	h = inputs*theta;
	
	if nargout > 1
		dh = inputs;
	end

end