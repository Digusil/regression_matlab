%% train: train regression
function [theta, J, lambda, flag] = train(costfun, lambda_list, theta0, options)

	options_tmp = optimset('Display','off');
	options = optimset(options_tmp, options);

	lambda = inf;
	J = inf;

	count_flag = 0;

	for idl = 1:length(lambda_list)

		if count_flag >= 3
			break
		end
	
		[tmp_theta, tmp_J, flag] = fminunc(@(theta) costfun(theta, lambda_list(idl)),theta0, options);

		% optimisation for cerf hypothesis (log-function)
		%[theta, J, flag] = fmincon(@(theta) costfunction(inputs, targets, theta, hypothesis, lambda),theta0, [],[],[],[],[0;-Inf;-Inf],[1;Inf;Inf], [], options);

		if flag == 0
			count_flag = count_flag +1;
		elseif flag < 0
			count_flag = 0;
		end

		if tmp_J < J
			theta = tmp_theta;
			lambda = lambda_list(idl);
			J = tmp_J;
		end
	end

	if flag == 0 && strcmp(options.Display, 'off')
		warning('Optimisation:Iterations', 'Optimisation exeeds maximum number of iterations!')
	end

end
