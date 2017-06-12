function [Z,global_compCount] = ...
    BuildHeap(Z,m,Pij,table,GTM,global_compCount)

for ii = floor(numel(Z)/2):-1:1
    [Z,global_compCount] = ...
        Heapify(Z,m,ii,Pij,table,GTM,global_compCount);
end


