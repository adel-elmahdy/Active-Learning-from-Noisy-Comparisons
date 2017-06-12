function Pij = SSST_model(n,K,delta_K)

% clear;clc;
% n = 10; K = 4; delta_K = 0.1;

Pij = cell(n,1);

randVec = rand(1, n*K + 0.5*n*(n-1));
randVec = 1 - ((randVec / max(randVec)) * (0.5 - sqrt(delta_K)));

indxTrack = 1;
for ii = 1:K
    Pij(ii) = {randVec(indxTrack : indxTrack+(n-ii-1))};
    indxTrack = indxTrack+(n-ii-1) + 1; 
end

for ii = K+1:n-1
    while(1)
        randVar = 0.5 + (1-0.5)*rand(1,n-ii);
        if randVar > 0.5
            Pij(ii) = {randVar};
            break
        end
    end
end
Pij(n) = {[]};

% check = min((randVec-0.5).^2) %#ok<NOPTS>


