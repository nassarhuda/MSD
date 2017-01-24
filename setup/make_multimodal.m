function M = make_multimodal(As)
% MAKE_MULTIMODAL Create multimodal triplets from adjacency matrices. 
%
% M = make_multimodal(As) creates a set of edges
%
% Example:
%  As = {sparse([0 1; 1 0]); sparse([0 1 1; 1 0 0; 1 0 0])};
%  make_multimodal(As)
% ans =
%      1     2     1
%      1     1     2
%      2     2     1
%      2     3     1
%      2     1     2
%      2     1     3

nzs = sum(cellfun(@nnz,As));
m = length(As);
M = zeros(nzs,3);
curedge = 1;
for i=1:m
   [I,J] = find(As{i});
   sa = length(I);
   
   M(curedge:curedge+sa-1,1) = i;
   M(curedge:curedge+sa-1,2) = I;
   M(curedge:curedge+sa-1,3) = J;
   
   curedge = curedge+sa;
end