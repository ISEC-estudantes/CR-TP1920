function [ fis_Formacao, out ] = Formacao(percentCustoForm, horasForm, horasFormFN1, mf)
    
    %PASSO 1: crie a estrutura FIS de nome fis_Formacao
    %%mamdani default gang
    fis_Formacao = newfis('fis_Formacao'); %#ok<*FISNEW>
    offsets = getOffsets();
    %input
    %|0|---|0.75-1.25-1.75|---|2.5|---|3.25-3.75-4.25|---|5|
    baixo = 0 ; alto = 5; offset = offsets(10);
    fis_Formacao=addvar(fis_Formacao,'input','percentCustoForm',[baixo alto]);%medio
   
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Formacao=addmf(fis_Formacao,'input',1,'baixo','trimf',[baixo,baixo,bD]); %#ok<*FISADM>
        fis_Formacao=addmf(fis_Formacao,'input',1,'medio','trimf',[mE,m,mD]);
        fis_Formacao=addmf(fis_Formacao,'input',1,'alto','trimf',[aE,alto,alto]);
    else%if mf == 2 
        oofset = setdiv(offset);
        fis_Formacao=addmf(fis_Formacao,'input',1,'baixo','gaussmf',[oofset, baixo]); %#ok<*FISADM>
        fis_Formacao=addmf(fis_Formacao,'input',1,'medio','gaussmf',[oofset,calcMeio(baixo, alto)]);
        fis_Formacao=addmf(fis_Formacao,'input',1,'alto','gaussmf',[oofset, alto]);
    end
    
    %|0|---|6.25-11.25-16.25|---|22.5|---|28.75-33.75-38.75|---|45|
    baixo = 0; alto = 45; offset = offsets(11);
    fis_Formacao=addvar(fis_Formacao,'input','horasForm',[baixo, alto]);%medio
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Formacao=addmf(fis_Formacao,'input',2,'baixo','trimf',[baixo,baixo,bD]); %#ok<*FISADM>
        fis_Formacao=addmf(fis_Formacao,'input',2,'medio','trimf',[mE,m,mD]);
        fis_Formacao=addmf(fis_Formacao,'input',2,'alto','trimf',[aE,alto,alto]);
    else%if mf == 2 
        oofset = setdiv(offset);
        fis_Formacao=addmf(fis_Formacao,'input',2,'baixo','gaussmf',[oofset, baixo]);
        fis_Formacao=addmf(fis_Formacao,'input',2,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Formacao=addmf(fis_Formacao,'input',2,'alto','gaussmf',[oofset, alto]);
    end
    
    %|0|---|28-33.3333-38|---|50| ---|61-66.66666-71|---|100|
    baixo = 0; alto = 100; offset = offsets(12);
    fis_Formacao=addvar(fis_Formacao,'input','horasFormFN1',[baixo, alto]);%alto
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Formacao=addmf(fis_Formacao,'input',3,'baixo','trimf',[baixo,baixo,bD]);
        fis_Formacao=addmf(fis_Formacao,'input',3,'medio','trimf',[mE,m,mD]);
        fis_Formacao=addmf(fis_Formacao,'input',3,'alto','trimf',[aE,alto,alto]);
    else%if mf == 2
        oofset = setdiv(offset);
        fis_Formacao=addmf(fis_Formacao,'input',3,'baixo','gaussmf',[oofset, baixo]);
        fis_Formacao=addmf(fis_Formacao,'input',3,'medio','gaussmf',[oofset, calcMeio(baixo, alto)]);
        fis_Formacao=addmf(fis_Formacao,'input',3,'alto','gaussmf',[oofset, alto]);
    end
    
    %output
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    baixo = 0; alto = 1; offset = offsets(13);
    fis_Formacao=addvar(fis_Formacao,'output', 'Formacao', [baixo alto]); %#ok<*FISADV>
    if mf == 1%trimf
         [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_Formacao=addmf(fis_Formacao,'output',1,'baixo','trimf',[baixo,baixo,bD]);
        fis_Formacao=addmf(fis_Formacao,'output',1,'medio','trimf',[mE,m,mD]);
        fis_Formacao=addmf(fis_Formacao,'output',1,'alto','trimf',[aE,alto,alto]);
    else%if mf == 2 %gaussmf
        oofset = setdiv(offset);
        fis_Formacao=addmf(fis_Formacao,'output',1,'baixo','gaussmf',[oofset, baixo ]);
        fis_Formacao=addmf(fis_Formacao,'output',1,'medio','gaussmf',[oofset, calcMeio(baixo, alto )]);
        fis_Formacao=addmf(fis_Formacao,'output',1,'alto','gaussmf',[oofset, alto ]);
    end
    
    regras = [
        2 2 0 3 1 2
        1 1 0 1 1 2
        3 3 0 1 1 2
        0 0 3 3 1 1
        0 0 2 2 1 1
        0 0 1 1 1 1
        ];
    
    fis_Formacao = addrule(fis_Formacao, regras); %#ok<*FISADR>
    
    entrada = [percentCustoForm, horasForm, horasFormFN1];
    
    out = evalfis(entrada, fis_Formacao);
    
end
