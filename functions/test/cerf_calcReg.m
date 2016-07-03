close all
clear all
clc

init	% load functions

%load('data_cerf.txt')

%inputs = data_cerf(:,1);

%targets = data_cerf(:,2);

x = linspace(0,100,1e3);

f = 0.2;
k1 = 0.8;
k2 = 1;

foo = @(x) log(f*exp(-k1*x)+(1-f)*exp(-k2*x));

y = foo(x);

targets = y(:);

inputs = x(:);

options = optimset('Display','off', 'GradObj','on');

theta0 = [0.3; 0.7; 0.9];

fitdata = calcReg(inputs, targets, @cerf_hypothesis, theta0, options);

% Verwendung des Solvers fmincon in train.m zur Beschränkung des Wertebereichs
% der gesuchten thetas, um negative Werte in der log-Funktion zu verhindern
