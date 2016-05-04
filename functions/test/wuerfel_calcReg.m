close all
clear all
clc

init %load functions

wuerfel_data = load('data_wuerfel.txt');
inputs = wuerfel_data(:,1:4);
targets = wuerfel_data(:,6);

options = optimset('Display', 'off', 'GradObj', 'on');

theta0 = [1.3; 2.5];%; ]; % initial values for theta

fitdata = calcReg(inputs,targets,@wuerfel_hypothesis, theta0, options);
