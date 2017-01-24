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

%%
t0 = tic;
msd = recovery_plot_run(n,d,m,edgeps,vertps,ntrials,'multi');
msd.dt = toc(t0);
save 'multimodal_recovery.mat' -struct msd

t0 = tic;
iso = recovery_plot_run(n,d,m,edgeps,vertps,ntrials,'iso');
iso.dt = toc(t0);
save 'pairwise_recovery_iso.mat'  -struct iso

t0 = tic;
mr = recovery_plot_run(n,d,m,edgeps,vertps,ntrials,'mr');
mr.dt = toc(t0);
save 'pairwise_recovery_mr.mat' -struct mr 



