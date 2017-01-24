%% multimodal alignment options:
setup_and_loaddata

[ma,mb,score,total_score,As,Bs] = ...
    align_multimodal_network(M,N,'1overk_weight',input_modes,0.9,8,'bp');
score_multimodal = score;

% [ma,mb,score,total_score,As,Bs] = ...
%     align_multimodal_network(M,N,'1overk_weight',input_modes,0.9,8,'maxfirst');
% score_multimodal = score;
% 
% [ma,mb,score,total_score,As,Bs] = ...
%     align_multimodal_network(M,N,'1overk_nnz',input_modes,0.9,8,'bp');
% score_multimodal = score;
% 
% [ma,mb,score,total_score,As,Bs] = ...
%     align_multimodal_network(M,N,'1overk_nnz',input_modes,0.9,8,'maxfirst');
% score_multimodal = score;
% 
% [ma,mb,score,total_score,As,Bs] = ...
%     align_multimodal_network(M,N,'1overk_union',input_modes,0.9,8,'bp');
% score_multimodal = score;
% 
% [ma,mb,score,total_score,As,Bs] = ...
%     align_multimodal_network(M,N,'1overk_union',input_modes,0.9,8,'maxfirst');
% score_multimodal = score;

%% pairwise alignment options

% [ma_pairwise,mb_pairwise,matches,scores] = align_pairwise(As,Bs,'mr');
% score_pairwise = max(scores(1:end-1));
% score_smash = scores(end);
% 
% [ma_pairwise,mb_pairwise,matches,scores] = align_pairwise(As,Bs,'bp');
% score_pairwise = max(scores(1:end-1));
% score_smash = scores(end);
% 
% [ma_pairwise,mb_pairwise,matches,scores] = align_pairwise(As,Bs,'iso');
% score_pairwise = max(scores(1:end-1));
% score_smash = scores(end);