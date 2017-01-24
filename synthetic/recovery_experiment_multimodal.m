function [frac,scorelist,fracs] = recovery_experiment_multimodal(n,d,m,t,vp,ep)
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
scores = zeros(7,1);
ma = cell(10,1);
mb = cell(10,1);
input_modes = 1:m;
for ti=1:t
    [M,N,As,Bs] = synthetic_networks(G,m,ep,vp);
    
    maxalign = score_pairwise_match(As,Bs,1:n,n:-1:1);
    % if you want to run the line below independently choose method to be
    % 'bp' or 'var3'
%     [ma{1},mb{1},scores(1),~,~,~] = align_multimodal_network(M,N,'1overk_union',input_modes,0.9,10,'maxfirst');
%     [ma{2},mb{2},scores(2),~,~,~] = align_multimodal_network(M,N,'1overk_union',input_modes,0.9,10,'bp');
%     [ma{3},mb{3},scores(3),~,~,~] = align_multimodal_network(M,N,'1overk_weight',input_modes,0.9,10,'maxfirst');
%     [ma{4},mb{4},scores(4),~,~,~] = align_multimodal_network(M,N,'1overk_weight',input_modes,0.9,10,'bp');
%     [ma{5},mb{5},scores(5),~,~,~] = align_multimodal_network(M,N,'1overk_nnz',input_modes,0.9,10,'maxfirst');
%     [ma{6},mb{6},scores(6),~,~,~] = align_multimodal_network(M,N,'1overk_nnz',input_modes,0.9,10,'bp');
%     [ma{7},mb{7},scores(7),~,~,~] = align_multimodal_network(M,N,'bp',input_modes,0.9,10);



    [ma{1},mb{1},scores(1),~,] = align_multimodal_network(M,N,'bp',input_modes,0.9,10,'',As,Bs,n,n);
    [ma{2},mb{2},scores(2),~,] = align_multimodal_network(M,N,'1overk_union',input_modes,0.9,10,'maxfirst',As,Bs,n,n);
    [ma{3},mb{3},scores(3),~,] = align_multimodal_network(M,N,'1overk_union',input_modes,0.9,10,'bp',As,Bs,n,n);
    [ma{4},mb{4},scores(4),~,] = align_multimodal_network(M,N,'1overk_weight',input_modes,0.9,10,'maxfirst',As,Bs,n,n);
    [ma{5},mb{5},scores(5),~,] = align_multimodal_network(M,N,'1overk_weight',input_modes,0.9,10,'bp',As,Bs,n,n);
    [ma{6},mb{6},scores(6),~,] = align_multimodal_network(M,N,'1overk_nnz',input_modes,0.9,10,'maxfirst',As,Bs,n,n);
    [ma{7},mb{7},scores(7),~,] = align_multimodal_network(M,N,'1overk_nnz',input_modes,0.9,10,'bp',As,Bs,n,n);
    
    [~,mid] = max(scores);
    mau = ma{mid};
    mbu = mb{mid};
    
%     scores
%     maxalign

% old method:
%     [mau,mbu,scores] = align_multimodal(M,N,As,Bs,n,m);
% old method ends here.

    scorelist{ti} = scores;
    fracs(ti) = score_pairwise_match(As,Bs,mau,mbu)/maxalign;
    %frac = frac + score_pairwise_match(As,Bs,ma,mb)/maxalign;
    %frac = frac + sum(ma == (n-mb+1))/size(G,1);
end
frac = mean(fracs);