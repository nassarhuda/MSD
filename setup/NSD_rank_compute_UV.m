function [U,V, dt] = NSD_rank_compute_UV(A, B, alpha, iters, vecsA, vecsB, sigmas)
% Modified by Huda (Added multiple iterates of X)
% removed the construction of a matrix X
% NSD_rank_compute Computes the similarity of two undirected graphs using the
% decomposition approach.
% 
% Input arguments:
% - A, B: the adjacency matrices of the two graphs.
% - alpha: alpha parameter of the IsoRank algorithm.
% - iters: the number of iterations.
% - vecsA, vecsB: cell arrays containing the vectors which will participate 
%     in composing the preferences matrix H. 
%     Summing outer products vecsB{i} * vecsA{i}' is meant to be 
%     a decomposition of the preferences matrix H, when no sigmas vector is given
%     (typically from NMF or some specific user constructed decomposition).
%     Summing sigmas(i) * vecsB{i} * vecsA{i}'  is meant to be 
%     a decomposition of H when sigmas are given, typically in the SVD case.
%  - sigmas: a vector of sigma values (typically a number of the leading
%     singular values coming from SVD). Optional parameter.
%
% Output arguments:
% - X: the matrix with the similarity scores (similarity matrix).
%     Note that element X(i,j) is the similarity score of node i in B 
%     and node j in A; if B has m nodes and A has n nodes then X is an 
%     m x n matrix.
% - dt: the time in seconds for the operation.


% Giorgos Kollias and Shahin Mohammadi
% Department of Computer Science, Purdue University


s = size(vecsA, 2); %number of modes

ivecsA = {};
ivecsB = {};

m = size(B, 1);
n = size(A, 1);

t0 = clock;    
if  ~exist('sigmas', 'var') || isempty(sigmas)
    for ss=1:s
       ivecsA{ss} = vecsA{ss};
       ivecsB{ss} = vecsB{ss};
    end
else
    for ss=1:s
       ivecsA{ss} = sigmas(ss) * vecsA{ss};
       ivecsB{ss} = vecsB{ss};
    end
end  

k = iters + 1;

U = zeros(m,s*k);
V = zeros(n,s*k);
for ss=1:s
    vecsA = inpowers(A, iters, ivecsA{:, ss});
    vecsB = inpowers(B, iters, ivecsB{:, ss});
    for j = 1:numel(vecsA) %(there are k of them)
        V(:,(ss-1)*k + j) = vecsA{j};
        U(:,(ss-1)*k + j) = vecsB{j};
    end

    factor = 1.0 - alpha;
    for i = 1:k-1
        U(:,(ss-1)*k + i) = factor * U(:,(ss-1)*k + i);
        factor = factor * alpha;
    end
    factor = alpha ^ iters;
    U(:,(ss-1)*k + k) = factor * U(:,(ss-1)*k + k);
end

dt = etime(clock, t0);


end

