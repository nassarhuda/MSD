function result = recovery_plot_run(n,d,m,edgeps,vertps,ntrials,method)
% RECOVERY_PLOT_RUN Run one full set of experiments for 
% the recovery setting using our multimodal codes.

X = zeros(numel(edgeps),numel(vertps));
F = zeros(numel(edgeps),numel(vertps),ntrials);
Mscores = cell(numel(edgeps),numel(vertps));
for ei=1:numel(edgeps)
    row = zeros(numel(vertps),1);
    scores = cell(numel(vertps,1));
    for vi=1:numel(vertps)
        vp = vertps(vi);
        ep = edgeps(ei);
        switch method
            case {'multi','multimodal'}
                [row(vi),scorelist,fracs] = ...
                    recovery_experiment_multimodal(n,d,m,ntrials,vp,ep);
            otherwise
                [row(vi),scorelist,fracs] = ...
                    recovery_experiment_pairwise(method,n,d,m,ntrials,vp,ep);
        end
        scores{vi} = scorelist;
        F(ei,vi,:) = fracs;
    end
    X(ei,:) = row;
    Mscores(ei,:) = scores;
end


result.n = n;
result.d = d;
result.m = m;
result.vertps = vertps;
result.edgeps = edgeps;
result.method = method;
result.ntrials = ntrials;
result.F = F;
result.X = X;
result.scores = Mscores;
