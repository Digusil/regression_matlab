clear all
close all
clc

init

x = linspace(-5, 5, 1e3)';
y = zeros(size(x));

y(x>0) = 1;

inputs = [x]; %, x.^2];

data = prepareLinReg(inputs, y, 'scaling', false);

options = optimset('Display','off', 'GradObj','on');
fitdata = logitReg(data, [0;0], options);

plot(x, fitdata.function(inputs))
hold on
scatter(x,y)
hold off

grid on