function result = test_logitReg
	init

	x = linspace(-5, 5, 1e2)';
	y = zeros(size(x));

	y(abs(x)<=1) = 1;

	inputs = [x, x.^2, x.^3]; %, x.^2];

	data = prepareLinReg(inputs, y, 'scaling', false);

	options = optimset('Display','off', 'GradObj','on');
	fitdata = logitReg(data, [0;0;0;0], options);

	if nargout > 0
		result = check('logitReg', fitdata.R2 > 0.6, true);
	else
		check('logitReg', fitdata.R2 > 0.6, true)
	end

	% plot(x, fitdata.function(inputs))
	% hold on
	% scatter(x,y)
	% hold off
	% 
	% grid on

end