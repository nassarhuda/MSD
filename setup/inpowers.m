function [vecs, dt] = inpowers(A, iters, v)
% inpowers Compute powers of a matrix multiplied by a vector.  
%
% Input arguments: 
% - A: the matrix.
% - iters: the number of iterations.
% - v: the vector.
% Output arguments:
% - vecs: cell array containing iter + 1 vectors, namely
%     vecs{i} = A^(i-1) * v starting at i=1. 
% - dt: the time in seconds for the operation.
%
% If v is not given then a vector with identical elements summing up to 1
% is used for v.


% Giorgos Kollias and Shahin Mohammadi
% Department of Computer Science, Purdue University


% A = max(A, A');
Q = normout(A);
n = size(Q,1);

if ~exist('v','var') || isempty(v)
    L = ones(n, 1)./n;
    v = L(:);
    v = v ./ csum(v);
end
 
t0 = clock;
x = zeros(n, 1); 
x = x + v;

vecs{1} = x;

iter = 0;
while iter < iters     
    x = Q' * x;
    x = x/norm(x,1);
    vecs{iter + 2} = x;
    iter = iter + 1;
end

dt = etime(clock, t0); 

end

