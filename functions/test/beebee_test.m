clear all
close all
clc

init

x=[1:20]';
y=rand(1,20)';

data=prepareLinReg(x,y,'scaling',false);

fitdata=linReg(data);

figure()
scatter(x,y)
hold on
plot([0 20]',fitdata.function([0 20]'))