function [offsets] = getOffsets()
    offsets = [
    %recrutamento
    28 ,...     %mediaCustoContrato 1
    50,...      %mediaTmpProcessoEmpTemporario 2
    38,...      %mediaTmpProcessoEmpDefinitivo 3
    0.38,...    %recrutamento 4
    ...
    ...%retribuicao
    14,...      %mediaCustosPessoal 5
    300,...     %salarioMedioSCA 6
    125,...     %salarioMedioCCA 7
    11,...      %percentBonificacoes 8
    0.38,...    %retibuicao 9
    ...
    ...%formacao
    1.30,...    %percentCustoForm 10
    14,...      %horasForm 11
    38,...      %horasFormFN1 12
    0.38,...    %Formacao 13
    ...
    ...%retencao
    1.75,...    %percentEmptN1Desistentes 14
    5.75,...    %percentEmptOperacionaisDesistentes 15
    0.38,...    %Retencao 16
    ...
    0.2    %GRH 17
    ];
end