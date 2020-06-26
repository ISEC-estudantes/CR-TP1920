 
function [ fis_Retencao ] = Retencao()

%PASSO 1: crie a estrutura FIS de nome fis_Retencao 
%%mamdani default gang
fis_Retencao = newfis('fis_Retencao');


%PASSO 2: criar variaveis linguisticas ?servico?, ?comida? e ?gorjeta?
%Variaeis de retencao
%%inputs
fis_Retencao=addvar(fis_Retencao,'input','mediaCustosPessoal',[0 5]);%baixo
fis_Retencao=addvar(fis_Retencao,'input','salarioMedioSCA',[0 15]);%baixo

%%output
fis_Retencao=addvar(fis_Retencao,'output', 'Retencao', [0, 100]);

%PASSO 3: fun??es de perten?a para cada vari?vel criada anteriormente

%inputss
%|0|---|0.75-1.25-1.75|---|2.5|---|3.25-3.75-4.25|---|5|
fis_Retencao=addmf(fis_Retencao,'input',1,'baixo','trimf',[0,0,14]);
fis_Retencao=addmf(fis_Retencao,'input',1,'medio','trimf',[8,23,37]);
fis_Retencao=addmf(fis_Retencao,'input',1,'alto','trimf',[31,45,45]);

%|0|---|1.75-3.75-5.75|---|7.5|---|9.25-11.25-13.25|---|15|
fis_Retencao=addmf(fis_Retencao,'input',2,'baixo','trimf',[0,0,5.75]);
fis_Retencao=addmf(fis_Retencao,'input',2,'medio','trimf',[1.75,7.5,13.25]);
fis_Retencao=addmf(fis_Retencao,'input',2,'alto','trimf',[9.25,15,15]);

%output
%|0|---|28-33-38|---|50| ---|61-66-71|---|100|
fis_Retencao=addmf(fis_Retencao,'output',1,'baixo','trimf',[0,0,38]);
fis_Retencao=addmf(fis_Retencao,'output',1,'medio','trimf',[28,50,71]);
fis_Retencao=addmf(fis_Retencao,'output',1,'alto','trimf',[61,100,100]);


regras = [
        1 1 3 1 2
        2 2 2 1 2
        3 3 1 1 2
];

fis_Retencao = addrule(fis_Retencao, regras);

entrada = [0 0];

out = evalfis(entrada, fis_Retencao)

end
