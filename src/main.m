function  [ out ] = main(mf)
    warning off
    %addpath('./gauss/');
    if ~exist('mf','var')
    mf = 2 ; % 1 - trimf ; 2 - gaussmf
    end
    %%%variaveis
    
    %recrutamento
    mediaCustoContrato =  5 ; %[ 5 , 75 ] -> Objetivo: Baixo
    mediaTmpProcessoEmpTemporario = 3 ; %[ 3 , 120 ] -> Objetivo: Baixo
    mediaTmpProcessoEmpDefinitivo = 3 ; %[ 3 , 90 ] -> Objetivo: Baixo
    
    %retribuicao
    mediaCustosPessoal = 0 ; % [ 0 , 45 ] -> Objetivo: Baixo
    salarioMedioSCA = 400 ; % [400 , 1300 ] -> Objetivo: Baixo
    salarioMedioCCA = 700 ; % [ 700 , 1800 ] -> Objetivo: Baixo
    percentBonificacoes = 25 ; % [ 0 , 25 ] -> Objetivo: Alto
    
    %formacao
    percentCustoForm = 2.5 ; % [ 0 , 5 ] -> Objetivo: Médio
    horasForm = 23 ; % [ 0 , 45 ] -> Objetivo: Médio
    horasFormFN1 = 100 ; % [ 0 , 100] -> Objetivo: Alto
    
    %retencao
    percentEmptN1Desistentes = 0 ; % [ 0 , 5 ] -> Objetivo: Baixo
    percentEmptOperacionaisDesistentes = 0 ; % [ 0 , 15 ] -> Objetivo: Baixo
    
    [~, recrutamento] = Recrutamento(mediaCustoContrato, mediaTmpProcessoEmpTemporario, mediaTmpProcessoEmpDefinitivo, mf );
    [~, retribuicao] = Retribuicao( mediaCustosPessoal, salarioMedioSCA, salarioMedioCCA, percentBonificacoes, mf );
    [~, formacao] = Formacao(percentCustoForm, horasForm, horasFormFN1, mf );
    [~, retencao] = Retencao(percentEmptN1Desistentes, percentEmptOperacionaisDesistentes, mf );
    
    
    [fis_GRH , grh] = GRH(recrutamento, retribuicao, formacao, retencao, mf);
    if mf == 1
        typeofFunc = "trimf";
        
    else
        typeofFunc = "gaussmf";
        
    end
    
    if grh < 0.125
        nivel = "Mau";
    elseif grh < 0.375
        nivel = "Mediocre";
    elseif grh < 0.625
        nivel = "Suficiente";
    elseif grh < 0.875
        nivel = "Bom";
    else
        nivel = "Muito Bom";
    end
    
    display("Resultado["+grh+"]["+typeofFunc+"]: "+ nivel)
    
    display("Recrutamento: " + recrutamento)
    display("Retribuicao: " + retribuicao)
    display("Formacao: " + formacao )
    display("Retencao: " + retencao)
end