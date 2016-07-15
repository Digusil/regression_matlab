clear all
close all
clc

x=[0.12 0.27 0.41 0.6]';
y=[5.64 5.2 4.64 4.14]';

data=prepareLinReg(x,y,'scaling',false);

fitdata=linReg(data);

figure()
scatter(x,y)
hold on
plot([0 3]',fitdata.function([0 3]'))