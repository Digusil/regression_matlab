close all
clear all
clc

init	% load functions

x = linspace(0,100,1e3);

f = 0.2;
b1 = 1.3;
b2 = 2;

foo = @(x) log(2*f./(1+exp(b1*x))+2*(1-f)./(1+exp(b2*x)));

y = foo(x);

targets = y(:);

inputs = x(:);

options = optimset('Display','off', 'GradObj','on', 'DerivativeCheck', 'on');

theta0 = [0.3; 1.1; 1.8];

fitdata = calcReg(inputs, targets, @kamau_hypothesis, theta0, options);
