function result = adding_modes_experiment(n,d,vp,ep,mmax,ntrials,method)
% Run just one experiment for the adding modes study.

Z = zeros(mmax,1);
Mscores = cell(mmax,1);
F = zeros(ntrials,mmax);
parfor m=1:mmax
    fracs = [];
    switch method
        case 'multi'
            [Z(m), Mscores{m},fracs] = recovery_experiment_multimodal(n,d,m,ntrials,vp,ep);
        
        otherwise
            [Z(m), Mscores{m},fracs] = recovery_experiment_pairwise(method,n,d,m,ntrials,vp,ep);
    end
    F(:,m) = fracs;
end

result.n = n;
result.d = d;
result.vp = vp;
result.ep = ep;
result.mmax = mmax;
result.method = method;
result.Z = Z;
result.scores = Mscores;
result.F = F;