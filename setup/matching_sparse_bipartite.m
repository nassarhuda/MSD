function [ma,mb,vals] = matching_sparse_bipartite(U,V,nnodes1,nnodes2,k)
%MATCHING_BIPARTITE takes in two matrices U and V, and solves for the
%bipartite matching on X = UV';
%Since this matching is a result from a multimodal
%matching, we then resolve conflict by taking the top weighted edges or
%solving bipartite matching on the new network

X = U*V';
X = pick_top_k(X,k);
X = sparse(X);

[~,ma,mb] = bipartite_matching(X);

maproj = mod(ma,nnodes1);
maproj(maproj==0) = nnodes1;

mbproj = mod(mb,nnodes2);
mbproj(mbproj==0) = nnodes2;

U1 = U(ma,:);
V1 = V(mb,:);

allweights = sum(U1.*V1,2);

[sortedweights,order] = sort(allweights,'descend');
maordered = maproj(order);
mbordered = mbproj(order);

nnodes = min(nnodes1,nnodes2);

already_pickedU = zeros(nnodes1,1);
already_pickedV = zeros(nnodes2,1);
MATCHING = zeros(nnodes,3);

r = 0;
for i = 1:length(maordered)
    a = maordered(i);
    b = mbordered(i);
    if already_pickedU(a) == 0 && already_pickedV(b) == 0
        r = r + 1;        
        MATCHING(r,1) = a;
        MATCHING(r,2) = b;
        MATCHING(r,3) = sortedweights(i);
        already_pickedU(a) = already_pickedU(a) + 1;
        already_pickedV(b) = already_pickedV(b) + 1;
    end
    if r == nnodes
        break;
    end
end
MATCHING = MATCHING(1:r,:);
ma = MATCHING(:,1);
mb = MATCHING(:,2);
vals = MATCHING(:,3);

end

