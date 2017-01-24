function [vals,ma,mb] = resolve_matching_bipartite(maproj,mbproj,allweights)
% RESOLVE_MATCHING_BIPARTITE resolves the multimodal matchings into one
% mode matchings by taking the projected problem onto one mode and solving
% a bipartite matching on it
X = sparse(maproj,mbproj,allweights);
[vals,ma,mb] = bipartite_matching(X);
end
