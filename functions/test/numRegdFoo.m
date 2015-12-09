%% numRegFoo
function [dy] = numRegdFoo(t,y,c)
	dy = -c(1)*(1-(c(2)./y).^c(3)).*y;
end
