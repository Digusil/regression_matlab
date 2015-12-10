close all
clear all
clc

init

[x, y] = meshgrid(linspace(-10,10,1e2), linspace(-10,10,1e2));

c = [1,2];

foo = @(x,y) c(1)*x+c(2)*y;

% hypothesis = @(inputs, theta) theta(1)*inputs(:,1) + theta(2)*inputs(:,2);

z = foo(x,y);

inputs = [x(:), y(:)];

options = optimset('Display','off', 'GradObj','on');

theta0 = [1;1];

tic
fitdata = regression(inputs, z(:), @testhypothesis, theta0, options);
t = toc;

mse = mean((fitdata.function(inputs) - z(:)).^2);

disp(['MSE: ',num2str(mse, '%.3e'),...
	  ' with ', num2str(t, '%.3e'),' s'])

check('linReg', mse < 1e-6, true)