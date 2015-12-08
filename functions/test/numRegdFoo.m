%% numRegFoo
function [dy] = numRegdFoo(t,y,c)
	dy = -(c(1)*y.*t)+c(2);
end
