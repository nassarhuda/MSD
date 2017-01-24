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
clear all
%addpath(genpath('../../GLOBAL_CODE'))
ntrials = 50;
edgeps = linspace(0,0.3,10);
vertps = linspace(0,0.3,10);

n = 36;
d = 3; % avg degree in G
m = 6;

X = zeros(numel(edgeps),numel(vertps));
Mscores = cell(numel(edgeps),numel(vertps));
for ei=1:numel(edgeps)
    row = zeros(numel(vertps),1);
    for vi=1:numel(vertps)
        vp = vertps(vi);
        ep = edgeps(ei);
        %Xpair(ei,vi) = recovery_experiment_pairwise(n,d,m,ntrials,vp,ep);
        [row(vi),scorelist] = recovery_experiment_multimodal(n,d,m,ntrials,vp,ep);
        scores{vi} = scorelist;
    end
    X(ei,:) = row;
    Mscores(ei,:) = scores;
end


%%
% save multimodal_recovery_var3.mat Xpair n d m edgeps vertps ntrials
% save multimodal_recovery_bp.mat Xpair n d m edgeps vertps ntrials
save multimodal_recovery_v2.mat 
