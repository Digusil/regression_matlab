close all
clear all
clc

init

m = 10;		% Samples

inputs = [linspace(1,10,m)', linspace(-3,6,m)'];
targets = linspace(2,11,m)';

lambda = 1;

options = optimset('GradObj','on');

tic
theta1 = trainLinear(inputs, targets, lambda);
t1 = toc;

tic
[theta2, J, flag] = train(inputs, targets, @testhypothesis, lambda, options);
t2 = toc;

J1 = costfunction(inputs, targets, theta1, @testhypothesis, lambda);
J2 = costfunction(inputs, targets, theta2, @testhypothesis, lambda);

disp([t1, t2])

check('trainLinear', J1 < J2, true)
