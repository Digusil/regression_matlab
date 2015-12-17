%hypothesis: calculates target-values for applied theta
function [h, dh] = cerf_hypothesis(inputs, theta)

% input features
t = inputs;         % total pressure time / s


% fitting parameters
f = theta(1);
k1 = theta(2);
k2 = theta(3);

h = f*exp(-k1*t)+(1-f)*exp(-k2*t);            % Cerf model

dh = -k1*f*exp(-k1*t)-(1-f)*k2*exp(-k2*t);  % derivation of Cerf model

end
