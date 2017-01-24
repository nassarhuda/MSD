%% 1/k appx
function [t1,ma,mb,U_order,V_order] = approx1overk_baseline(U,V,k)
t0 = tic;
% APPROX1OVERK_BASELINE is the basic 1/k matching approximation
% it computes the best matching applied on its corresponding rank 1 matrix

% do not uncomment the code below:
% these are meant to explain the next 4 lines of code
% for i = 1:size(U,2)
%     [U_post(:,i), U_order(:,i)] = sort(U(:,i));
%     [V_post(:,i), V_order(:,i)] = sort(V(:,i));
%     weights(i) = dot(U_post(:,i),V_post(:,i));
% end

[U_post,U_order] = sort(U,'descend');
[V_post,V_order] = sort(V,'descend');
temp = min(size(U,1),size(V,1));
U_post = U_post(1:temp,:);
V_post = V_post(1:temp,:);
W = U_post.*V_post;
weights = sum(W);
weights = weights(k:k:end);
[~, match_id] = max(weights);
ma = U_order(:,match_id);
mb = V_order(:,match_id);
t1 = toc(t0);

end