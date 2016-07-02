close all
clear all
clc

init

m = 10;		% Samples

inputs = [ones(m,1),linspace(1,10,m)', linspace(-3,6,m)'];
targets = linspace(2,11,m)';

lambda = 1;

theta = [1;2;3];

[J1, dJ1] = costfunction(inputs, targets, theta, @testhypothesis, lambda);

J2 = 0;
dJ2 = zeros(size(theta));

for id = 1:m
	[h, dh] = testhypothesis(inputs(id, :), theta);
	tmp = h - targets(id);
	J2 = J2 + 1/(2*m)*tmp^2;
	dJ2 = dJ2 + 1/m *tmp*dh';
end

for id = 2:length(theta)
	J2 = J2 + 1/(2*m)*lambda*theta(id)^2;
end

tmp_theta = theta;
tmp_theta(1) = 0;

dJ2 = dJ2  + 1/m*lambda*tmp_theta;

check('costfunction J', J1, J2)
check('costfunction dJ', abs(dJ1-dJ2)<ones(size(theta))*1e-10, ones(size(theta)))