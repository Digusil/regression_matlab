close all
clear all
clc

init

[x, y] = meshgrid(linspace(-10,10,1e2), linspace(-10,10,1e2));

foo = @(x,y) (x+y).^2;

z = foo(x,y);

inputs = [x(:), y(:), x(:).^2, y(:).^2, x(:).*y(:)];

tic
fitdata = linReg(inputs, z(:));
t = toc;

mse = mean((fitdata.function(inputs) - z(:)).^2);

disp(['MSE: ',num2str(mse, '%.3e'),...
	  ' with ', num2str(t, '%.3e'),' s'])

check('linReg', mse < 1e-6, true)