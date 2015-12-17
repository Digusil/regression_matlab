close all
clear all
clc

init	% load functions

%load('data_cerf.txt')

%inputs = data_cerf(:,1);

%targets = data_cerf(:,2);

x = linspace(0,100,1e3);

f = 0.5;
k1 = 1;
k2 = 2;

foo = @(x) f*exp(-k1*x)+(1-f)*exp(-k2*x);

y = foo(x);

targets = y(:);

inputs = x(:);

%inputs = [ones(length(x(:)),1),x(:)];

options = optimset('Display','off', 'GradObj','on');

theta0 = zeros(3,1);

fitdata = calcReg(inputs, targets, @cerf_hypothesis, theta0, options);
