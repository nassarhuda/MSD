%% attempt to get 1/k with partial DP
function [t1,ma,mb] = app1overk_with_partialDP(U,V)

% APP1OVERK_WITH_PARTIALDP Compute a matching based on the union of all
% matchings obtained by the low rank factors U and V
%
% t1 is the time the method takes
% [ma mb] is the matching

t0 = tic;
[~,U_order] = sort(U,'descend');
[~,V_order] = sort(V,'descend');
n = min(size(U,1),size(V,1));
%%

if ~isequal(size(U),size(V))
    n = min(size(U_order,1),size(V_order,1));
    U_order = U_order(1:n,:);
    V_order = V_order(1:n,:);
end

ALLMATCH = [U_order(:),V_order(:)];
[ALLMATCHUNIQUE,~,~] = unique(ALLMATCH,'rows');

size_unique = size(ALLMATCHUNIQUE,1);
vv = zeros(size_unique,1);
niters = floor(size_unique/n);

for i = 1:niters
    interval = (((i-1)*n)+1):i*n;
    U1 = U(ALLMATCHUNIQUE(interval,1),:);
    V1 = V(ALLMATCHUNIQUE(interval,2),:);
    vv(interval) = sum(U1 .*V1,2);
end
interval = (i*n)+1:size_unique;
U1 = U(ALLMATCHUNIQUE(interval,1),:);
V1 = V(ALLMATCHUNIQUE(interval,2),:);
vv(interval) = sum(U1 .*V1,2);

X = sparse(ALLMATCHUNIQUE(:,1),ALLMATCHUNIQUE(:,2),vv);
[~,ma,mb] = bipartite_matching(X);


% equivalent to the code below, but the above takes about a minute
% whereas the code below takes about 25 mins

% X = sparse(size(U,1),size(V,1));
% for i = 1:size(U_order,2)
%     uo = U_order(:,i);
%     U1 = U(uo,:);
%     
%     vo = V_order(:,i);
%     V1 = V(vo,:);
%     
%     weights = sum(U1.*V1,2);
%     X = X + sparse(uo,vo,weights);
% end
% [~,ma,mb] = bipartite_matching(X);


% equivalent to this code if space is not an issue:

% ALLMATCH = [U_order(:),V_order(:)];
% [ALLMATCHUNIQUE,~,~] = unique(ALLMATCH,'rows');
% 
% U1 = U(ALLMATCHUNIQUE(:,1),:);
% V1 = V(ALLMATCHUNIQUE(:,2),:);
% 
% vv = U1 .*V1;
% allweights = sum(vv,2);
% 
% X = sparse(ALLMATCHUNIQUE(:,1),ALLMATCHUNIQUE(:,2),allweights);
% [~,ma,mb] = bipartite_matching(X);


t1 = toc(t0);
end