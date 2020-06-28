
%O main é onde se executa a executa a implementação completa do sistema, como já foi dito anteriormente, 
%não existe interface, deve se editar os ficheiros do programa para se editar os valores pretendidos que não sejam o default.

%%Argumentos
%Podem ser metidos 2 argumentos opcionais no main
function  [ out ] = main(mf, valores)

%mf
%E o primeiro argumento e serve para escolher que função a utilizar
%Default => gaussmf
%   1 => trimf
%   2 ou outro => gaussmf
    warning off
    addpath('./helpers/');
    if ~exist('mf','var')
        mf = 2 ; % 1 - trimf ; 2 - gaussmf
    end
    
%valores
%E o segundo argumento e serve para selecionar os valores de input das várias outras funções, passa o argumento dado para o PreValores
%Default => faz set aos valores para ter os valores melhores possíveis
%   1 => o mesmo que o Default
%   2 => faz set aos valores para ter resultados valores médios
%   3 => faz set aos valores para ter resultados valores mínimos
%   4 ou outros => extra para definir e personalizar
    if ~exist('valores', 'var')
        valores = 1;
    end
    %%%variaveis
    %valores : 1 - alto ; 2 - medio ; 3 - min
    
    [mediaCustoContrato, mediaTmpProcessoEmpTemporario, mediaTmpProcessoEmpDefinitivo, ...
        mediaCustosPessoal, salarioMedioSCA,salarioMedioCCA, percentBonificacoes, ...
        percentCustoForm, horasForm, horasFormFN1, ...
        percentEmptN1Desistentes, percentEmptOperacionaisDesistentes...
        ] = PreValores(valores);
    
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
    %fuzzy(fis_GRH)
end
