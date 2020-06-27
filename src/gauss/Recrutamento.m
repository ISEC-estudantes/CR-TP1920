function [ fis_Recrutamento, out ] = Recrutamento(mediaCustoContrato, mediaTmpProcessoEmpTemporario, mediaTmpProcessoEmpDefinitivo, mf )
    
    %PASSO 1: crie a estrutura FIS de nome fis_Recrutamento
    %%mamdani default gang
    fis_Recrutamento = newfis('fis_Recrutamento');
    
    %input
    %|5|---|20-28|---|40|---|55-60|---|75|
    baixo = 5; alto = 75; oofset = setdiv(20);
    fis_Recrutamento=addvar(fis_Recrutamento,'input','mediaCustoContrato',[baixo alto]);%baixo
    if mf == 1
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'baixo','trimf',[5,5,28]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'medio','trimf',[20,40,60]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'alto','trimf',[55,75,75]);
    else
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'baixo','gaussmf',[oofset, baixo]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'alto','gaussmf',[oofset, alto]);
    end
    
    %|3|----|30-40-50|---|60|---|80-90-100|---|120|
    baixo = 3; alto = 120; oofset = setdiv(50);
    fis_Recrutamento=addvar(fis_Recrutamento,'input','mediaTmpProcessoEmpTemporario',[baixo alto]);%baixo
    if mf == 1
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'baixo','trimf',[3,3,50]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'medio','trimf',[30,60,100]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'alto','trimf',[80,120,120]);
    else
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'baixo','gaussmf',[oofset, baixo]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'alto','gaussmf',[oofset, alto]);
    end
    
    %|3|---|22-30-38|---|45|---|52-60-68|--|90|
    baixo = 3; alto = 90; oofset = setdiv(38);
    fis_Recrutamento=addvar(fis_Recrutamento,'input','mediaTmpProcessoEmpDefinitivo',[baixo alto]);%baixo
    if mf == 1
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'baixo','trimf',[3,3,38]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'medio','trimf',[22,45,68]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'alto','trimf',[52,90,90]);
    else
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'baixo','gaussmf',[oofset, baixo]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'alto','gaussmf',[oofset, alto]);
    end
    
    %output
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    baixo = 0; alto = 1; oofset = setdiv(0.38);
    fis_Recrutamento=addvar(fis_Recrutamento,'output', 'Recrutamento', [baixo alto]);%alto
    if mf == 1
        fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'baixo','trimf',[0,0,0.38]);
        fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'medio','trimf',[0.28,0.50,0.71]);
        fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'alto','trimf',[0.61,1.00,1.00]);
    else
        fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'baixo','gaussmf',[oofset, baixo]);
        fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'alto','gaussmf',[oofset, alto]);
    end
    
    %PASSO 4: criar matriz de regras e adicionar com addrule
    regras=[
        %as regras começao com os inputs depois temos os outputs, se a regra da peso ou nao e qual a operacao a fazer 1 para E [AND] e 2 para OU [OR]
        %mediaCustoContrato | mediaTmpProcessoEmpTemporario | mediaTmpProcessoEmpDefinitivo | Recrutamento | peso | operacao
        %1 0 0 3 1 1 % se o custo dos processos de contracao numero de contratos realizados for baixo entao recurtamento é alto
        %2 0 0 2 1 1% se o custo dos processos de contracao numero de contratos realizados for medio entao recurtamento é medio
        %3 0 0 1 1 1 %se o custo dos processos de contracao numero de contratos realizados for alto entao recurtamento é baixo
        1 1 1 3 1 2 % se qualquer um deles for baixo da um recrumento alto
        2 2 2 2 1 2 % se qualquer um deles for medio da um recrumento medio
        3 3 3 1 1 2 % se qualquer um deles for alto da um recrumento baixo
        ];
    
    
    fis_Recrutamento = addrule(fis_Recrutamento, regras);
    
    %PASSO 5: avaliar para v?rios valores de service e comida com evalfis
    
    entrada = [mediaCustoContrato, mediaTmpProcessoEmpTemporario, mediaTmpProcessoEmpDefinitivo];
    
    out = evalfis(entrada, fis_Recrutamento);
    
end
