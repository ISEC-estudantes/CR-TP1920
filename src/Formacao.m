function [ fis_Formacao, out ] = Formacao(percentCustoForm, horasForm, horasFormFN1)

%PASSO 1: crie a estrutura FIS de nome fis_Formacao 
%%mamdani default gang
fis_Formacao = newfis('fis_Formacao');


%PASSO 2: criar variaveis linguisticas ?servico?, ?comida? e ?gorjeta?
%Variaeis de retencao
%%inputs
fis_Formacao=addvar(fis_Formacao,'input','percentCustoForm',[0 5]);%medio
fis_Formacao=addvar(fis_Formacao,'input','horasForm',[0 45]);%medio
fis_Formacao=addvar(fis_Formacao,'input','horasFormFN1',[0 100]);%alto

%%output
fis_Formacao=addvar(fis_Formacao,'output', 'Formacao', [0, 100]);

%PASSO 3: fun??es de perten?a para cada vari?vel criada anteriormente
%Defenicao dos limites [baixo, medio, baixo]

%|0|---|0.75-1.25-1.75|---|2.5|---|3.25-3.75-4.25|---|5|
fis_Formacao=addmf(fis_Formacao,'input',1,'baixo','trimf',[0,0,14]);
fis_Formacao=addmf(fis_Formacao,'input',1,'medio','trimf',[8,23,37]);
fis_Formacao=addmf(fis_Formacao,'input',1,'alto','trimf',[31,45,45]);

%|0|---|6.25-11.25-16.25|---|22.5|---|28.75-33.75-38.75|---|45|
fis_Formacao=addmf(fis_Formacao,'input',2,'baixo','trimf',[0,0,16.25]);
fis_Formacao=addmf(fis_Formacao,'input',2,'medio','trimf',[6.25,22.5,38.75]);
fis_Formacao=addmf(fis_Formacao,'input',2,'alto','trimf',[28.75,45,45]);

%|0|---|28-33-38|---|50| ---|61-66-71|---|100|
fis_Formacao=addmf(fis_Formacao,'input',3,'baixo','trimf',[0,0,38]);
fis_Formacao=addmf(fis_Formacao,'input',3,'medio','trimf',[28,50,71]);
fis_Formacao=addmf(fis_Formacao,'input',3,'alto','trimf',[61,100,100]);


%|0|---|28-33-38|---|50| ---|61-66-71|---|100|
fis_Formacao=addmf(fis_Formacao,'output',1,'baixo','trimf',[0,0,38]);
fis_Formacao=addmf(fis_Formacao,'output',1,'medio','trimf',[28,50,71]);
fis_Formacao=addmf(fis_Formacao,'output',1,'alto','trimf',[61,100,100]);


regras = [
    2 2 0 3 1 2
    1 1 0 1 1 2
    3 3 0 1 1 2
    0 0 3 3 1 1
    0 0 2 2 1 1
    0 0 1 1 1 1
];

fis_Formacao = addrule(fis_Formacao, regras);

entrada = [percentCustoForm horasForm horasFormFN1];

out = evalfis(entrada, fis_Formacao)

end
