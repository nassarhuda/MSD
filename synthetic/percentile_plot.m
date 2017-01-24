function hs = percentile_plot(X,p)
% PERCENTILE_PLOT Draw a plot with the mean and percentiles as lines
% with some styling

x = mean(X);
p1 = prctile(X,p);
p2 = prctile(X,100-p);
h = plot(x,'LineWidth',1);
c1 = get(h,'Color');
c = 0.25*c1 + 0.75*[1,1,1]; % brighten
n = size(X,2);
%h1 = plot(p1,'--','Color',c,'LineWidth',0.5);
%h2 = plot(p2,'--','Color',c,'LineWidth',0.5);
fill([1:n n:-1:1],[p1,fliplr(p2)],c,'EdgeColor','none');
h = plot(x,'LineWidth',1,'Color',c1);
%hs = [h,h1,h2];
hs = h;