function result = test_trainLinear

	init

	m = 10;		% Samples

	inputs = [linspace(1,10,m)', linspace(-3,6,m)'];
	targets = linspace(2,11,m)';

	lambda = 1;

	options = optimset('GradObj','on');

	tic
	[theta1, J1] = trainLinear(inputs, targets, lambda);
	t1 = toc;

	tic

	costfun = @(theta, lambda) costfunction(inputs, targets, theta, @testhypothesis, lambda);
	[theta2, J2, flag] = train(costfun, lambda, [1;1], options);
	t2 = toc;

%	disp([t1, t2])

	if nargout > 0
		result = check('trainLinear', J1 < J2, true);
	else
		check('trainLinear', J1 < J2, true)
	end

end
