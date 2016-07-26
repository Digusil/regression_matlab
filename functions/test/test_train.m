function result = test_train

	init

	m = 10;		% Samples

	inputs = [linspace(1,10,m)', linspace(-3,6,m)'];
	targets = linspace(2,11,m)';

	lambda = 1;

	options = optimset('GradObj','on');

	costfun = @(theta, lambda) costfunction(inputs, targets, theta, @testhypothesis, lambda);
	[theta, J, flag] = train(costfun, lambda, [1;1], options);

	% J = costfunction(inputs, targets, theta, @testhypothesis, lambda);

	test = true;

	for id = 1:1e5
		tmpJ = costfunction(inputs, targets, theta + 10*(2*rand(2,1)-1), @testhypothesis, lambda);
		
		if tmpJ < J
			test = false;
			break
		end
	end

	if nargout > 0
		result = check('train', test, true);
	else
		check('train', test, true)
	end

end