%hypothesis: calculates target-values for applied theta
function [h, dh] = cerf_hypothesis(inputs, theta)

% input features
t = inputs;         % total pressure time / s


% fitting parameters
f = theta(1);
k1 = theta(2);
k2 = theta(3);

h = f*exp(-k1*t)+(1-f)*exp(-k2*t);            % Cerf model

if nargout > 1
	dh = -k1*f*exp(-k1*t)-(1-f)*k2*exp(-k2*t);  % derivation of Cerf model
	
% 	dh ==> element(mxn)
% 	| dh_1/dtheta_1 dh_1/dtheta_2 dh_1/dtheta_2 |
% 	| dh_2/dtheta_1 dh_2/dtheta_2 dh_2/dtheta_2 |
% 	| dh_.../dtheta_1 dh_.../dtheta_2 dh_.../dtheta_2 |
% 	| dh_m/dtheta_1 dh_m/dtheta_2 dh_m/dtheta_2 |
end

end
