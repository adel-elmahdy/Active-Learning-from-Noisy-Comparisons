function [Z,global_compCount] = ...
    Heapify(Z,m,ii,Pij,table,GTM,global_compCount)

left = 2*ii;
right = 2*ii + 1;

T = 0;
if left <= numel(Z)
    [T,global_compCount] = ...
        Compare(T, Z(left), Z(ii), m, Pij, table, GTM, global_compCount);
end

if (left <= numel(Z)) && (T >= m/2)
    max = left;
else
    max = ii;
end

T = 0;
if right <= numel(Z)
    [T,global_compCount] = ...
        Compare(T, Z(right), Z(max), m, Pij, table, GTM, global_compCount);
end

if (right <= numel(Z)) && (T >= m/2)
    max = right;
end

if max ~= ii
    swapVar = Z(ii);
    Z(ii) = Z(max);
    Z(max) = swapVar;
    [Z,global_compCount] = ...
        Heapify(Z,m,max,Pij,table,GTM,global_compCount);
end


