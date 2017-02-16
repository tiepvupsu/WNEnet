function X_fista = WNEnet_FISTA(Y, W, lambda2, Lambda)

	opts.pos = true; 
	opts.lambda = Lambda;
	opts.lambda2 = lambda2;
	opts.check_grad = 0;
	X_fista = fista_enet(Y, W, [], opts);
end 