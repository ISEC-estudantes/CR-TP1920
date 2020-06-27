function [ fis_Retribuicao, out ] = Retribuicao(mediaCustosPessoal, salarioMedioSCA, salarioMedioCCA, percentBonificacoes, mf)
    
    %PASSO 1: crie a estrutura FIS de nome fis_Retribuicao
    %%mamdani default gang
    fis_Retribuicao = newfis('fis_Retribuicao');
    
    %input
    %|0|---|8-11-14|---|23|---|31-34-37|---|45|
    baixo = 0 ; alto = 45; offset = 14;
    fis_Retribuicao=addvar(fis_Retribuicao,'input','mediaCustosPessoal',[0 45]);%baixo
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',1,'baixo','trimf',[baixo,baixo,bD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',1,'medio','trimf',[mE,m,mD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',1,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',1,'baixo','gaussmf',[oofset, baixo]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',1,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',1,'alto','gaussmf',[oofset, alto]);
    end
    
    %|400|---|600-700-800|---|850|---|900-1000-1100|---|1300|
    baixo = 400 ; alto = 1300; offset = 300;
    fis_Retribuicao=addvar(fis_Retribuicao,'input','salarioMedioSCA',[400 1300]);%baixo
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',2,'baixo','trimf',[baixo,baixo,bD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',2,'medio','trimf',[mE,m,mD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',2,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',2,'baixo','gaussmf',[oofset, baixo]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',2,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',2,'alto','gaussmf',[oofset, alto]);
    end
    
    %|700|---|925-975-1025|---|1250|---|1475-1525-1575|---|1800|
    baixo = 0 ; alto = 1800; offset =(1025 - 900);
    fis_Retribuicao=addvar(fis_Retribuicao,'input','salarioMedioCCA',[700 1800]);%baixo
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',3,'baixo','trimf',[baixo,baixo,bD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',3,'medio','trimf',[mE,m,mD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',3,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',3,'baixo','gaussmf',[oofset, baixo]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',3,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',3,'alto','gaussmf',[oofset, alto]);
    end
    
    %|0|---|5-7-9|---|13|---|16-18-20|---|25|
    baixo = 0 ; alto = 25; offset = (11);
    fis_Retribuicao=addvar(fis_Retribuicao,'input','percentBonificacoes',[0 25]);%alto
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',4,'baixo','trimf',[baixo,baixo,bD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',4,'medio','trimf',[mE,m,mD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',4,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',4,'baixo','gaussmf',[oofset, baixo]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',4,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Retribuicao=addmf(fis_Retribuicao,'input',4,'alto','gaussmf',[oofset, alto]);
    end
    %output
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    baixo = 0; alto = 1; offset = (0.38);
    fis_Retribuicao=addvar(fis_Retribuicao,'output', 'Retribuicao', [baixo alto]);
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'output',1,'baixo','trimf',[baixo,baixo,bD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'output',1,'medio','trimf',[mE,m,mD]);
        fis_Retribuicao=addmf(fis_Retribuicao,'output',1,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_Retribuicao=addmf(fis_Retribuicao,'output',1,'baixo','gaussmf',[oofset, baixo]);
        fis_Retribuicao=addmf(fis_Retribuicao,'output',1,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Retribuicao=addmf(fis_Retribuicao,'output',1,'alto','gaussmf',[oofset, alto]);
    end
    
    regras = [
        1 1 1 0 3 1 2
        2 2 2 0 2 1 2
        3 3 3 0 1 1 2
        0 0 0 1 1 1 1
        0 0 0 2 2 1 1
        0 0 0 3 3 1 1
        ];
    
    fis_Retribuicao = addrule(fis_Retribuicao, regras);
    
    entrada = [mediaCustosPessoal, salarioMedioSCA, salarioMedioCCA, percentBonificacoes];
    
    out = evalfis(entrada, fis_Retribuicao);
end
