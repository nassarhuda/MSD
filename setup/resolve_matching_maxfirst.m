function [vals,ma,mb] = resolve_matching_maxfirst(allweights,maproj,mbproj,nnodes1,nnodes2)
% RESOLVE_MATCHING_MAXFIRST resolves the multimodal matchings into one
% mode matchings by taking the projected problem onto one mode and then
% picking the top best matches

[sortedweights,order] = sort(allweights,'descend');
maordered = maproj(order);
mbordered = mbproj(order);

nnodes = min(nnodes1,nnodes2);

already_pickedU = zeros(nnodes1,1);
already_pickedV = zeros(nnodes2,1);
MATCHING = zeros(nnodes,3);

r = 0;
for i = 1:length(maordered)
    a = maordered(i);
    b = mbordered(i);
    if already_pickedU(a) == 0 && already_pickedV(b) == 0
        r = r + 1;        
        MATCHING(r,1) = a;
        MATCHING(r,2) = b;
        MATCHING(r,3) = sortedweights(i);
        already_pickedU(a) = already_pickedU(a) + 1;
        already_pickedV(b) = already_pickedV(b) + 1;
    end
    if r == nnodes
        break;
    end
end
MATCHING = MATCHING(1:r,:);
ma = MATCHING(:,1);
mb = MATCHING(:,2);
vals = MATCHING(:,3);

end