function [ fis_Retencao ] = Retencao()

%PASSO 1: crie a estrutura FIS de nome fis_Retencao 
%%mamdani default gang
fis_Retencao = newfis('fis_Retencao');


%PASSO 2: criar variaveis linguisticas ?servico?, ?comida? e ?gorjeta?
%Variaeis de retencao
%%inputs
fis_Retencao=addvar(fis_Retencao,'input','percentCustoForm',[0 5]);%baixo
fis_Retencao=addvar(fis_Retencao,'input','horasForm',[0 45]);%baixo
fis_Retencao=addvar(fis_Retencao,'input','horasFormFN1',[0 100]);%baixo

%%output
fis_Retencao=addvar(fis_Retencao,'output', 'Retencao', [0, 100]);

%PASSO 3: fun??es de perten?a para cada vari?vel criada anteriormente
%Defenicao dos limites [baixo, medio, baixo]

%|0|---|0.75-1.25-1.75|---|2.5|---|3.25-3.75-4.25|---|5|
fis_Retencao=addmf(fis_Retencao,'input',1,'baixo','trimf',[0,0,14]);
fis_Retencao=addmf(fis_Retencao,'input',1,'medio','trimf',[8,23,37]);
fis_Retencao=addmf(fis_Retencao,'input',1,'alto','trimf',[31,45,45]);

%|0|---|6.25-11.25-16.25|---|22.5|---|28.75-33.75-38.75|---|45|
fis_Retencao=addmf(fis_Retencao,'input',2,'baixo','trimf',[0,0,16.25]);
fis_Retencao=addmf(fis_Retencao,'input',2,'medio','trimf',[6.25,22.5,38.75]);
fis_Retencao=addmf(fis_Retencao,'input',2,'alto','trimf',[28.75,45,45]);

%|700|---|925-975-1025|---|1250|---|1475-1525-1575|---|1800|
fis_Retencao=addmf(fis_Retencao,'input',3,'baixo','trimf',[700,700,1025]);
fis_Retencao=addmf(fis_Retencao,'input',3,'medio','trimf',[925,1250,1575]);
fis_Retencao=addmf(fis_Retencao,'input',3,'alto','trimf',[1475,1800,1800]);

%|0|---|5-7-9|---|13|---|16-18-20|---|25|
fis_Retencao=addmf(fis_Retencao,'input',4,'baixo','trimf',[0,0,9]);
fis_Retencao=addmf(fis_Retencao,'input',4,'medio','trimf',[5,13,20]);
fis_Retencao=addmf(fis_Retencao,'input',4,'alto','trimf',[16,25,25]);


regras = [
    1 1 1 0 3 1 2
    2 2 2 0 2 1 2
    3 3 3 0 1 1 2
    0 0 0 1 1 1 1
    0 0 0 2 2 1 1
    0 0 0 3 3 1 1
];

fis_Retencao = addrule(fis_Retencao, regras);

entrada = [0 400 700 25];

out = evalfis(entrada, fis_Retencao)

end
