function NEP = NEP_1PredVar_Model(beta,PredVar)

PPFD_gl = PredVar(1,:);

Rd = beta(1);
QuantumYield_gl = beta(2);
Amax = beta(3);

NEP = Amax*QuantumYield_gl*PPFD_gl./(Amax + QuantumYield_gl*PPFD_gl) - Rd;
