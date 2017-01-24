%% Show a recovery plot for the pairwise data
% This takes about two hours with these parameters.
% With Isorank and parpool 6, it takes 150 seconds
% With BP it takes about 112 seconds
% 2016-10-11: When I tried these, MR had the 
% best result. So pairwise_recovery_mr has an
% Xpair that is >= the Xpair from BP or Iso.
%
% This was done by iterating through 
% recovery_experiment_pairwise and changing
%    [ma,mb] = align_pairwise(As,Bs,'mr');
% to the vairous different algorithms. 

% 2016-10-11: Changed to 100 trials 
% to smooth out noise, this should take
% 20/6 or about 4 hours with parpool = 6
% and I"m running it overnight
% 2016-10-12: Added alignment of the 
% smashed networks to the pairwise case
% this is the final set of scores, we also 
% added the output.
% 2016-10-12: Added another update. 

ntrials = 50;
edgeps = linspace(0,0.3,10);
vertps = linspace(0,0.3,10);

n = 36;
d = 3; % avg degree in G
m = 6;

Xpair = zeros(numel(edgeps),numel(vertps));
Mscores = cell(numel(edgeps),numel(vertps));
parfor ei=1:numel(edgeps)
    row = zeros(numel(vertps),1);
    scores = cell(numel(vertps,1));
    for vi=1:numel(vertps)
        vp = vertps(vi);
        ep = edgeps(ei);
        %Xpair(ei,vi) = recovery_experiment_pairwise(n,d,m,ntrials,vp,ep);
        %[row(vi),scorelist] = recovery_experiment_pairwise(n,d,m,ntrials,vp,ep);
        [row(vi),scorelist] = recovery_experiment_pairwise('iso',n,d,m,ntrials,vp,ep);
        scores{vi} = scorelist
    end
    Xpair(ei,:) = row;
    Mscores(ei,:) = scores;
end

%%
save pairwise_recovery_iso.mat Xpair n d m edgeps vertps ntrials Mscores

%%
%image(100*Xpair)
imagesc(Xpair)
set(gca,'YDir','normal');
set(gca,'XTick',1:size(Xpair,2));
set(gca,'YTick',1:size(Xpair,1));
set(gca,'XTickLabel',cellstr(num2str(vertps','%.2f')));
set(gca,'YTickLabel',cellstr(num2str(edgeps','%.2f')));
xlabel('Vertex Deletion Probability');
ylabel('Edge Deletion Probability');
caxis([0.25,1])
colormap(bone)

%% 
% post-process to show which element helped the match
Modes=zeros(numel(edgeps),numel(vertps));
for ei=1:numel(edgeps)
    for vi=1:numel(vertps)
        Modes(ei,vi) = mean(cellfun(@maxind,Mscores{ei,vi}) > m);
    end
end
imagesc(Modes);
set(gca,'YDir','normal');
set(gca,'XTick',1:size(Xpair,2));
set(gca,'YTick',1:size(Xpair,1));
set(gca,'XTickLabel',cellstr(num2str(vertps','%.2f')));
set(gca,'YTickLabel',cellstr(num2str(edgeps','%.2f')));
xlabel('Vertex Deletion Probability');
ylabel('Edge Deletion Probability');
title('0 is modal, 1 is smashed');
caxis([0.25,1])
colormap(bone)
    
