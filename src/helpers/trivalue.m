function [meio, baixoDir, meioEsq, meioDir, altoEsq] = trivalue(alto, baixo, offset)
    meio = ((alto - baixo)/2) + baixo;
    baixoDir = baixo + offset;
    meioEsq = meio - offset;
    meioDir = meio + offset;
    altoEsq = alto - offset;
end