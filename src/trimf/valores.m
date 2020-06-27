function [meio, baixoDireita, meioEsquerda, meioDireita, altoEsquerda]= valores(baixo, alto , range)
    meio = ((alto-baixo) / 2)+baixo;
    diff = (meio - baixo) / 2 + range;
    baixoDireita =  diff + baixo;
    meioEsquerda = meio - diff;
%    -----|-----------|-------------------|
%         baixo = 5   baixoDireita = 8     meio = 10
    
    meioDireita = meio + diff;
    altoEsquerda = alto - diff;
end