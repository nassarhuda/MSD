function [ma,mb,vals] = matching_maxweight_1overk(U,V,nnodes1,nnodes2,resolve_matching)
%MATCHING_MAXWEIGHT_1OVERK takes in two matrices U and V, generates a
%matching based on the max weighted matching from the outer products of the
%columns of U and V. Since this matching is a result from a multimodal
%matching, we then resolve conflict by taking the top weighted edges or
%solving bipartite matching on the new network

[~,ma,mb,~,~] = approx1overk(U,V);

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

