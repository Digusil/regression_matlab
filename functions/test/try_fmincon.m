close all
clear all
clc

x0 = -5;
y0 = -5;

foo =@(x,y) (x-x0).^2+(y-y0).^2;

[x,y] = meshgrid(linspace(-5,5,10), linspace(-5,5,10));

% surf(x,y, foo(x,y))

options = optimset('Display','final');

X = fmincon(@(x) foo(x(1),x(2)), zeros(2,1), [],[],[],[],[0,-inf], [], [], options)