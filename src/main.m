function  [ out ] = main()
warning off
  addpath('./trimf/');

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

[~, recrutamento] = Recrutamento(mediaCustoContrato, mediaTmpProcessoEmpTemporario, mediaTmpProcessoEmpDefinitivo );
[~, retribuicao] = Retribuicao( mediaCustosPessoal, salarioMedioSCA, salarioMedioCCA, percentBonificacoes);
[~, formacao] = Formacao(percentCustoForm, horasForm, horasFormFN1);
[~, retencao] = Retencao(percentEmptN1Desistentes, percentEmptOperacionaisDesistentes);


[fis_GHR , ghr] = GRH(recrutamento, retribuicao, formacao, retencao);

display("Big chungs value : " )
if ghr < 0.125
  display("Mau")
elseif ghr < 0.375
    display("Mediocre")
elseif ghr < 0.625
    display("Suficiente")
elseif ghr < 0.875
    display("Bom")
else
    display("Muito Bom")
end
