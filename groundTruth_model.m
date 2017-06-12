function Pij = groundTruth_model(GTM,n,K,delta_K,w1)

if GTM == 1
    Pij = BTL_model(n,K,delta_K,w1);
elseif GTM == 2
    Pij = SSST_model(n,K,delta_K);
elseif GTM == 3
    Pij = unifNoise_model(delta_K);
elseif GTM == 4
    Pij = noiseless_model;
else
    error('Invalid choice of Ground-Truth Model');
end


