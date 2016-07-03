close all
clear all
clc

init	% load functions

[x, y] = meshgrid(linspace(-10,10,100), linspace(-10,10,100));	% create input data

foo = @(x,y) (x+y).^2;	% function that we wont to find

z = foo(x,y);			% create target data

inputs = [x(:), y(:)];	% transform the
						% coordinate data
						% to a suitable matrix
						% format

options = optimset('Display','off', 'GradObj','on');

data = prepareRegression(inputs, z(:));

tic						% start time measurement
fitdata = kernelReg(data, options);		% fit data
t = toc;				% stop time measurement

mse = mean((fitdata.function(inputs) - z(:)).^2);		% calculate the mean square error

disp(['MSE: ',num2str(mse, '%.3e'),...					% display the MSE and the calculation time
	  ' with ', num2str(t, '%.3e'),' s'])
