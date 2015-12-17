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
% 	dh ==> element(mxn)
% 	| dh_1/dtheta_1 dh_1/dtheta_2 dh_1/dtheta_2 |
% 	| dh_2/dtheta_1 dh_2/dtheta_2 dh_2/dtheta_2 |
% 	| dh_.../dtheta_1 dh_.../dtheta_2 dh_.../dtheta_2 |
% 	| dh_m/dtheta_1 dh_m/dtheta_2 dh_m/dtheta_2 |

dh_dtheta1 = exp(-k1*t)-exp(-k2*t);
dh_dtheta2 = -f*t.*exp(-k1*t);
dh_dtheta3 = t.*exp(-k2*t)*(f-1);

dh = [dh_dtheta1, dh_dtheta2, dh_dtheta3];  % Jacobi matrix of Cerf model

end

end
