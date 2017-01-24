%%
close all
order = [1, 2, 3, 4, 5, 7, 8, 10, 12, 14, 16, 18, 20, ...
    22, 24, 26, 28, 30, 32, 34, 36, 38, 40,...
    43, 46, 49, 51, 55, 60, 65, 70, 75, 100, 125, 150,175];
%%
close all
subset = 1:27;
order_sub = order(subset);
hold off
figure
hold all

load edge_experiment_result2.mat
plot(order,modal_scores,'LineWidth',1);

load vertex_experiment_result2.mat
plot(order,modal_scores,'LineWidth',1);

load avgdeg_experiment_result2.mat
plot(order,modal_scores,'LineWidth',1);

load ntris_experiment_result2.mat
plot(order,modal_scores,'LineWidth',1);

load density_experiment_result2.mat
plot(order,modal_scores,'LineWidth',1);

load randomperm_experiment_result1.mat
plot(order,modal_scores,'k','LineWidth',0.5);

load randomperm_experiment_result2.mat
plot(order,modal_scores,'k','LineWidth',0.5);

load randomperm_experiment_result3.mat
plot(order,modal_scores,'k','LineWidth',0.5);

legend('edgecount','vertex count','avg degree',...
    '# triangles','density','random','Location','SouthEast');

xlabel('number of modes');
ylabel('size of overlap');

legend boxoff
rectangle('Position',[0 0.8 35 0.2],'EdgeColor', [0.5 0.5 0.5])

%% inset figure:
axes('Position',[.7 .6 .2 .2])
box on
hold all


load edge_experiment_result2.mat
modal_scores_sub = modal_scores(subset);
plot(order_sub,modal_scores_sub,'.-','LineWidth',0.5);

load vertex_experiment_result2.mat
modal_scores_sub = modal_scores(subset);
plot(order_sub,modal_scores_sub,'.-','LineWidth',0.5);

load avgdeg_experiment_result2.mat
modal_scores_sub = modal_scores(subset);
plot(order_sub,modal_scores_sub,'.-','LineWidth',0.5);

load ntris_experiment_result2.mat
modal_scores_sub = modal_scores(subset);
plot(order_sub,modal_scores_sub,'.-','LineWidth',0.5);

xlim([0 35])
ylim([0.8 0.95])

% plot(order_sub,modal_scores_sub)
box off

set_figure_size([3.25,2.75]);
print('-depsc','mode_by_mode_with_inset_v2.eps');
close all;
%% inset figure

% hold off
% figure
% hold all
% 
% 
% order_sub = order(1:10);
% 
% load edge_experiment_result2.mat
% modal_scores_sub = modal_scores(1:10);
% plot(order_sub,modal_scores_sub,'LineWidth',1);
% 
% load vertex_experiment_result2.mat
% modal_scores_sub = modal_scores(1:10);
% plot(order_sub,modal_scores_sub,'LineWidth',1);
% 
% load avgdeg_experiment_result2.mat
% modal_scores_sub = modal_scores(1:10);
% plot(order_sub,modal_scores_sub,'LineWidth',1);
% 
% load ntris_experiment_result2.mat
% modal_scores_sub = modal_scores(1:10);
% plot(order_sub,modal_scores_sub,'LineWidth',1);
% 
% legend('edgecount','vertex count','avg degree',...
%     '# triangles','Location','SouthEast');
% 
% xlabel('number of modes');
% ylabel('size of overlap');
% 
% legend boxoff
% hold off
% set_figure_size([3.25,2.75]);
% 
% print('-depsc','inset.eps');
