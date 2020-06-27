function [ fis_Recrutamento, out ] = Recrutamento(mediaCustoContrato, mediaTmpProcessoEmpTemporario, mediaTmpProcessoEmpDefinitivo, mf )
    
    %PASSO 1: crie a estrutura FIS de nome fis_Recrutamento
    %%mamdani default gang
    fis_Recrutamento = newfis('fis_Recrutamento');
    
    %input
    %|5|---|20-28|---|40|---|55-60|---|75|
    baixo = 5; alto = 75; offset = (28);
    fis_Recrutamento=addvar(fis_Recrutamento,'input','mediaCustoContrato',[baixo alto]);%baixo
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'baixo','trimf',[baixo,baixo,bD]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'medio','trimf',[mE,m,mD]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'alto','trimf',[aE,alto,alto]);
    else%if mf == 2
        oofset = setdiv(offset);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'baixo','gaussmf',[oofset, baixo]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'alto','gaussmf',[oofset, alto]);
    end
    
    %|3|----|30-40-50|---|60|---|80-90-100|---|120|
    baixo = 3; alto = 120; offset = (30);
    fis_Recrutamento=addvar(fis_Recrutamento,'input','mediaTmpProcessoEmpTemporario',[baixo alto]);%baixo
   if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'baixo','trimf',[baixo,baixo,bD]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'medio','trimf',[mE,m,mD]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'alto','trimf',[aE,alto,alto]);
    else%if mf == 2
        oofset = setdiv(offset);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'baixo','gaussmf',[oofset, baixo]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'alto','gaussmf',[oofset, alto]);
    end
    
    %|3|---|22-30-38|---|45|---|52-60-68|--|90|
    baixo = 3; alto = 90; offset = 38;
    fis_Recrutamento=addvar(fis_Recrutamento,'input','mediaTmpProcessoEmpDefinitivo',[baixo alto]);%baixo
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'baixo','trimf',[baixo,baixo,bD]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'medio','trimf',[mE,m,mD]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'alto','trimf',[aE,alto,alto]);
    else%if mf == 2
        oofset = setdiv(offset);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'baixo','gaussmf',[oofset, baixo]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'alto','gaussmf',[oofset, alto]);
    end
    
    %output
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    baixo = 0; alto = 1; offset = (0.38);
    fis_Recrutamento=addvar(fis_Recrutamento,'output', 'Recrutamento', [baixo alto]);%alto
    if mf == 1
         [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'baixo','trimf',[baixo,baixo,bD]);
        fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'medio','trimf',[mE,m,mD]);
        fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'alto','trimf',[aE,alto,alto]);
    else%if mf == 2 %gaussmf
        oofset = setdiv(offset);
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
