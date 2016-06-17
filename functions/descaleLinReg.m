%% descaleLinReg: descale the parameter of a scaled linear regression
function [out] = descaleLinReg(fitdata)

	out.theta = zeros(size(fitdata.theta));
	out.theta(2:end) = fitdata.theta(2:end).*fitdata.data.targets.sigma./fitdata.data.inputs.sigma(2:end)';
	tmp = fitdata.theta(2:end).*fitdata.data.inputs.mu(2:end)'./fitdata.data.inputs.sigma(2:end)';
	out.theta(1) = fitdata.data.targets.mu + fitdata.data.targets.sigma*(fitdata.theta(1)-sum(tmp));

	out.se = zeros(size(fitdata.se));
	out.se(2:end) = fitdata.se(2:end).*fitdata.data.targets.sigma./fitdata.data.inputs.sigma(2:end)';
	tmp = fitdata.se(2:end).*fitdata.data.inputs.mu(2:end)'./fitdata.data.inputs.sigma(2:end)';
	out.se(1) = NaN;
	
end