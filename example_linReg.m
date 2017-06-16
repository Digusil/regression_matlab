close all
clear all
clc

init	% load functions

[x, y] = meshgrid(linspace(-10,10,1e2), linspace(-10,10,1e2));	% create input data

foo = @(x,y) (x+y).^2;	% function that we wont to find

z = foo(x,y);			% create target data

inputs = [x(:), y(:), x(:).^2, y(:).^2, x(:).*y(:)];	% transform the coordinate data to a 
														% suitable matrix format

data = prepareLinReg(inputs, z(:));

tic						% start time measurement
fitdata = linReg(data);		% fit data
t = toc;				% stop time measurement

mse = mean((fitdata.eval(inputs) - z(:)).^2);			% calculate the mean square error

disp(['MSE: ',num2str(mse, '%.3e'),...					% display the MSE and the calculation time
	  ' with ', num2str(t, '%.3e'),' s'])
  
figure()
plot3(x,y,z)
hold on 
plot(fitdata.function(inputs))
