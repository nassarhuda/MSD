function [As,Bs] = generate_pairwise_networks(M,N,nmodes,sz1,sz2)
% GENERATE_PAIRWISE_NETWORKS
% 
%  overlap = score_pairwise_match(As,Bs,ma,mb)
% 
%  Given two multimodal netwroks, return the uni-modal networks

k = nmodes;
As = cell(k,1);
Bs = cell(k,1);

for i = 1:k
    As{i} = M((i-1)*sz1+1:i*sz1,(i-1)*sz1+1:i*sz1);
    Bs{i} = N((i-1)*sz2+1:i*sz2,(i-1)*sz2+1:i*sz2);
end

end