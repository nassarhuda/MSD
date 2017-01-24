function newX = pick_top_k(X,k)
% PICK_TOP_K takes as input an X matrix and keeps the top k elements in
% each row of X and each column of X
newX = zeros(size(X));

[X_sorted_rows,X_order_rows] = sort(X,2,'descend');
topk_sorted_rows = X_sorted_rows(:,1:k);
topk_oder_rows = X_order_rows(:,1:k);

for r = 1:size(X,1)
    for c = 1:k
        newX(r,topk_oder_rows(r,c)) = topk_sorted_rows(r,c);
    end
end

[X_sorted_cols,X_order_cols] = sort(X,1,'descend');
topk_sorted_cols = X_sorted_cols(1:k,:);
topk_oder_cols = X_order_cols(1:k,:);

for c = 1:size(X,2)
    for r = 1:k
        newX(topk_oder_cols(r,c),c) = topk_sorted_cols(r,c);
    end
end

end