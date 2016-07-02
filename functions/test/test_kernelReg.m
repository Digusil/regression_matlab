close all
clear all
clc

init

[x, y] = meshgrid(linspace(-10,10,10), linspace(-10,10,10));

c = [1,2];

foo = @(x,y) c(1)*x.^2-c(2)*y.^2;

% hypothesis = @(inputs, theta) theta(1)*inputs(:,1) + theta(2)*inputs(:,2);

z = foo(x,y);

inputs = [x(:), y(:)];

options = optimset('Display','off', 'GradObj','on');

data = prepareRegression(inputs, z(:));

tic
fitdata = kernelReg(data, options, 'mode', 'single', 'kernelscaling', 'scaled');
t = toc;

rmse = sqrt(mean((fitdata.function(inputs) - z(:)).^2));

disp(['RMSE: ',num2str(rmse, '%.3e'),...
	  ' with ', num2str(t, '%.3e'),' s'])

check('calcReg', rmse < 1e-6, true)

test = fitdata.function([x(:), y(:)]);

figure()
scatter3(x(:),y(:),z(:), 'fill')
hold on
surf(x,y,reshape(test, size(x)))
hold off

figure()

scatter(z(:), test)

linlim = [min([z(:); test(:)]), max([z(:); test(:)])];
hold on
plot(linlim, linlim, 'k')
plot(linlim, linlim-fitdata.rms*2, 'r')
plot(linlim, linlim+fitdata.rms*2, 'r')
hold off

grid on

axis square