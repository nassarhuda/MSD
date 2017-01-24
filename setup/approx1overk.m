%% 1/k appx
function [t1,ma,mb,U_order,V_order] = approx1overk(U,V)
% APPROX1OVERK Compute a the best of all matchings obtained from the low
% rank factors from U and V applied on the network

% t1 is the time the method takes
% [ma mb] is the matching
% [U_order,V_order] are all the posible matchings
%   i.e. [U_order(:,i) V_order(:,i)] contribute to a matching

t0 = tic;
% do not uncomment the code below:
% these are meant to explain the next 4 lines of code
% for i = 1:size(U,2)
%     [U_post(:,i), U_order(:,i)] = sort(U(:,i));
%     [V_post(:,i), V_order(:,i)] = sort(V(:,i));
%     weights(i) = dot(U_post(:,i),V_post(:,i));
% end
[~,U_order] = sort(U,'descend');
[~,V_order] = sort(V,'descend');
if ~isequal(size(U),size(V))
    till = min(size(U_order,1),size(V_order,1));
    U_order = U_order(1:till,:);
    V_order = V_order(1:till,:);
else
    till = size(U,1);
end
n = till;

% Ut = U';
% Vt = V';
% 
% Uordervec = U_order(:);
% Vordervec = V_order(:);
% 
% weights = zeros(size(U_order,2),1);
% ssw = zeros(length(Vordervec),1);
% 
% for i = 1:size(Vordervec,1)
%     ssw(i) = sum(Ut(:,Uordervec(i)).*Vt(:,Vordervec(i)));
% end
% stid = 1:size(U_order,1):size(Uordervec,1);
% enid = size(U_order,1):size(U_order,1):size(Uordervec,1);
% 
% for i = 1:size(U_order,2)
%     weights(i) = sum(ssw(stid(i):enid(i)));
% end
% 
% [~,maxid] = max(weights);
% ma = U_order(:,maxid);
% mb = V_order(:,maxid);
% t1 = toc(t0);

% the below code is equivalent to the one commented above
% with 8 iterations and alpha = 0.9, the code below takes about 2 mins
% whereas the code above takes about 10 minutes (on the airlines example)
% difference is:
% the code above is the simplified version of applying each matching at a
% time
% the idea of the code below is: if matching node i to node j, occured more
% than once, then compute its weight only once
% both pieces of code return the same results.

ALLMATCH = [U_order(:),V_order(:)];
[ALLMATCHUNIQUE,~,IDX] = unique(ALLMATCH,'rows');

size_unique = size(ALLMATCHUNIQUE,1);
vv = zeros(size_unique,1);
niters = floor(size_unique/till);
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

allweights = zeros(size(U_order,2),1);
mn = till;
for t = 1:size(U_order,2)
    st = (t-1)*mn+1;
    en = t*mn;
    internal_idx = IDX(st:en);
    vals = vv(internal_idx);
    allweights(t) = sum(vals);
end

[~, match_id] = max(allweights);
ma = U_order(:,match_id);
mb = V_order(:,match_id);
t1 = toc(t0);


end
