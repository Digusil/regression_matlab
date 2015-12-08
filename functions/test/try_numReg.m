close all
clear all
clc

init

y0 = 10*(2*rand(1e2,1)-1);

c = [0.5,10];

options = odeset('RelTol', 1e-6, 'MaxStep', 1e-2);
[t,y] = ode45(@(t,y) numRegdFoo(t,y,c), [0 10], [-1;0;1], options);

plot(t, y)

N = 100;

T = 10*rand(N,1);
y0 = 10*(2*rand(N,1)-1);

Y = numRegFoo(T, y0, c);

inputs = [T, y0];
targets = Y;

figure()

scatter3(T, y0, Y)

data = splitDataRandom(inputs, targets, [70,30]);

hypothesis = @(inputs, theta) numRegFoo(inputs(:,1), inputs(:,2), theta);

[theta, J] = fminunc(@(theta) costfunction(data{1}.inputs, data{1}.targets, theta, hypothesis, 0), [0;0]);

hold on
scatter3(T, y0, numRegFoo(T,y0,theta))
hold off

xlabel('Endzeit')
ylabel('Anfangswert')
zlabel('Y')

[x,y] = meshgrid(linspace(0, 10, 100), linspace(-10, 10, 100));

hold on
mesh(x,y,reshape(numRegFoo(x(:), y(:), theta), 100, 100))
mesh(x,y,reshape(numRegFoo(x(:), y(:), c), 100, 100))
hold off

figure()
val.true = numRegFoo(data{2}.inputs(:,1), data{2}.inputs(:,2), c);
val.app = numRegFoo(data{2}.inputs(:,1), data{2}.inputs(:,2), theta);

tmp = [val.true;val.app];

scatter(val.true, val.app)
hold on
plot([min(tmp) max(tmp)], [min(tmp) max(tmp)])
hold off

grid on

disp(calcR2(val.app, val.true))