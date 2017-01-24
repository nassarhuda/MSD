
%% Prepare the final plots based on the recovery experiment
% See adding_modes_plots for those figures.

%%
mr = load('pairwise_recovery_mr'); %output form recovery_plot_pairwise
msd = load('multimodal_recovery'); %output from recovery_plot_multimodal
iso = load('pairwise_recovery_iso'); %output from recovery_plot_pairwise_iso

%%
assert(all(mr.vertps == msd.vertps))
assert(all(mr.vertps == iso.vertps))
assert(all(mr.edgeps == msd.edgeps))
assert(all(mr.edgeps == iso.edgeps))
assert(mr.ntrials == iso.ntrials)
assert(mr.ntrials == msd.ntrials)
assert(mr.m == iso.m)
assert(mr.m == msd.m)
assert(mr.d == iso.d)
assert(mr.d == msd.d)
assert(mr.n == iso.n)
assert(mr.n == msd.n)

%%
edgeps = iso.edgeps;
vertps = iso.vertps;
n = iso.n;
m = iso.m;
d = iso.d;


%%
Xmr = mr.X;
Xiso = iso.X;
Xmsd = msd.X;

%%
clf;
Z = Xmr;
Z(end+1,end+1) = 0;
h = pcolor(Z);
set(h,'EdgeColor',0.7*[1,1,1]);
set(gca,'YDir','normal');
set(gca,'XTick',(1:size(Xmr,2))+0.5);
set(gca,'YTick',(1:size(Xmr,1))+0.5);
set(gca,'XTickLabel',cellstr(num2str(vertps','%.2f')));
set(gca,'YTickLabel',cellstr(num2str(edgeps','%.2f')));
xlabel('Vertex Deletion Probability');
ylabel('Edge Deletion Probability');
for i=1:numel(edgeps)
    for j=1:numel(vertps)
        text(j+0.5,i+0.5,sprintf('%.2f',Z(i,j)),...
            'HorizontalAlignment','center',...
            'Color',0.5*[1,1,1],...
            'FontSize',9);
    end
end
caxis([0.5,1])
colormap(flipud([229,245,224
199,233,192
161,217,155
116,196,118
65,171,93
35,139,69])/255);

set_figure_size([4.1,3.9]);
print(gcf,'recovery-mr.eps','-depsc2');

%%
clf;
Z = Xmsd;
Z(end+1,end+1) = 0;
h=pcolor(Z);
set(h,'EdgeColor',0.7*[1,1,1]);

set(gca,'YDir','normal');
set(gca,'XTick',(1:size(Xmr,2))+0.5);
set(gca,'YTick',(1:size(Xmr,1))+0.5);
set(gca,'XTickLabel',cellstr(num2str(vertps','%.2f')));
set(gca,'YTickLabel',cellstr(num2str(edgeps','%.2f')));
xlabel('Vertex Deletion Probability');
ylabel('Edge Deletion Probability');
for i=1:numel(edgeps)
    for j=1:numel(vertps)
        text(j+0.5,i+0.5,sprintf('%.2f',Z(i,j)),...
            'HorizontalAlignment','center',...
            'Color',0.5*[1,1,1],...
            'FontSize',9);
        %h = text(i-.5,j-.5,'Hi',');
    end
end
caxis([0.5,1])
colormap(flipud([229,245,224
199,233,192
161,217,155
116,196,118
65,171,93
35,139,69])/255);

set_figure_size([4.1,3.9]);
print(gcf,'recovery-msd.eps','-depsc2');

%%
clf;
Z = Xiso;
Z(end+1,end+1) = 0;
h=pcolor(Z);
set(h,'EdgeColor',0.7*[1,1,1]);

set(gca,'YDir','normal');
set(gca,'XTick',(1:size(Xmr,2))+0.5);
set(gca,'YTick',(1:size(Xmr,1))+0.5);
set(gca,'XTickLabel',cellstr(num2str(vertps','%.2f')));
set(gca,'YTickLabel',cellstr(num2str(edgeps','%.2f')));
xlabel('Vertex Deletion Probability');
ylabel('Edge Deletion Probability');
for i=1:numel(edgeps)
    for j=1:numel(vertps)
        text(j+0.5,i+0.5,sprintf('%.2f',Z(i,j)),...
            'HorizontalAlignment','center',...
            'Color',0.5*[1,1,1],...
            'FontSize',9);
        %h = text(i-.5,j-.5,'Hi',');
    end
end
caxis([0.5,1])
%colormap(bone)
%colormap(redbluecmap(5));
colormap(flipud([229,245,224
199,233,192
161,217,155
116,196,118
65,171,93
35,139,69])/255);
set_figure_size([4.1,3.9]);
print(gcf,'recovery-iso.eps','-depsc2');


%%
clf;
Z = Xmsd - Xmr;
Z(end+1,end+1) = 0;
h=pcolor(Z);
set(h,'EdgeColor',0.7*[1,1,1]);
colormap(flipud(redbluecmap(11)))
caxis([-0.5,0.5])
set(gca,'XTick',(1:size(Xmr,2))+0.5);
set(gca,'YTick',(1:size(Xmr,1))+0.5);
set(gca,'XTickLabel',cellstr(num2str(vertps','%.2f')));
set(gca,'YTickLabel',cellstr(num2str(edgeps','%.2f')));
xlabel('Vertex Deletion Probability');
ylabel('Edge Deletion Probability');
for i=1:numel(edgeps)
    for j=1:numel(vertps)
        str = sprintf(' %+.2f',Z(i,j)); % need an extra space for centering
        str(3) = []; % delete the 0
        text(j+0.5,i+0.5,str,...
            'HorizontalAlignment','center','Color',0.5*[1,1,1],...
            'FontSize',9);
        %h = text(i-.5,j-.5,'Hi',');
    end
end
set_figure_size([4.1,3.9]);
print(gcf,'recovery-difference.eps','-depsc2');

%%
sum(sum(Xmsd >= Xmr))
sum(sum(Xmsd >= Xiso))
