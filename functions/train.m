%% train: train regression
function [tetha] = train(inputs, targets, hypothesis, lambda, options)

	theta = fminunc(@(theta) costfunction(inputs, targets, theta, hypothises, lambda), options);

end