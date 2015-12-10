close all
clear all
clc

init

data.inputs.test = [1;2;3];
data.inputs.sigma = 1;
data.inputs.mu = 1;

data.targets.test = [4;9;16];
data.targets.sigma = 1;
data.targets.mu = 0;

hypothesis= @(x, theta) (theta+x).^2;

R2 = getR2(hypothesis, 1, data)
