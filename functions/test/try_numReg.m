close all
clear all
clc

init

c = [1.5,1,3];

options = odeset('RelTol', 1e-6, 'MaxStep', 1e-2);
[t,y] = ode45(@(t,y) numRegdFoo(t,y,c), [0 10], [1;2;3], options);

plot(t, y)

N = 100;

T = 10*rand(N,1);
y0 = 1e5*rand(N,1)+1;

Y = numRegFoo(T, y0, c)./y0;

inputs = [T, y0];
targets = Y;

figure()

scatter3(T, y0, Y,'b')

data = splitDataRandom(inputs, targets, [70,30]);

hypothesis = @(inputs, theta) numRegFoo(inputs(:,1), inputs(:,2), theta)./inputs(:,2);

options2 = optimset('GradObj', 'off', 'Display', 'off', 'LargeScale', 'off');

tic;
[theta, J] = fminunc(@(theta) costfunction(data{1}.inputs, data{1}.targets, theta, hypothesis, 0), [1;1;1], options2);
t = toc;

hold on
scatter3(T, y0, numRegFoo(T,y0,theta)./y0,'r')
hold off

xlabel('Endzeit')
ylabel('Anfangswert')
zlabel('Y/Y_0')

[x,y] = meshgrid(linspace(0, 10, 100), 10.^linspace(0, 5, 100));

hold on
% mesh(x,y,reshape(numRegFoo(x(:), y(:), c)./y(:), 100, 100))
mesh(x,y,reshape(numRegFoo(x(:), y(:), theta)./y(:), 100, 100))
hold off

set(gca,'yscale','log')
set(gca,'zscale','log')

figure()
val.true = numRegFoo(data{2}.inputs(:,1), data{2}.inputs(:,2), c)./data{2}.inputs(:,2);
val.app = numRegFoo(data{2}.inputs(:,1), data{2}.inputs(:,2), theta)./data{2}.inputs(:,2);

tmp = [val.true;val.app];

scatter(val.true, val.app)
hold on
plot([min(tmp) max(tmp)], [min(tmp) max(tmp)])
hold off

grid on

disp(sprintf(['calculation time: \t', num2str(t,'%.3f'), ' s']))
disp(sprintf(['Goodness of fit: \t', num2str(calcR2(val.app, val.true),'%.3f')]))