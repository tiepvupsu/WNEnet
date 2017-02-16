function X_fista = WNEnet_FISTA2(Y, D, lambda2, Lambda)

	opts.pos = true; 
	opts.lambda = Lambda;
	opts.lambda2 = lambda2;
	opts.check_grad = 0;
	% X_fista = fista_enet(Y, W, [], opts);

	DtD = D'*D + lambda2*eye(size(D, 2));
    DtY = D'*Y;

    L = eigs(DtD, 1);
    Linv = 1/ L;
    Gamma = repmat(Lambda, 1, size(Y, 2))/L;
    max_iter = 500;
    tol = 1e-6;

    X_old = zeros(size(D, 2), size(Y, 2));
    Y_old = X_old; 
    t_old = 1;
    iter = 0;

    LinvDtD = Linv*DtD;
    LinvDtY = Linv*DtY;
    while iter < max_iter
    	iter = iter + 1;
        % U = Y_old - Linv*(DtD*Y_old - DtY);
    	U = Y_old - LinvDtD*Y_old + LinvDtY;
    	X_new = max(0, U - Gamma);
    	t_new = 0.5*(1 + sqrt(1 + 4*t_old^2));
    	Y_new = X_new + (t_old - 1)/t_new * (X_new - X_old);
    	if norm1(X_new - X_old)/numel(X_new) < tol 
    		break;
    	end 
    	X_old = X_new;
    	t_old = t_new;
    	Y_old = Y_new;
    end 
    iter
    X_fista = X_new;



end 