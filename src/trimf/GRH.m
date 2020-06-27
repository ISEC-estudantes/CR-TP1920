function [ fis_GRH, out ] = GRH(recrutamento, retribuicao, formacao, retencao)
    
    fis_GRH = newfis('fis_GRH');
    
    %%input
    fis_GRH=addvar(fis_GRH,'input','recrutamento',[0 100]);%alto
    fis_GRH=addvar(fis_GRH,'input','retribuicao',[0 100]);%alto
    fis_GRH=addvar(fis_GRH,'input','formacao',[0 100]);%alto
    fis_GRH=addvar(fis_GRH,'input','retencao',[0 100]);%alto
    
    %output
    fis_GRH=addvar(fis_GRH,'output','ghr',[0 100]);%alto
    
    %inputs
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    fis_GRH=addmf(fis_GRH,'input',1,'baixo','trimf',[0,0,38]);
    fis_GRH=addmf(fis_GRH,'input',1,'medio','trimf',[28,50,71]);
    fis_GRH=addmf(fis_GRH,'input',1,'alto','trimf',[61,100,100]);
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    fis_GRH=addmf(fis_GRH,'input',2,'baixo','trimf',[0,0,38]);
    fis_GRH=addmf(fis_GRH,'input',2,'medio','trimf',[28,50,71]);
    fis_GRH=addmf(fis_GRH,'input',2,'alto','trimf',[61,100,100]);
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    fis_GRH=addmf(fis_GRH,'input',3,'baixo','trimf',[0,0,38]);
    fis_GRH=addmf(fis_GRH,'input',3,'medio','trimf',[28,50,71]);
    fis_GRH=addmf(fis_GRH,'input',3,'alto','trimf',[61,100,100]);
    %|0|---|28-33-38|---|50| ---|61-66-71|---|100|
    fis_GRH=addmf(fis_GRH,'input',4,'baixo','trimf',[0,0,38]);
    fis_GRH=addmf(fis_GRH,'input',4,'medio','trimf',[28,50,71]);
    fis_GRH=addmf(fis_GRH,'input',4,'alto','trimf',[61,100,100]);
    
    %output
    %|0|---|-0.125-|---|0.25|---|-0.375-|---|0.5|---|-0.625-|---|0.75|---|-0.875-|---|1|
    fis_GRH=addmf(fis_GRH,'output',1,'mau','trimf',[0,0,0.125]);
    fis_GRH=addmf(fis_GRH,'output',1,'meiocre','trimf',[0.125,0.25,0.375]);
    fis_GRH=addmf(fis_GRH,'output',1,'suficiente','trimf',[0.375,0.5,0.625]);
    fis_GRH=addmf(fis_GRH,'output',1,'bom','trimf',[0.625,0.75,0.875]);
    fis_GRH=addmf(fis_GRH,'output',1,'muito bom','trimf',[0.875,1,1]);
    
    regras = [
        1 1 1 1 1 1 2
        2 2 2 2 3 1 2
        3 3 3 3 5 1 2
        ];
    
    fis_GRH = addrule(fis_GRH, regras);
    
    entrada = [ recrutamento retribuicao formacao retencao ];
    
    out = evalfis(entrada, fis_GRH);
    
end
