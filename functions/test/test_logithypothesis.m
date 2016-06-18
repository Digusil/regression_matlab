clear all
close all
clc

init

if ~exist('numlinearize.m','file')
	addpath('K:\Projekte\PhD\MATLAB\usefull');
end

N = 1e3;

inputs = [ones(N, 1), linspace(-5, 5, N)'];

theta = [-10;-2];

test = numlinearize(@(theta) logithypothesis(inputs, theta), theta);
[h, dh] = logithypothesis(inputs, theta);

datatest = abs(dh./test -1) <= 1e-6;

check('logithypothesis', sum(sum(datatest) == N) == size(datatest,2), true)