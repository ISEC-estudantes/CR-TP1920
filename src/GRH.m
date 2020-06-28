function [ fis_GRH, out ] = GRH(recrutamento, retribuicao, formacao, retencao, mf)
    
    fis_GRH = newfis('fis_GRH');
    offsets = getOffsets();
    baixo = 0; alto = 1; 
    %%input
    fis_GRH=addvar(fis_GRH,'input','recrutamento',[0 1]);%alto
    fis_GRH=addvar(fis_GRH,'input','retribuicao',[0 1]);%alto
    fis_GRH=addvar(fis_GRH,'input','formacao',[0 1]);%alto
    fis_GRH=addvar(fis_GRH,'input','retencao',[0 1]);%alto
    
    %output
    fis_GRH=addvar(fis_GRH,'output','grh',[0 1]);%alto
    
    %inputs
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    offset = offsets(4);
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_GRH=addmf(fis_GRH,'input',1,'baixo','trimf',[baixo,baixo,bD]);
        fis_GRH=addmf(fis_GRH,'input',1,'medio','trimf',[mE,m,mD]);
        fis_GRH=addmf(fis_GRH,'input',1,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(0.38);
        fis_GRH=addmf(fis_GRH,'input',1,'baixo','gaussmf',[oofset baixo]);
        fis_GRH=addmf(fis_GRH,'input',1,'medio','gaussmf',[oofset calcMeio(baixo, alto)]);
        fis_GRH=addmf(fis_GRH,'input',1,'alto','gaussmf',[oofset alto]);
    end
    
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    offset = offsets(9);
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_GRH=addmf(fis_GRH,'input',2,'baixo','trimf',[baixo,baixo,bD]);
        fis_GRH=addmf(fis_GRH,'input',2,'medio','trimf',[mE,m,mD]);
        fis_GRH=addmf(fis_GRH,'input',2,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_GRH=addmf(fis_GRH,'input',2,'baixo','gaussmf',[oofset baixo]);
        fis_GRH=addmf(fis_GRH,'input',2,'medio','gaussmf',[oofset calcMeio(baixo, alto)]);
        fis_GRH=addmf(fis_GRH,'input',2,'alto','gaussmf',[oofset alto]);
    end
    
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
   offset = offsets(13);
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_GRH=addmf(fis_GRH,'input',3,'baixo','trimf',[baixo,baixo,bD]);
        fis_GRH=addmf(fis_GRH,'input',3,'medio','trimf',[mE,m,mD]);
        fis_GRH=addmf(fis_GRH,'input',3,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_GRH=addmf(fis_GRH,'input',3,'baixo','gaussmf',[oofset baixo]);
        fis_GRH=addmf(fis_GRH,'input',3,'medio','gaussmf',[oofset calcMeio(baixo, alto)]);
        fis_GRH=addmf(fis_GRH,'input',3,'alto','gaussmf',[oofset alto]);
    end
    
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    offset = offsets(16);
    if mf == 1
        [m, bD,mE,mD, aE] = trivalue(alto, baixo, offset);
        fis_GRH=addmf(fis_GRH,'input',4,'baixo','trimf',[baixo,baixo,bD]);
        fis_GRH=addmf(fis_GRH,'input',4,'medio','trimf',[mE,m,mD]);
        fis_GRH=addmf(fis_GRH,'input',4,'alto','trimf',[aE,alto,alto]);
    else
        oofset = setdiv(offset);
        fis_GRH=addmf(fis_GRH,'input',4,'baixo','gaussmf',[oofset baixo]);
        fis_GRH=addmf(fis_GRH,'input',4,'medio','gaussmf',[oofset calcMeio(baixo, alto)]);
        fis_GRH=addmf(fis_GRH,'input',4,'alto','gaussmf',[oofset alto]);
    end
    
    %output
    %|0|---|-0.125-|---|0.25|---|-0.375-|---|0.5|---|-0.625-|---|0.75|---|-0.875-|---|1|
    offset = offsets(17);
    if mf == 1
         [bD, sE, s, sD, tE, t, tD, qE, q, qD, aE] = quintvalue(alto, baixo, offset);
        fis_GRH=addmf(fis_GRH,'output',1,'mau','trimf',[baixo, baixo, bD]);
        fis_GRH=addmf(fis_GRH,'output',1,'meiocre','trimf',[sE,s,sD]);
        fis_GRH=addmf(fis_GRH,'output',1,'suficiente','trimf',[ tE, t, tD]);
        fis_GRH=addmf(fis_GRH,'output',1,'bom','trimf',[qE, q, qD]);
        fis_GRH=addmf(fis_GRH,'output',1,'muito bom','trimf',[aE, alto, alto]);
    else
        oofset = setdiv(offset);
        fis_GRH=addmf(fis_GRH,'output',1,'mau','gaussmf',[oofset 0]);
        fis_GRH=addmf(fis_GRH,'output',1,'meiocre','gaussmf',[oofset 0.25]);
        fis_GRH=addmf(fis_GRH,'output',1,'suficiente','gaussmf',[oofset 0.5]);
        fis_GRH=addmf(fis_GRH,'output',1,'bom','gaussmf',[oofset 0.75]);
        fis_GRH=addmf(fis_GRH,'output',1,'muito bom','gaussmf',[oofset 1]);
    end
    
    regras = [
        1 1 1 1 1 1 2
        2 2 2 2 3 1 2
        3 3 3 3 5 1 2
        ];
    
    fis_GRH = addrule(fis_GRH, regras);
    entrada = [ recrutamento retribuicao formacao retencao ];
    out = evalfis(entrada, fis_GRH);
    
end
