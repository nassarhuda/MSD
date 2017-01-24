function overlap = score_pairwise_match(As,Bs,ma,mb)
% SCORE_PAIRWISE_MATCH
% 
%  overlap = score_pairwise_match(As,Bs,ma,mb)
% 
%  Compute the number of edges overlapped by the 
%  alignment between nodes ma and mb in the 
%  set of multimodal adjacency matrices As,Bs

m = length(As);
assert(length(Bs) == m);
overlap = 0;
for i=1:m
    % align the two networks and count edges
    Ai = As{i}(ma,ma);
    Bi = Bs{i}(mb,mb);
    overlap = overlap + nnz(Ai.*Bi)/2;
end