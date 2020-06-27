
function [ fis_Retencao, out ] = Retencao(percentEmptN1Desistentes,percentEmptOperacionaisDesistentes, mf )
    
    %PASSO 1: crie a estrutura FIS de nome fis_Retencao
    %%mamdani default gang
    fis_Retencao = newfis('fis_Retencao');
    
    %inputss
    %|0|---|0.75-1.25-1.75|---|2.5|---|3.25-3.75-4.25|---|5|
    baixo = 0 ; alto = 5 ;offset = 1.75;
    fis_Retencao=addvar(fis_Retencao,'input','percentEmptN1Desistentes',[0 5]);%baixo
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Retencao=addmf(fis_Retencao,'input',1,'baixo','trimf',[baixo,baixo,bD]); 
        fis_Retencao=addmf(fis_Retencao,'input',1,'medio','trimf',[mE,m,mD]);
        fis_Retencao=addmf(fis_Retencao,'input',1,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_Retencao=addmf(fis_Retencao,'input',1,'baixo','gaussmf',[oofset, baixo]);
        fis_Retencao=addmf(fis_Retencao,'input',1,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Retencao=addmf(fis_Retencao,'input',1,'alto','gaussmf',[oofset, alto]);
    end
    %|0|---|1.75-3.75-5.75|---|7.5|---|9.25-11.25-13.25|---|15|
    baixo = 0 ; alto = 15 ; offset = 5.75;
    fis_Retencao=addvar(fis_Retencao,'input','percentEmptOperacionaisDesistentes',[0 15]);%baixo
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Retencao=addmf(fis_Retencao,'input',2,'baixo','trimf',[baixo,baixo,bD]); 
        fis_Retencao=addmf(fis_Retencao,'input',2,'medio','trimf',[mE,m,mD]);
        fis_Retencao=addmf(fis_Retencao,'input',2,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_Retencao=addmf(fis_Retencao,'input',2,'baixo','gaussmf',[oofset, baixo]);
        fis_Retencao=addmf(fis_Retencao,'input',2,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Retencao=addmf(fis_Retencao,'input',2,'alto','gaussmf',[oofset, alto]);
    end
    
    %output
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    baixo = 0; alto = 1; offset = (0.38);
    fis_Retencao=addvar(fis_Retencao,'output', 'Retencao', [baixo alto]);
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Retencao=addmf(fis_Retencao,'output',1,'baixo','trimf',[baixo,baixo,bD]); 
        fis_Retencao=addmf(fis_Retencao,'output',1,'medio','trimf',[mE,m,mD]);
        fis_Retencao=addmf(fis_Retencao,'output',1,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_Retencao=addmf(fis_Retencao,'output',1,'baixo','gaussmf',[oofset, baixo]);
        fis_Retencao=addmf(fis_Retencao,'output',1,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Retencao=addmf(fis_Retencao,'output',1,'alto','gaussmf',[oofset, alto]);
    end
    
    regras = [
        1 1 3 1 2
        2 2 2 1 2
        3 3 1 1 2
        ];
    
    fis_Retencao = addrule(fis_Retencao, regras);
    
    entrada = [percentEmptN1Desistentes,percentEmptOperacionaisDesistentes];
    
    out = evalfis(entrada, fis_Retencao);
    
end
