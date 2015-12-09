function [R2] = adjustR2(fit_data, data)

m = size(data.inputs.test,1);

x = data.inputs.test.*(ones(m,1)*data.inputs.sigma)+ones(m,1)*data.inputs.mu;
y = data.targets.test.*(ones(m,1)*data.targets.sigma)+ones(m,1)*data.targets.mu;

R2 = calcR2(fit_data.function(x), y);

end
