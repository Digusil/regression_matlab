close all
clear all

init

[x, y] = meshgrid(linspace(-10,10,1e2), linspace(-10,10,1e2));

foo = @(x,y) (x+y).^2;

z = foo(x,y);

inputs = [x(:), y(:), x(:).^2, y(:).^2, x(:).*y(:)];

data = prepareLinReg(inputs, z(:));

tic
fitdata = linReg(data);
t = toc;

rmse = sqrt(mean((fitdata.function(inputs) - z(:)).^2));

% disp(['MSE: ',num2str(mse, '%.3e'),...
% 	  ' with ', num2str(t, '%.3e'),' s'])

check('linReg', rmse < 1e-6, true)