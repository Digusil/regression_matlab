close all
clear all
clc

init	% load functions

[x, y] = meshgrid(linspace(-10,10,1e2), linspace(-10,10,1e2));	% create input data

foo = @(x,y) (x+y).^2;	% function that we wont to find

z = foo(x,y);			% create target data

inputs = [ones(length(x(:)),1),x(:), y(:), x(:).^2, y(:).^2, x(:).*y(:)];	% transform the
																			% coordinate data
																			% to a suitable matrix
																			% format

options = optimset('Display','off', 'GradObj','on');

theta0 = zeros(size(inputs,2),1);

tic						% start time measurement
fitdata = calcReg(inputs, z(:), @example_hypothesis, theta0, options);		% fit data
t = toc;				% stop time measurement

mse = mean((fitdata.function(inputs) - z(:)).^2);		% calculate the mean square error

disp(['MSE: ',num2str(mse, '%.3e'),...					% display the MSE and the calculation time
	  ' with ', num2str(t, '%.3e'),' s'])
