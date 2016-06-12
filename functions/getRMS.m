%% getRMS: get RMS
function [rms] = getRMS(theta, hypothesis, data)

	m = size(data.inputs.test,1);

	h = hypothesis(data.inputs.test, theta).*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;
	y = data.targets.test.*(ones(m,1)*data.targets.sigma) + ones(m,1)*data.targets.mu;

	rms = sqrt(mean((y - h).^2));

end