function [topK_vec, global_compCount] = ...
    activeRank_topK(n, K, GTM, Pij, m, X)

global_compCount = 0;

if K == 1
    %%% Top-1 Ranking
    [a_star, global_compCount] = ...
        activeRank_top1(n, m, X, GTM, Pij, global_compCount);
    
    topK_vec = X(a_star);
    
elseif (K > 1) && (K == round(K))
    %%% Top-K Ranking, K>1
    Pi_K = zeros(K,1); %indices of top-K items
    
    Q = ceil(n/K);
    C = cell(ceil(n/Q) ,1);
    b = zeros(ceil(n/Q) ,1);
    
    W = zeros(size(X));
    table = [sort(X) (1:n)'];
    for ii = 1:n
        W(ii) = table(X(ii)==table(:,1), 2);
    end
    
    for ii = 1:numel(C)
        C(ii) = {X(((ii-1)*Q)+1 : min(ii*Q,n))};
        [local_indx, global_compCount] = activeRank_top1(n, m, ...
            cell2mat(C(ii)), GTM, Pij, global_compCount);
        b(ii) = (ii-1)*Q + local_indx;
    end
    Z = X(b);
    [Z, global_compCount] = ...
        BuildHeap(Z,m,Pij,table,GTM,global_compCount);
    
    overN_vec = max(X)*ones(K,1);
    for ii = 1:K
        Pi_K(ii) = find(Z(1)==X);
        
        jj = ceil(Pi_K(ii)/Q);
        C(jj) = {setdiff(cell2mat(C(jj)), Z(1))};
        
        if ~isempty(cell2mat(C(jj)))
            currentC_size = numel(cell2mat(C(jj)));
            newC = [cell2mat(C(jj)); ...
                (overN_vec(jj)+1 : overN_vec(jj)+(Q-currentC_size))'];
            overN_vec(jj) = overN_vec(jj)+(Q-currentC_size);
            
            [a_star, global_compCount] = ...
                activeRank_top1(n, m, newC, GTM, Pij, global_compCount);
            Z(1) = newC(a_star);
        else
            Z(1) = [];
        end
        [Z, global_compCount] = ...
            BuildHeap(Z,m,Pij,table,GTM,global_compCount);
    end
    topK_vec = X(Pi_K);
else
    error('Invalid choice of K');
end


