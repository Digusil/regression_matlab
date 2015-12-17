close all
clear all
clc

init	% load functions

load('data_cerf.txt')

x = data_cerf(:,1);

inputs = [ones(length(x(:)),1), x(:)];

targets = data_cerf(:,2);


options = optimset('Display','off', 'GradObj','on');

theta0 = zeros(4,1);

fitdata = calcReg(inputs, targets, @cerf_hypothesis, theta0, options);
