function [ma,mb,vals] = matching_max_overlappededges(U,V,MM1,NN1,nnodes1,nnodes2,resolve_matching)
% MATCHING_MAX_OVERLAPPEDEDGES takes in takes in two matrices U and V, 
% generates a matching based on the max number of overlapped edges each
% rank1 matching achieves
% Since this matching is a result from a multimodal
% matching, we then resolve conflict by taking the top weighted edges or
%solving bipartite matching on the new network 

[~,~,~,U_order,V_order] = approx1overk_baseline(U,V,1);
till = min(size(U_order,1),size(V_order,1));
VL = zeros(size(U_order,1),1);

for i = 1:size(U_order,2)
    match_id = i;
    F1 = MM1(U_order(1:till,match_id),U_order(1:till,match_id));
    F2 = NN1(V_order(1:till,match_id),V_order(1:till,match_id));
    VL(i) = nnz(F1.*F2);
end

[~,match_id] = max(VL);
ma = U_order(:,match_id);
mb = V_order(:,match_id);

%%% drop cross modal matches %%%
modes1 = ceil(ma/nnodes1);
modes2 = ceil(mb/nnodes2);
ids_to_drop = find(modes1-modes2);
ma(ids_to_drop) = [];
mb(ids_to_drop) = [];
%%% drop cross modal matches %%%

maproj = mod(ma,nnodes1);
maproj(maproj==0) = nnodes1;

mbproj = mod(mb,nnodes2);
mbproj(mbproj==0) = nnodes2;

U1 = U(ma,:);
V1 = V(mb,:);

allweights = sum(U1.*V1,2);

switch resolve_matching
    case{'bp'}
        [vals,ma,mb] = resolve_matching_bipartite(maproj,mbproj,allweights);
    case{'maxfirst'}
        [vals,ma,mb] = resolve_matching_maxfirst(allweights,maproj,mbproj,nnodes1,nnodes2);
    otherwise
        [vals,ma,mb] = resolve_matching_bipartite(maproj,mbproj,allweights);
end

end

