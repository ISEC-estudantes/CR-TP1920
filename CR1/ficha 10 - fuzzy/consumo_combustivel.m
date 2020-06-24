function [ fis_consumo ] = consumo_combustivel()

%PASSO 1: crie a estrutura FIS de nome fis_gorjeta
%COMPLETAR
fis_consumo = newfis('Consumo');

%PASSO 2: criar variaveis linguisticas ?servico?, ?comida? e ?gorjeta?
fis_consumo=addvar(fis_consumo,'input','aceleracao',[0 7000]);
fis_consumo=addvar(fis_consumo,'input','terreno',[-30 30]);
fis_consumo=addvar(fis_consumo,'input','pneus',[1 10]);
fis_consumo=addvar(fis_consumo,'output','consumo',[0 10]);

%PASSO 3: fun??es de perten?a para cada vari?vel criada anteriormente
%termos linguesticos addmf()
fis_consumo=addmf(fis_consumo,'input',1,'baixa','trimf',[-2800 0 2800]);
fis_consumo=addmf(fis_consumo,'input',1,'media','trapmf',[1000 2800 4200 6000]);
fis_consumo=addmf(fis_consumo,'input',1,'alta','trimf', [4200 7000 9800]);

fis_consumo=addmf(fis_consumo,'input',2,'descida','trimf', [-55 -30 0]);
fis_consumo=addmf(fis_consumo,'input',2,'plano','trimf', [-20 0 20]);
fis_consumo=addmf(fis_consumo,'input',2,'subida','trimf',  [0 30 55]);

fis_consumo=addmf(fis_consumo,'input',3,'irregular','pimf', [-55 -30 0]);
fis_consumo=addmf(fis_consumo,'input',3,'ideal','pimf',  [1 4 6 10]);
fis_consumo=addmf(fis_consumo,'input',3,'novos','pimf',  [7 9 10 15]);

fis_consumo=addmf(fis_consumo,'output',1,'baixo','trapmf', [-3.6 -0.4 2 5]);
fis_consumo=addmf(fis_consumo,'output',1,'media','trapmf', [1.4 4 6 8.6]);
fis_consumo=addmf(fis_consumo,'output',1,'alto','trapmf', [6.4 8 10.4 13.6]);
 
%PASSO 4: criar matriz de regras e adicionar com addrule
%SE aceleracao baixa ENTAO consumo baixo
%SE aceleracao baixa e terreno plano e pneus novos ENTAO consumo baixo
%SE aceleracao baixa e pneus novos ENTAO consumo baixo

%SE aceleracao baixa e terreno subido ENTAO consumo medio
%SE aceleracao media e terreno subido ENTAO consumo medio
%SE aceleracao alta e terreno descida ENTAO consumo medio

%SE aceleracao alta ENTAO consumo alto
%SE aceleracao alta ou terreno subido ENTAO consumo alto
%SE aceleracao alta e terreno descida e pneus irregulares ENTAO consumo
%alto
%SE terreno subida e pneus irregulares ENTAO consumo alto

%[aceleracao terreno pneu peso or-2/and-1]
regras=[1 0 0 1 1 1; %cada coluna é o indice da var. 1-baixo 2-medio 3-alto etc
        1 2 3 1 1 1; % se der erro trocar o ultimo 0 para 1
        1 0 3 1 1 1;
        1 3 0 2 1 1;
        2 3 0 2 1 1;
        2 1 0 2 1 1;
        3 0 0 3 1 2;
        3 3 1 3 1 1;
        0 3 1 3 1 1];%posicao dos termos linguesticos 
fis_consumo = addrule(fis_consumo, regras);

%PASSO 5: avaliar para v?rios valores de service e comida com evalfis

entrada = [1000 -20 2.5];%aceleracao, terreno, pneu
out = evalfis(entrada, fis_consumo);

disp(out)

 
end
