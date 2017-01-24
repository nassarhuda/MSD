%%
% This plot is designed to address what happens to each method as we
% add modes for a fixed 

%% Here is the motivation for our samples
% This needs to be done after final_plots.m has been run to look
% at cases where MR does better and cases where MSD does better. 
%edgeps(4)
%ans =
%    0.1000
%edgeps(7)
%ans =
%    0.2000
% Xmr(4,7),Xmr(7,4)
% ans =
%     0.8795
% ans =
%     0.9062
% Xiso(4,7),Xiso(7,4)
% ans =
%     0.7367
% ans =
%     0.8685
% Xmsd(4,7),Xmsd(7,4)
% ans =
%     0.9796
% ans =
%     0.8507
    
%% Common
d = 3;
n = 36;
ntrials = 50;
mmax = 10;

%% Case 1
vp = 0.1;
ep = 0.2;
msd = adding_modes_experiment(n,d,vp,ep,mmax,ntrials,'multi');
mr = adding_modes_experiment(n,d,vp,ep,mmax,ntrials,'mr');
iso = adding_modes_experiment(n,d,vp,ep,mmax,ntrials,'iso');
save 'modes_results_1.mat' mr iso msd;


%% Case 2
ep = 0.1;
vp = 0.2;
mr = adding_modes_experiment(n,d,vp,ep,mmax,ntrials,'mr');
iso = adding_modes_experiment(n,d,vp,ep,mmax,ntrials,'iso');
msd = adding_modes_experiment(n,d,vp,ep,mmax,ntrials,'multi');
save 'modes_results_2.mat' mr iso msd;

%% Plots
load modes_results_1
clf;
hold all;
p = 10;
h0 = percentile_plot(msd.F,p);
h1 = percentile_plot(mr.F,p);
%hold all;
%h2 = percentile_plot(iso.F,p); 
legend([h0(1),h1(1)],'MSD','Pairwise','Location','SE');
legend boxoff;
xlabel('Number of modes');
ylabel('Fraction of edges recovered');
ylim([0.5,1])
xlim([1,mr.mmax]);
set(gca,'XTick',1:10);
set_figure_size([3,2.5]);
print(gcf,'adding_modes_case_1_vp1_ep2.eps','-depsc2');

%%
load modes_results_2
clf;
hold all;
p = 10;
h0 = percentile_plot(msd.F,p);
h1 = percentile_plot(mr.F,p);
%hold all;
%h2 = percentile_plot(iso.F,p); 
legend([h0(1),h1(1)],'MSD','Pairwise','Location','SE');
legend boxoff;
xlabel('Number of modes');
ylabel('Fraction of edges recovered');
ylim([0.5,1])
xlim([1,mr.mmax]);
set(gca,'XTick',1:10);
set_figure_size([3,2.5]);
print(gcf,'adding_modes_case_2_vp2_ep1.eps','-depsc2');