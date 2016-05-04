%hypothesis: calculates target-values for applied theta
function [h, dh] = wuerfel_hypothesis(inputs, theta)

    % input features
    p = inputs(:,1);         % pressure / MPa
    t_g = inputs(:,2);       % total pressure time / s
    t_p = inputs(:,3);       % single pressure time / s
    n = inputs(:,4);         % number of cycles / -

    % fitting parameters
    k1 = theta(1);
    k2 = theta(2);
    %k3 = theta(3);


    h = k1*exp(-k2*n);               % applied hypothesis

    %h = log(-h_x);           % logarithmic hypothesis

    if nargout > 1

          dh_dtheta1 = exp(-k2*n);      % derivation of hypothesis with respect to theta1
          dh_dtheta2 = -k1*k2*exp(-k2*n);
          %dh_dtheta3 =

          dh = [dh_dtheta1, dh_dtheta2];%, dh_dtheta3];  % Jacobi matrix

    end

end
