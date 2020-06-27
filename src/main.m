function  [ out ] = main(mf)
    warning off
    addpath('./helpers/');
    if ~exist('mf','var')
        mf = 2 ; % 1 - trimf ; 2 - gaussmf
    end
    %%%variaveis
    %valores : 1 - alto ; 2 - medio ; 3 - min
    
    [mediaCustoContrato, mediaTmpProcessoEmpTemporario, mediaTmpProcessoEmpDefinitivo, ...
        mediaCustosPessoal, salarioMedioSCA,salarioMedioCCA, percentBonificacoes, ...
        percentCustoForm, horasForm, horasFormFN1, ...
        percentEmptN1Desistentes, percentEmptOperacionaisDesistentes...
        ] = PreValores(3);
    
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