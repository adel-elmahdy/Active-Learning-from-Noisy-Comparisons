function Pij = BTL_model(n,K,delta_K,w1)

% clear;clc;
% n = 10; K = 4; delta_K = 0.1; w1 = 100;

w = zeros(n,1); 
w(1) = w1*rand;
% w(1) = w1;
randVec = rand(K,1);
rho = sort((randVec/max(randVec)) * ...
    ((1-2*sqrt(delta_K)) / (1+2*sqrt(delta_K))));
for ii = 2:K+1
    w(ii) = w(ii-1)*rho(ii-1);
end
while(1)
    w(K+2:end) = w(K+1)*rand(n-K-1,1);
    if w(K+2:end) < w(K+1)
        w(K+2:end) = sort(w(K+2:end),'descend');
        break
    end
end

% check = ((w(K)-w(K+1)) / (2*(w(K)+w(K+1)))).^2

Pij = cell(n,1);
for ii = 1:n
    Pij(ii) = {w(ii) ./ (w(ii) + w(ii+1:end))};
end


