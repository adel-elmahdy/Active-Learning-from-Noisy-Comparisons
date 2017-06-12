close all;
clear; clc;
tic;

n = 1024;
K = 8; trueRank = 1:K;
m = [1 25:25:300]';
iter_Num = 500;
showComp = 500;

delta_K = 0.0225;
if ~((delta_K>=0) && (delta_K<=0.25))
    error('delta_K range is from 0 to 0.25');
end

GTM = 1;
w1 = 3; % w_max for BTL Model

rankedItems_cell = cell(numel(m),1);
global_compCount_mat = zeros(iter_Num, numel(m));
success_count_mat = zeros(iter_Num, numel(m));
sucess_rate_vec = zeros(size(m));
global_compCount_vec = zeros(size(m));

for ll = 1:numel(m)
    topK_mat = zeros(iter_Num, K);
    global_compCount = zeros(iter_Num, 1);
    for kk = 1:iter_Num
        if mod(kk,showComp)==0
            fprintf('Comparison #%d out of %d, Iteration #%d out of %d \n',...
                ll,numel(m),kk,iter_Num);
        end
        
        X = randperm(n)';
        
        Pij = groundTruth_model(GTM,n,K,delta_K,w1);
        
        [topK_vec, global_compCount(kk)] = ...
            activeRank_topK(n, K, GTM, Pij, m(ll), X);
        topK_mat(kk,:) = topK_vec';
    end
    rankedItems_cell(ll) = {topK_mat};
    
    global_compCount_mat(:,ll) = global_compCount;
    global_compCount_vec(ll) = ceil(mean(global_compCount));
    
    success_count = 0;
    for ii = 1:iter_Num
        if sum(sort(topK_mat(ii,:)) == trueRank) == K
            success_count = success_count + 1;
            success_count_mat(ii,ll) = 1;
        end
    end
    succRate = (success_count/iter_Num)*100;
    sucess_rate_vec(ll) = succRate;
end

figure; plot(global_compCount_vec, sucess_rate_vec,'k');
TotalTime = toc %#ok<NOPTS>


