%hypothesis: calculates target-values for applied theta
function [h, dh] = kamau_hypothesis(inputs, theta)

    % input features
    t = inputs;         % total pressure time / s


    % fitting parameters
    f = theta(1);
    b1 = theta(2);
    b2 = theta(3);

    % biphasic Kamau hypothesis
    h_kamau = 2*f./(1+exp(b1*t))+2*(1-f)./(1+exp(b2*t));

    h = log(h_kamau);

    % partial derivations
      if nargout > 1

        dh_dtheta1 = (2./(exp(b1*t)+1)-2./(exp(b2*t)+1))./h_kamau;
        dh_dtheta2 = -((2*f*t.*exp(b1*t))./(exp(b1*t)+1).^2)./h_kamau;    
        dh_dtheta3 = ((t.*exp(b2*t)*(2*f-2))./(exp(b2*t)+1).^2)./h_kamau;

        dh = [dh_dtheta1, dh_dtheta2, dh_dtheta3];  % Jacobi matrix

      end

  end
