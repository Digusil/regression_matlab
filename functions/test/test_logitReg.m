clear all
close all
clc

init

x = linspace(-5, 5, 1e2)';
y = zeros(size(x));

y(abs(x+2.0*(2*rand(size(x))-1))<=1) = 1;

inputs = [x, x.^2, x.^3]; %, x.^2];

data = prepareLinReg(inputs, y, 'scaling', false);

options = optimset('Display','off', 'GradObj','on');
fitdata = logitReg(data, [0;0;0;0], options);

plot(x, fitdata.function(inputs))
hold on
scatter(x,y)
hold off

grid on