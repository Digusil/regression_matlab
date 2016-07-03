close all
clear all

init

inputs = [ones(1,25)', linspace(-3, 5, 25)'];
targets = inputs*[3;2]+(2*rand(25,1)-1);

SE = standardError(inputs, targets, [3;2], @testhypothesis);

[reglin, y0] = regLinearize(inputs, [3;2], @testhypothesis);

ASE = standardError(inputs, targets, [3;2], @testhypothesis, reglin);

check('standardError', ~any(~(abs(SE-ASE)<1e-6)), true )