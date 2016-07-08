function result = test_splitDataRandom

	init

	N = 100;

	inputs = randn(N, 5);
	targets = randn(N, 1);
	
	split = [75, 10, 5];

	data = splitDataRandom(inputs, targets, 'datasplit', split);

	if nargout > 0
		tmp(1) = check('splitDataRandom:distribution:train', size(data{1}.inputs, 1), floor(split(1)/sum(split)*N));
		tmp(2) = check('splitDataRandom:distribution:validate', size(data{2}.inputs, 1), floor(split(2)/sum(split)*N));
		tmp(3) = check('splitDataRandom:distribution:test', size(data{3}.inputs, 1), N - floor(split(1)/sum(split)*N) -floor(split(2)/sum(split)*N));
	else
		check('splitDataRandom:distribution:train', size(data{1}.inputs, 1), floor(split(1)/sum(split)*N))
		check('splitDataRandom:distribution:validate', size(data{2}.inputs, 1), floor(split(2)/sum(split)*N))
		check('splitDataRandom:distribution:test', size(data{3}.inputs, 1), N - floor(split(1)/sum(split)*N) -floor(split(2)/sum(split)*N))
	end

	id_data{1} = 1:split(1)/sum(split)*N;
	id_data{2} = id_data{1}(end)+ [1:split(2)/sum(split)*N];
	id_data{3} = id_data{1}(end):N;

	data = splitDataRandom(inputs, targets, id_data);

	if nargout > 0
		tmp(4) = check('splitDataRandom:iddata:train', ~any(any(~(data{1}.inputs == inputs(id_data{1},:)))), true);
		tmp(5) = check('splitDataRandom:iddata:validate', ~any(any(~(data{2}.inputs == inputs(id_data{2},:)))), true);
		tmp(6) = check('splitDataRandom:iddata:test', ~any(any(~(data{3}.inputs == inputs(id_data{3},:)))), true);
		
		result = ~any(~tmp);
	else
		check('splitDataRandom:iddata:train', ~any(any(~(data{1}.inputs == inputs(id_data{1},:)))), true)
		check('splitDataRandom:iddata:validate', ~any(any(~(data{2}.inputs == inputs(id_data{2},:)))), true)
		check('splitDataRandom:iddata:test', ~any(any(~(data{3}.inputs == inputs(id_data{3},:)))), true)
	end

end