function [ fis_Retribuicao, out ] = Retribuicao(mediaCustosPessoal, salarioMedioSCA, salarioMedioCCA, percentBonificacoes)

%PASSO 1: crie a estrutura FIS de nome fis_Retribuicao 
%%mamdani default gang
fis_Retribuicao = newfis('fis_Retribuicao');


%PASSO 2: criar variaveis linguisticas ?servico?, ?comida? e ?gorjeta?
%Variaeis de retencao
%%inputs
fis_Retribuicao=addvar(fis_Retribuicao,'input','mediaCustosPessoal',[0 45]);%baixo
fis_Retribuicao=addvar(fis_Retribuicao,'input','salarioMedioSCA',[400 1300]);%baixo
fis_Retribuicao=addvar(fis_Retribuicao,'input','salarioMedioCCA',[700 1800]);%baixo
fis_Retribuicao=addvar(fis_Retribuicao,'input','percentBonificacoes',[0 25]);%alto

%%output
fis_Retribuicao=addvar(fis_Retribuicao,'output', 'Retribuicao', [0, 100]);

%PASSO 3: fun??es de perten?a para cada vari?vel criada anteriormente
%Defenicao dos limites [baixo, medio, baixo]

%|0|---|8-11-14|---|23|---|31-34-37|---|45|
fis_Retribuicao=addmf(fis_Retribuicao,'input',1,'baixo','trimf',[0,0,14]);
fis_Retribuicao=addmf(fis_Retribuicao,'input',1,'medio','trimf',[8,23,37]);
fis_Retribuicao=addmf(fis_Retribuicao,'input',1,'alto','trimf',[31,45,45]);

%|400|---|600-700-800|---|450|---|900-1000-1100|---|1300|
fis_Retribuicao=addmf(fis_Retribuicao,'input',2,'baixo','trimf',[400,400,800]);
fis_Retribuicao=addmf(fis_Retribuicao,'input',2,'medio','trimf',[450,600,1100]);
fis_Retribuicao=addmf(fis_Retribuicao,'input',2,'alto','trimf',[900,1300,1300]);

%|700|---|925-975-1025|---|1250|---|1475-1525-1575|---|1800|
fis_Retribuicao=addmf(fis_Retribuicao,'input',3,'baixo','trimf',[700,700,1025]);
fis_Retribuicao=addmf(fis_Retribuicao,'input',3,'medio','trimf',[925,1250,1575]);
fis_Retribuicao=addmf(fis_Retribuicao,'input',3,'alto','trimf',[1475,1800,1800]);

%|0|---|5-7-9|---|13|---|16-18-20|---|25|
fis_Retribuicao=addmf(fis_Retribuicao,'input',4,'baixo','trimf',[0,0,9]);
fis_Retribuicao=addmf(fis_Retribuicao,'input',4,'medio','trimf',[5,13,20]);
fis_Retribuicao=addmf(fis_Retribuicao,'input',4,'alto','trimf',[16,25,25]);

%|0|---|28-33-38|---|50| ---|61-66-71|---|100|
fis_Retribuicao=addmf(fis_Retribuicao,'output',1,'baixo','trimf',[0,0,38]);
fis_Retribuicao=addmf(fis_Retribuicao,'output',1,'medio','trimf',[28,50,71]);
fis_Retribuicao=addmf(fis_Retribuicao,'output',1,'alto','trimf',[61,100,100]);

regras = [
    1 1 1 0 3 1 2
    2 2 2 0 2 1 2
    3 3 3 0 1 1 2
    0 0 0 1 1 1 1
    0 0 0 2 2 1 1
    0 0 0 3 3 1 1
];

fis_Retribuicao = addrule(fis_Retribuicao, regras);

entrada = [mediaCustosPessoal salarioMedioSCA salarioMedioCCA percentBonificacoes];

out = evalfis(entrada, fis_Retribuicao)

end
