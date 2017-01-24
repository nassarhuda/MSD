function [M1,N1,sz_openflight] = create_multimodal_network_3(m,modes_openflight,O,input_modes)
% given the network O that represents networks of multiple modes and a
% number of modes modes_openflight, create a multimodal network M1. m is
% the total number of nodes in one mode. sz_openflight is the size of the 
% new multimodal network

cliques_to_form = cell(m,1);

% pre-process step
modes_col = O(:,1);
s = zeros(modes_openflight,1);
for i = 1:modes_openflight
    s(i) = numel(find(modes_col==input_modes(i)));
end

ei = O(:,2);
ej = O(:,3);
ei = ei(1:sum(s));
ej = ej(1:sum(s));

% Find the new indices
eii = zeros(numel(ei),1);
ejj = zeros(numel(ej),1);
k = 1;
for i = 1:modes_openflight
    st = (i-1)*m;
    for j = 1:s(i)
        a = ei(k);
        b = ej(k);
        cliques_to_form{a} = unique([cliques_to_form{a},i]);
        cliques_to_form{b} = unique([cliques_to_form{b},i]);
        eii(k) = st + a;
        ejj(k) = st + b;
        k = k + 1;
    end
end

% Find off diagonal edges
edges_to_add = 0;
for i = 1:m
    e = numel(cliques_to_form{i});
    edges_to_add = edges_to_add + e^2 - e;
end

ri = zeros(edges_to_add/2,1);
rj = zeros(edges_to_add/2,1);
k = 1;
for i = 1:m
    clq = cliques_to_form{i};
    clq = ((clq - 1) .* m) + i; % new mapped ids
    e = numel(clq);
    for j = 1:e
        p = clq(j);
        for r = j+1:e
            ri(k) = p;
            rj(k) = clq(r);
            k = k + 1;
        end
    end
    % note that I'm adding one version of the edges only
end

% create the multimodal network
EI = [eii;ri;rj];
EJ = [ejj;rj;ri];
sz_openflight = double(m*modes_openflight); %size
M1 = sparse(EI,EJ,1,sz_openflight,sz_openflight);
M1 = spones(M1);

N1 = sparse(eii,ejj,1,sz_openflight,sz_openflight);
end