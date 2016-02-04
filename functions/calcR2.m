function rSquare = calcR2(y_appr, y_true)
	y_mean = mean(y_true,1);
	
	tmp1 = y_true - y_appr;
	tmp2 = y_true - ones(size(y_true,1),1)*y_mean;
	
	rSquare = 1- (diag(tmp1'*tmp1))./diag((tmp2'*tmp2));
end
