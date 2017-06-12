function [T,global_compCount] = ...
    Compare(T, zz1, zz2, m, Pij, table, GTM, global_compCount)

a = table(zz1==table(:,1), 2);
b = table(zz2==table(:,1), 2);
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


