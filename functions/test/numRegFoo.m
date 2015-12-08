%% numRegFoo:
function [Y] = numRegFoo(T, y0, c)
	options = odeset('RelTol', 1e-6);

%	Y = zeros(size(T));
%	for idn = 1:size(T,1)
%		[t,y] = ode45(@(t,y) numRegdFoo(t,y,c), [0 T(idn)], y0(idn), options);
%		Y(idn) = y(end);
%	end

%	[tspan, IDs] = sort(T');
%	[~, idS] = sort(IDs);

	[tspan, IDt, idT] = unique(T');
	[ydata, IDy, idY] = unique(y0);

	if sum(tspan == 0) > 0
		tspan = tspan(2:end);
	end
	
	[t,y] = ode45(@(t,y) numRegdFoo(t,y,c), [0 tspan], ydata, options);

	idx = sub2ind(size(y), idT, idY);
%	Y = diag(y);
	Y = y(idx);
end