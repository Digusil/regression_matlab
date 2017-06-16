close all
clear all
clc

init	% load functions

x = linspace(-5, 5, 1e2)';	% create input data

y = zeros(size(x));			% create target data
y(abs(x+2.0*(2*rand(size(x))-1))<=1) = 1;

inputs = [x, x.^2, x.^3];	% transform the
							% coordinate data
							% to a suitable matrix
							% format

options = optimset('Display','off', 'GradObj','on');

data = prepareLinReg(inputs, y, 'scaling', false);

tic						% start time measurement
fitdata = logitReg(data, [0;0;0;0], options);		% fit data
t = toc;				% stop time measurement

%% plot result
figure()

plot(x, fitdata.eval(inputs))
hold on
scatter(x,y)
hold off

grid on

xlabel('x')
ylabel('y')

legend('logistic regression', 'data')
