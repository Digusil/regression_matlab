%% example_hypothesis: an example hypothesis
function [h, dh] = example_hypothesis(inputs, theta)
	h = inputs*theta;
	if nargout > 1
		dh = inputs;
	end
end