close all
clear all
clc

init

hypothesis = @(inputs, theta) theta(1) + sin(theta(2)*inputs);

inputs = linspace(0,5*2*pi, 1e3)';

[reglin, y0] = regLinearize(inputs, [1;1], hypothesis);

plot(inputs, reglin(:,2))