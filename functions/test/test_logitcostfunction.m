clear all
close all
clc

init

if ~exist('numlinearize.m','file')
	addpath('K:\Projekte\PhD\MATLAB\usefull');
end

N = 1e4;

inputs = [ones(N, 1), linspace(-0, 10, N)'];
targets = round(rand(N,1));

theta = [-5;0.3];

test = numlinearize(@(theta) logitcostfunction(inputs, targets, theta, 0), theta)';
[J, dJ] = logitcostfunction(inputs, targets, theta, 0);

datatest = abs(dJ./test -1) <= 1e-6;

check('logithypothesis', sum(sum(datatest) == size(test,1)) == size(datatest,2), true)