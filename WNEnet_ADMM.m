function X_admm = WNEnet_ADMM(Y, W, lambda2, Lambda)
	% ADMM procedure
	% Let's consider N = 1 first (X is a matrix, then generalize later)
	% x, z = argmin_{x, z} 0.5 ||y - Wx||_F^2 + .5*lambda2 ||x||_2^2 + 
	%		  + ||diag(Lambda)*z||_1 + rho/2 ||x - z + u||_2^2 
	% 		s.t. x = z , z >= 0 
	% ADMM solution 
	% Solve x: x = argmin_x 0.5 ||y - Wx||_2^2 + .5*lambda2||x||_2^2 + rho/2 ||x - z + u||_2^2 
	%				gradient: W^T(Wx - y) + lambda2x + rho(x - z + u) = 0 
	%				=> x = (W^TW + (lambda2 + rho)I)^-1 (W^Ty + rho(z - u))
	%					 = B + rho*C*(z - u) 
	%			    where C = (W^TW + (lambda2 + rho)I)^-1, B = C*W^Ty 
	% Solve z: z = argmin_z 0.5||x - z + u||_2^2 + 1/rho||diag(Lambda)*z||_1 
	%			v = max(0, z - u - Lambda/rho) + min (0, z-u + Lambda/rho) 
	%					(shrinkage without NN constraint)
	% 			=> z = max(v, 0)
	% Update u: u = u + x - z 
	%%%%%%%%%%%% IN case X is a matrix 
	% Update X: X = B + rho*C(U - Z) 
	% Update Z: Z = max(V, 0), 
	%		V = max(0, X + U - repmat(Lambda, 1, N)) + min(0, X + U + repmat(Lambda, 1, N))
	%			where N = size(Y, 2)
	% U = U + X - Z 
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%% Tiep Vu, Thu 16 Feb 2017 11:25:51 AM EST
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%
	rho0 = 0.1; 
	tol = 1e-4;
	rho = rho0*max(sum(W.*W, 1)); % maximum atom norm-2 
%     rho = 1;
	max_iter = 1000; 
	U = zeros(size(W, 2), size(Y, 2));
	Z = U; 
	iter = 0; 
	Gamma = repmat(Lambda, 1, size(Y, 2))/rho;
	C = inv(W'*W + (lambda2 + rho)*eye(size(W, 2)));
	B = C*(W'*Y);

	while iter < max_iter
		X = B + rho*C*(Z - U);
		T = X + U;
		% V = max(0, T - Gamma) + min(0, T + Gamma);
		% Z = max(V, 0);
		Z = max(0, T - Gamma);
		U = U + X - Z; 
		if norm1(X - Z)/numel(X) < tol 
			break 
		end 
		iter = iter + 1;
    end 
%     iter
	X_admm = Z;
end 

