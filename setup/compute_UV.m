function [U,V,multimodal1,multimodal2] = compute_UV(M,N,input_modes,alpha,iters,nnodes1,nnodes2)
% COMPUTE_UV Given two multimodal networks M and N represented 
% in triplet format, Generate the two matrices U and V where 
% if X = UV', then X(i,j) represents the similarity score between node i
% in M and node j in N

MD = numel(input_modes);
v = N(:,1);
nb_rows = sum(ismember(v,input_modes));
ROWS = zeros(nb_rows,1);
l = 1;
for i = 1:MD
    rows = find(v==input_modes(i));
    r = numel(rows);
    ROWS(l:l+r-1) = rows;
    l = l+r;
end

Nsub = N(ROWS,:);

MD = numel(input_modes);
v = M(:,1);
nb_rows = sum(ismember(v,input_modes));
ROWS = zeros(nb_rows,1);
l = 1;
for i = 1:MD
    rows = find(v==input_modes(i));
    r = numel(rows);
    ROWS(l:l+r-1) = rows;
    l = l+r;
end
Msub = M(ROWS,:);

% nnodes1 = length(unique(M(:,2:3)));
if ~exist('nnodes1','var')
    nnodes1 = max(max(M(:,2:3)));
end
nmodes1 = length(input_modes);
[M1,MM1,sz1] = create_multimodal_network_3(nnodes1,nmodes1,Msub,input_modes);

% nnodes2 = length(unique(N(:,2:3)));
if ~exist('nnodes2','var')
    nnodes2 = max(max(N(:,2:3)));
end
nmodes2 = length(input_modes);
[N1,NN1,sz2] = create_multimodal_network_3(nnodes2,nmodes2,Nsub,input_modes);

U = zeros(sz2,nmodes2);
V = zeros(sz1,nmodes1);
% the matrix L is U*V'
st1 = 1;
en1 = nnodes2;

st2 = 1;
en2 = nnodes1;

u = ones(nnodes2,1);
v = ones(nnodes1,1);

for i = 1:nmodes1
    U(st1:en1,i) = (1/(nnodes2*sqrt(nmodes1)))*u;
    V(st2:en2,i) = (1/(nnodes1*sqrt(nmodes1)))*v;
    st1 = en1+1;
    en1 = en1+nnodes2;
    
    st2 = en2+1;
    en2 = en2+nnodes1;
end
%% Prepare for alignment

ivecsA = cell(1,nmodes1);
ivecsB = cell(1,nmodes1);
for i = 1:nmodes1
    ivecsA{i} = U(:,i);
    ivecsB{i} = V(:,i);
end

% alpha = 0.9;
% iters = 5;
M1 = max(M1,M1');
N1 = max(N1,N1');
MM1 = max(MM1,MM1');
NN1 = max(NN1,NN1');
[U,V, ~] = NSD_rank_compute_UV(N1, M1, alpha, iters, ivecsA, ivecsB);

multimodal1 = {M1,MM1,sz1};
multimodal2 = {N1,NN1,sz2};


end

