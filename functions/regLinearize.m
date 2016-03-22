function [dx, y0] = regLinearize( inputs, theta, hypothesis)

	deltax = ones(size(inputs,1),1)*1e-6*theta';
	for idt = 1:length(theta)
		c1 = eye(length(theta));
		c1(idt, idt) = 1+0.5e-6;
		c2 = eye(length(theta));
		c2(idt, idt) = 1-0.5e-6;

		deltay(:,idt) = hypothesis(inputs, c1*theta)-hypothesis(inputs, c2*theta);
	end

	dx = deltay./deltax;

	if nargout > 1
		y0 = hypothesis(inputs, theta);
	end

end