%% check: Show check status
function [check_results] = check(checknames, expacted_values, check_values)
	
	if iscell(checknames)
		n = length(checknames);
		check_result = zeros(n,1);

		for i = 1:n
			check_results(i) = isequal(expacted_values{i}, check_values{i});
		end

	else
		check_results = isequal(expacted_values, check_values);
	end

	if nargout == 0
		if iscell(check_results)
			for i = 1:n
				disp_check(checknames{i}, check_results(i))
			end
		else
			disp_check(checknames, check_results)
		end

		clear check_results
	end

end

function disp_check(checkname, check_result)
	
	if check_result
		disp(sprintf (['check ', checkname, ':\t passed']))
	else
		disp(sprintf (['check ', checkname, ':\t failed']))
	end

end