function Weights = randweight(L_in, L_out)








random_initialisation=0.17;

Weights = rand(L_out, 1 + L_in) * 2 * random_initialisation - random_initialisation;




end
