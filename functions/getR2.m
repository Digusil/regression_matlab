%% getR2: get goodness of fit
function [R2] = getR2(theta, hypothesis, data)

	m = size(data.targets.test,1);

	h = hypothesis(data.inputs.test, theta).*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;
	y = data.targets.test .* (ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;

	R2 = calcR2(h, y);

end