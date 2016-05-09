close all
clear all
clc

init

[x, y] = meshgrid(linspace(-10,10,10), linspace(-10,10,10));

c = [1,2];

foo = @(x,y) c(1)*x+c(2)*y;

% hypothesis = @(inputs, theta) theta(1)*inputs(:,1) + theta(2)*inputs(:,2);

z = foo(x,y);

inputs = [x(:), y(:)];

options = optimset('Display','off', 'GradObj','on');

theta0 = [1;1];

data = prepareRegression(inputs, z(:));

tic
fitdata = calcReg(data, @testhypothesis, theta0, options);
t = toc;

mse = mean((fitdata.function(inputs) - z(:)).^2);

disp(['MSE: ',num2str(mse, '%.3e'),...
	  ' with ', num2str(t, '%.3e'),' s'])

check('calcReg', mse < 1e-6, true)
