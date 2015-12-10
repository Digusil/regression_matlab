function [R2] = getR2(hypothesis, theta, data)

R2 = calcR2(hypothesis(data.inputs.test, theta), data.targets.test);

end
