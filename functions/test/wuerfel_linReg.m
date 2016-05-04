close all
clear all
clc

init

wuerfel_data = load('data_wuerfel.txt');
in = wuerfel_data(:,1:4);

% input features
p = in(:,1);         % pressure / MPa
t_g = in(:,2);       % total pressure time / s
t_p = in(:,3);       % single pressure time / s
n = in(:,4);         % number of cycles / -

inputs = [p.*t_g];

targets = wuerfel_data(:,6);

fitdata = linReg(inputs, targets);
