function [meio, baixoDir, meioEsq, meioDir, altoEsq] = trivalue(alto, baixo, oofset)
    meio = ((alto - baixo)/2) + baixo;
    baixoDir = baixo + oofset;
    meioEsq = meio - oofset;
    meioDir = meio + oofset;
    altoEsq = alto - oofset;
end