function result = test_getR2

	init

	data = prepareRegression([1;2;3], [4;9;16], 'datasplit', [0,0,100]);

	hypothesis= @(x, theta) (theta+x).^2;

	R2 = getR2(1, hypothesis, data);

	R2test = calcR2(hypothesis(data.inputs.test, 1), data.targets.test);

	if nargout > 0
		result = check('getR2', abs(R2-R2test) < 1e-6, true);
	else
		check('getR2', abs(R2-R2test) < 1e-6, true)
	end

end
