function [M,N,As,Bs] = synthetic_networks(G,m,ep,vp)
% GENERATE_NETWORKS Generate synthetic networks.
% 
% [M,N,As,Bs] = generate_networks(G,m,ep,vp)
%   Generates two multimodal networks based on the input
%   network G. Each multimodal network is a realization
%   of the following process. 
%     Generate mode i by deleting vertices with probability vp
%     independently. This generates a graph Gi with the 
%     same number of nodes. Then delete each edge of
%     Gi with probability ep/2. This generates Gi'. 
%     Then delete each edge between 
%     in Gi' with probability ep/2 independently to get Ai and Bi.
%   Then we produce m modes and assemble them into a multimodal
%   networks M and N
%     
% So if vp = 0, ep = 0, then we have the network
% [G I I ... I
%  I G I ... I
%  I I G ... ..
%  I ..I  .. G ] 
% for M and N
% And As = {G, ..., G}
% And if vp = 1, ep = 1, then we have:
% [0 0 ... 0
%  0 0 ... 0 ]
% which gives no alignment information. 
% As we vary ep and vp, we should see the advantage
% of multimodal alignment.
%
% TODO Fill in Huda's characteristics for a MM network

n = size(G,1);
G = spones(G);
G = G - diag(diag(G));
assert(issymmetric(G));
As = cell(m,1);
Bs = cell(m,1);

for i=1:m
    vfilt = rand(n,1) <= vp; 
    Gi = G;
    Gi(vfilt,:) = 0;
    Gi(:,vfilt) = 0;
    
    % perturb Gi into another common matrix with ep/2
    Gi1 = random_edge_deletion(Gi,ep/2);
    As{i} = random_edge_deletion(Gi1,ep/2);
    Bs{i} = fliporder(random_edge_deletion(Gi1,ep/2));
end

M = make_multimodal(As);
N = make_multimodal(Bs);

function Gp = random_edge_deletion(G,p)
    [ei,ej] = find(triu(G,1));
    Gp = sparse(ei,ej,rand(length(ei),1) >= p,size(G,1),size(G,2));
    Gp = Gp + Gp';

function Gp = fliporder(G)
p = size(G,1):-1:1;
Gp = G(p,p);
