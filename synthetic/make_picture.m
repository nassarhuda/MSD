%%
addpath('../utils');
%%
n = 36;
d = 3;
G = spones(triu(sprand(n/3,n/3,d/(n/3)),1));
G = G + G';
%G = [G speye(size(G)); speye(size(G)) G];
G = kron([0 1 0; 1 0 1; 0 1 0],G);

xy = igraph_draw(G,'fr');

[px,py] = gplot(G,xy);


clf;
plot(px,py,'-','LineWidth',0.5,'Color',0.5*[1,1,1]);
hold on;
scatter(xy(:,1),xy(:,2),5,'r','filled');
axis off;

%%
writeSMAT('example_graph.smat',G);
save example_graph.mat G xy
dlmwrite('example_graph.xy',xy,'delimiter',' ')

%%
clf;
plot(px,py,'-','LineWidth',0.5,'Color',0.5*[1,1,1]);
hold on;
h = scatter(xy(:,1),xy(:,2),15,0.7*[0,1,0]);
set(h,'MarkerFaceColor','white');
axis off;
set_figure_size([2.5,2.5]);
axis equal;
%set(gca,'LooseInset',get(gca,'TightInset'))
print('example_graph.eps','-depsc2');
%print('example_graph.pdf','-dpdf');