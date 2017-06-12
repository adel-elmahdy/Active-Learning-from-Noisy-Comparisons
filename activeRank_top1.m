function [a_star, global_compCount] = ...
    activeRank_top1(n,m,X,GTM,Pij, global_compCount)

input_X = X;
n_locl = numel(X);

W = X;

for ii = 1:ceil(log2(n_locl))
    n_locl = numel(W);
    if mod(n_locl,2) == 0
        loopIter = n_locl/2;
    else
        loopIter = (n_locl-1)/2;
    end
    for jj = 1:loopIter
        a = W(2*jj-1);
        b = W(2*jj);
        T = 0;
        if (a > n) || (b > n)
            W(jj) = min(a,b);
        else
            for tt = 1:m
                randVar = rand;
                if (GTM == 1) || (GTM == 2)
                    if a < b
                        Y_tt = (randVar <= Pij{a}(b-a));
                        global_compCount = global_compCount + 1;
                    elseif a > b
                        Y_tt = (randVar <= (1- Pij{b}(a-b)));
                        global_compCount = global_compCount + 1;
                    else
                        error('Indexing Error');
                    end
                elseif (GTM == 3) || (GTM == 4)
                    if a < b
                        Y_tt = (randVar <= Pij);
                        global_compCount = global_compCount + 1;
                    elseif a > b
                        Y_tt = (randVar <= (1-Pij));
                        global_compCount = global_compCount + 1;
                    else
                        error('Indexing Error');
                    end
                end
                T = T + Y_tt;
            end
            if T >= m/2
                W(jj) = a;
            else
                W(jj) = b;
            end
        end
    end
    if mod(n_locl,2) == 0
        W = W(1:loopIter);
    else
        W = [W(1:loopIter); W(end)];
    end
end

% a_star = find(input_X == table(W(1)==table(:,2), 1));
a_star = find(input_X == W(1));


