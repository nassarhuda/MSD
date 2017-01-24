function [frac,scorelist,fracs] = recovery_experiment_pairwise(method,n,d,m,t,vp,ep)
% recovery_experiment(n,d,m,t,vp,ep)
%  n = size of graph
%  d = average degree
%  t = number of trials
%  m = number of modes
%  vp = vertex prob of deletion
%  ep = edge probaiblity of deletion

G = spones(triu(sprand(n/3,n/3,d/(n/3)),1));
G = G + G';
%G = [G speye(size(G)); speye(size(G)) G];
G = kron([0 1 0; 1 0 1; 0 1 0],G);

scorelist = cell(t,1);
fracs = zeros(t,1);
parfor ti=1:t
    [~,~,As,Bs] = synthetic_networks(G,m,ep,vp);
    maxalign = score_pairwise_match(As,Bs,1:n,n:-1:1);
    [ma,mb,~,scores] = align_pairwise(As,Bs,method);
    
    scorelist{ti} = scores; 
    fracs(ti) = score_pairwise_match(As,Bs,ma,mb)/maxalign;
    %frac = frac + score_pairwise_match(As,Bs,ma,mb)/maxalign;
    %frac = frac + sum(ma == (n-mb+1))/size(G,1);
end
frac = mean(fracs);