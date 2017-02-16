function test_enet2()
%     profile off
%     profile on 
	clc
	d      = 300; 	% data dimension
	N      = 1000; 	% number of samples 
	k      = 500; 	% dictionary size 
	lambda = rand(k, 1);
	lambda2 = 0.001;
	Y      = normc(rand(d, N));
	D      = normc(rand(d, k));
	%% cost function 
    function c = calc_F(X)
        c = 0.5*normF2(Y - D*X) + lambda2/2*normF2(X) + ...
            norm1(repmat(lambda, 1, N).*X);
    end
    %% fista solution 
	opts.pos = true;
	opts.lambda = lambda;
	opts.lambda2 = lambda2;
    opts.check_grad = 0;
    tic 
	X_fista = fista_enet(Y, D, [], opts);
    toc 
%     profile viewer
    
	%% spams solution 
	param.lambda     = lambda;
	param.lambda2    = lambda2;
	param.numThreads = 1;
	param.mode       = 2;
	param.pos        = opts.pos;
	X_spams      = mexLasso(Y, D, param); 
	%% compare costs 
    tic 
	cost_spams = calc_F(X_spams);
    toc 
    tic 
	cost_fista = calc_F(X_fista);
    toc 
	fprintf('cost_fista = %.5s\n', cost_fista);
%     X_fista
	fprintf('cost_spams = %.5s\n', cost_spams);    
end