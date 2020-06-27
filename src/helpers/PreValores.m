function [mediaCustoContrato, mediaTmpProcessoEmpTemporario, mediaTmpProcessoEmpDefinitivo, ...
        mediaCustosPessoal, salarioMedioSCA,salarioMedioCCA, percentBonificacoes, ...
        percentCustoForm, horasForm, horasFormFN1, ...
        percentEmptN1Desistentes, percentEmptOperacionaisDesistentes...
        ] = PreValores(valores)
    %valores:  1 - max; 2 - medio; 3 - min;
    
    if valores == 1
        %recrutamento
        mediaCustoContrato =  5 ; %[ 5 , 75 ] -> Objetivo: Baixo
        mediaTmpProcessoEmpTemporario = 3 ; %[ 3 , 120 ] -> Objetivo: Baixo
        mediaTmpProcessoEmpDefinitivo = 3 ; %[ 3 , 90 ] -> Objetivo: Baixo
        
        %retribuicao
        mediaCustosPessoal = 0 ; % [ 0 , 45 ] -> Objetivo: Baixo
        salarioMedioSCA =400 ; % [400 , 1300 ] -> Objetivo: Baixo
        salarioMedioCCA = 700; % [ 700 , 1800 ] -> Objetivo: Baixo
        percentBonificacoes = 25 ; % [ 0 , 25 ] -> Objetivo: Alto
        
        %formacao
        percentCustoForm = 2.5 ; % [ 0 , 5 ] -> Objetivo: Médio
        horasForm = 22.5 ; % [ 0 , 45 ] -> Objetivo: Médio
        horasFormFN1 = 100 ; % [ 0 , 100] -> Objetivo: Alto
        
        %retencao
        percentEmptN1Desistentes = 0 ; % [ 0 , 5 ] -> Objetivo: Baixo
        percentEmptOperacionaisDesistentes = 0 ; % [ 0 , 15 ] -> Objetivo: Baixo
        
    elseif valores == 2
        %recrutamento
        mediaCustoContrato =  40 ; %[ 5 , 75 ] -> Objetivo: Baixo
        mediaTmpProcessoEmpTemporario = 61.5000 ; %[ 3 , 120 ] -> Objetivo: Baixo
        mediaTmpProcessoEmpDefinitivo = 46.5000 ; %[ 3 , 90 ] -> Objetivo: Baixo
        
        %retribuicao
        mediaCustosPessoal = 22.5 ; % [ 0 , 45 ] -> Objetivo: Baixo
        salarioMedioSCA = 850 ; % [400 , 1300 ] -> Objetivo: Baixo
        salarioMedioCCA = 1250 ; % [ 700 , 1800 ] -> Objetivo: Baixo
        percentBonificacoes = 12.5 ; % [ 0 , 25 ] -> Objetivo: Alto
        
        %formacao
        percentCustoForm = 3.75 ; % [ 0 , 5 ] -> Objetivo: Médio
        horasForm = 33.7500 ; % [ 0 , 45 ] -> Objetivo: Médio
        horasFormFN1 = 50 ; % [ 0 , 100] -> Objetivo: Alto
        
        %retencao
        percentEmptN1Desistentes = 2.5 ; % [ 0 , 5 ] -> Objetivo: Baixo
        percentEmptOperacionaisDesistentes = 7.5 ; % [ 0 , 15 ] -> Objetivo: Baixo
        
    elseif valores == 3
        %recrutamento
        mediaCustoContrato =  75 ; %[ 5 , 75 ] -> Objetivo: Baixo
        mediaTmpProcessoEmpTemporario = 120 ; %[ 3 , 120 ] -> Objetivo: Baixo
        mediaTmpProcessoEmpDefinitivo = 90 ; %[ 3 , 90 ] -> Objetivo: Baixo
        
        %retribuicao
        mediaCustosPessoal = 45 ; % [ 0 , 45 ] -> Objetivo: Baixo
        salarioMedioSCA =1300 ; % [400 , 1300 ] -> Objetivo: Baixo
        salarioMedioCCA = 1800; % [ 700 , 1800 ] -> Objetivo: Baixo
        percentBonificacoes = 0 ; % [ 0 , 25 ] -> Objetivo: Alto
        
        %formacao
        percentCustoForm = 0 ; % [ 0 , 5 ] -> Objetivo: Médio
        horasForm = 45 ; % [ 0 , 45 ] -> Objetivo: Médio
        horasFormFN1 = 0 ; % [ 0 , 100] -> Objetivo: Alto
        
        %retencao
        percentEmptN1Desistentes = 5 ; % [ 0 , 5 ] -> Objetivo: Baixo
        percentEmptOperacionaisDesistentes = 15 ; % [ 0 , 15 ] -> Objetivo: Baixo
    else
        %recrutamento
        mediaCustoContrato =  75 ; %[ 5 , 75 ] -> Objetivo: Baixo
        mediaTmpProcessoEmpTemporario = 120 ; %[ 3 , 120 ] -> Objetivo: Baixo
        mediaTmpProcessoEmpDefinitivo = 90 ; %[ 3 , 90 ] -> Objetivo: Baixo
        
        %retribuicao
        mediaCustosPessoal = 45 ; % [ 0 , 45 ] -> Objetivo: Baixo
        salarioMedioSCA =1300 ; % [400 , 1300 ] -> Objetivo: Baixo
        salarioMedioCCA = 1800; % [ 700 , 1800 ] -> Objetivo: Baixo
        percentBonificacoes = 0 ; % [ 0 , 25 ] -> Objetivo: Alto
        
        %formacao
        percentCustoForm = 0 ; % [ 0 , 5 ] -> Objetivo: Médio
        horasForm = 45 ; % [ 0 , 45 ] -> Objetivo: Médio
        horasFormFN1 = 0 ; % [ 0 , 100] -> Objetivo: Alto
        
        %retencao
        percentEmptN1Desistentes = 5 ; % [ 0 , 5 ] -> Objetivo: Baixo
        percentEmptOperacionaisDesistentes = 15 ; % [ 0 , 15 ] -> Objetivo: Baixo
    end
end