%% descaleLinReg: descale the parameter of a scaled linear regression
function [out] = descaleLinReg(fitdata)

	out.theta = zeros(size(fitdata.theta));
	out.theta(2:end) = fitdata.theta(2:end).*fitdata.data.targets.sigma./fitdata.data.inputs.sigma(2:end)';
	tmp = fitdata.theta(2:end).*fitdata.data.inputs.mu(2:end)'./fitdata.data.inputs.sigma(2:end)';
	out.theta(1) = fitdata.data.targets.mu + fitdata.data.targets.sigma*(fitdata.theta(1)-sum(tmp));

	out.se = zeros(size(fitdata.ase));
	out.se(2:end) = fitdata.ase(2:end).*fitdata.data.targets.sigma./fitdata.data.inputs.sigma(2:end)';
	tmp = fitdata.ase(2:end).*fitdata.data.inputs.mu(2:end)'./fitdata.data.inputs.sigma(2:end)';
	out.ase(1) = NaN;
	
end