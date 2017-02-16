%% Solve the problem (4) in:
% https://arxiv.org/pdf/1701.08349.pdf
% by two methods: ADMM and FISTA 
% x = \arg\min_x 0.5 ||y - Wx||_F^2 + 0.5*lambda2*||x||_2^2 + ||diag(lambda)*x||_1
% s.t. x >= 0 
% this is actually a Weighted Nonnegative Elastic Net problem (WNEnet)


function demo 
%     profile off 
%     profile on 
    addpath('utils');
    addpath('proj');
	d = 100; 
	N = 1000;
	k = 1000;

	W = normc(rand(d, k));
	D = W;
	Y = normc(rand(d, N));

	Lambda = rand(k, 1)/10;
	lambda2 = 0.1;

	function cost =  calc_cost(X)
		cost = 0.5*normF2(Y - W*X) + .5*lambda2*normF2(X) + ...
			norm1(repmat(Lambda, 1, N).*X);
	end 
	tic;
	X_admm = WNEnet_ADMM(Y, W, lambda2, Lambda);
	t1 = toc; 

% 	tic; 
% 	X_fista = WNEnet_FISTA(Y, W, lambda2, Lambda);
% 	t2 = toc; 
    
    tic 
    X_fista2 = WNEnet_FISTA2(Y, W, lambda2, Lambda);
    t3 = toc; 
    
	fprintf('ADMM   | time: %f | cost: %f\n', t1, calc_cost(X_admm));
% 	fprintf('FISTA  | time: %f | cost: %f\n', t2, calc_cost(X_fista));
    fprintf('FISTA2 | time: %f | cost: %f\n', t3, calc_cost(X_fista2));
%     profile viewer
end 