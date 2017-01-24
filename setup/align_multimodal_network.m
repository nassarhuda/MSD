function [ma,mb,score,total_score,As,Bs] = ...
    align_multimodal_network(M,N,matching_method,...
    input_modes,alpha,iters,resolve_matching,As,Bs,nnodes1,nnodes2,topk)
%ALIGN_MULTIMODAL_NETWORK aligns two multimodal networks and
% computes the matching based on one of these methods:
% 1overk_weight: best rank 1 matching based on the weight of that matching
% 1overk_nnz: best rank 1 matching based on the number of nonzeros it
% preserves
% 1overk_union: union of all rank 1 matchings
% bipartite matching on the entire similarity matrix

nmodes = length(input_modes);
if ~exist('nnodes1','var') && ~exist('nnodes2','var')
    [U,V,multimodal1,multimodal2] = compute_UV(M,N,input_modes,alpha,iters);
    nnodes1 = max(max(M(:,2:3)));
    nnodes2 = max(max(N(:,2:3)));
else
    [U,V,multimodal1,multimodal2] = compute_UV(M,N,input_modes,alpha,iters,nnodes1,nnodes2);
end

if ~exist('As','var') && ~exist('Bs','var')
    [As,Bs] = generate_pairwise_networks(multimodal1{1},multimodal2{1},...
        nmodes,nnodes1,nnodes2);
end

switch matching_method
    case{'1overk_baseline'}
        [ma,mb,~] = matching_maxweight_1overk_baseline(U,V,nnodes1,nnodes2);
    case{'1overk_weight'}
        [ma,mb,~] = matching_maxweight_1overk(U,V,nnodes1,nnodes2,resolve_matching);
    case{'1overk_nnz'}
        MM1 = multimodal1{2};
        NN1 = multimodal2{2};
        [ma,mb,~] = matching_max_overlappededges(U,V,MM1,NN1,nnodes1,nnodes2,resolve_matching);
    case{'1overk_union'}
        [ma,mb,~] = matching_union_1overk(U,V,nnodes1,nnodes2,resolve_matching);
    case{'bipartite','bp'}
        [ma,mb,~] = matching_bipartite(U,V,nnodes1,nnodes2);
    case{'sparsify_bipartite'}
        [ma,mb,~] = matching_sparse_bipartite(U,V,nnodes1,nnodes2,topk);
    otherwise
        [ma,mb,~] = matching_union_1overk(U,V,nnodes1,nnodes2);
end
score = score_pairwise_match(As,Bs,ma,mb);
total_score = sum(cellfun(@nnz,As))/2;

end

