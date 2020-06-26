function  [ out ] = main()

%%%variaveis

%recrutamento
mediaCustoContrato =  0 %[ 5 , 75 ]
mediaTmpProcessoEmpTemporario = 0 %[ 3 , 120 ]
mediaTmpProcessoEmpDefinitivo = %[ 3 , 90 ]

%retribuicao
mediaCustosPessoal = % [ 0 , 45 ]
salarioMedioSCA = % [400 , 1300 ]
salarioMedioCCA = % [ 700 , 1800 ]
percentBonificacoes = % [ 0 , 25 ]

%formacao
percentCustoForm = % [ 0 , 5 ]
horasForm = % [ 0 , 45 ]
horasFormFN1 = % [ 0 , 100]

%retencao
percentEmptN1Desistentes = % [ 0 , 5 ]
percentEmptOperacionaisDesistentes = % [ 0 , 15 ]

[~, recrutamento] = Recrutamento(mediaCustoContrato, mediaTmpProcessoEmpTemporario, mediaTmpProcessoEmpDefinitivo );
[~, retribuicao] = Retribuicao( mediaCustosPessoal, salarioMedioSCA, salarioMedioCCA, percentBonificacoes);
[~, formacao] = Formacao(percentCustoForm, horasForm, horasFormFN1);
[~, retencao] = Retencao(percentEmptN1Desistentes, percentEmptOperacionaisDesistentes);


[~ , ghr] = GRH(recrutamento, retribuicao, formacao. retencao);
display("Big chungs value : "+ ghr)
