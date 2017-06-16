function result = test_regLinearize

	init

	hypothesis = @(inputs, theta) theta(1) + sin(theta(2)*inputs);
	dhypo = @(inputs, theta) [ones(size(inputs)), inputs.*cos(theta(2)*inputs)];

	inputs = linspace(0,5*2*pi, 1e3)';

	[reglin, y0] = regLinearize(inputs, [1;1], hypothesis);

%	plot(inputs, reglin(:,2))

	if nargout > 0
		result = check('regLinearize', ~any(any(~(abs(dhypo(inputs, [1;1]) - reglin) < 1e-6))), true);
	else
		check('regLinearize', ~any(any(~(abs(dhypo(inputs, [1;1]) - reglin) < 1e-6))), true)
	end

end