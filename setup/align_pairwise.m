function [ma,mb,matches,scores] = align_pairwise(As,Bs,method)
% ALIGN_PAIRWISE Compute a best-of-all pairwise alignment
%
% Compute a network alignment pairwise between nodes of the 
% multimodal adjacency matrices individually. Then take the
% best-of-pairwise via the highest multimodal overlap.
%
% The last score corresponds to the score of smashing 
% all the modes together (in an unweighted sense)

if ~exist('method','var'), method='mr'; end

% try the sum
Asmash = As{1};
Bsmash = Bs{1};
for i=2:length(As)
    Asmash = Asmash + As{i};
    Bsmash = Bsmash + Bs{i};
end
As{end+1} = spones(Asmash);
Bs{end+1} = spones(Bsmash);

m = length(As);
assert(length(Bs) == m);
matches = cell(m,1);
scores = zeros(m,1);
for i=1:m
    Ai = As{i};
    Bi = Bs{i};
    [S,w,li,lj] = netalign_setup(Ai,Bi,ones(size(Ai,1),size(Bi,1)));
    switch method
        case {'bp','netalignbp'}
            mbest = netalignbp(S,w,1,10,li,lj);
        case {'mr','netalignmr'}
            mbest = netalignmr(S,w,1,10,li,lj);
        case {'iso','isorank'}
            mbest = isorank(S,w,1,10,li,lj);
        otherwise
            mbest = netalignmr(S,w,1,10,li,lj);
    end
    [~,ma,mb] = bipartite_matching(mbest,li,lj,max(li),max(lj));
    matches{i} = [ma mb];
    scores(i) = score_pairwise_match(As(1:end-1),Bs(1:end-1),ma,mb);
end


[~,bestind] = max(scores);
ma = matches{bestind}(:,1);
mb = matches{bestind}(:,2);