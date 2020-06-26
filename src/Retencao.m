function [ fis_Retencao ] = Retencao()

%PASSO 1: crie a estrutura FIS de nome fis_Recrutamento 
%%mamdani default gang
fis_Recrutamento = newfis('fis_Recrutamento');


%PASSO 2: criar variaveis linguisticas ?servico?, ?comida? e ?gorjeta?
%Variaeis de retencao
%%inputs
fis_Recrutamento=addvar(fis_Recrutamento,'input','mediaCustosPessoal',[0 45]);%baixo
fis_Recrutamento=addvar(fis_Recrutamento,'input','salarioMedioSCA',[400 1300]);%baixo
fis_Recrutamento=addvar(fis_Recrutamento,'input','salarioMedioCCA',[700 1800]);%baixo
fis_Recrutamento=addvar(fis_Recrutamento,'input','percentBonificacoes',[0 25]);%alto

%%output
fis_Recrutamento=addvar(fis_Recrutamento,'output', 'Recrutamento', [0, 100]);

%PASSO 3: fun??es de perten?a para cada vari?vel criada anteriormente
%Defenicao dos limites [baixo, medio, baixo]

%|0|---|8-11-14|---|23|---|31-34-37|---|45|
fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'baixo','trimf',[0,0,14]);
fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'medio','trimf',[8,23,37]);
fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'alto','trimf',[31,45,45]);

%|400|---|600-700-800|---|450|---|900-1000-1100|---|1300|
fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'baixo','trimf',[400,400,800]);
fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'medio','trimf',[600,450,1100]);
fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'alto','trimf',[900,1300,1300]);

%|700|---|925-975-1025|---|1250|---|1475-1525-1575|---|1800|
fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'baixo','trimf',[700,700,1025]);
fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'medio','trimf',[925,1250,1575]);
fis_Recrutamento=addmf(fis_Recrutamento,'input',3,'alto','trimf',[1475,1800,1800]);

%|0|---|5-7-9|---|13|---|16-18-20|---|25|
fis_Recrutamento=addmf(fis_Recrutamento,'input',4,'baixo','trimf',[0,0,9]);
fis_Recrutamento=addmf(fis_Recrutamento,'input',4,'medio','trimf',[5,13,20]);
fis_Recrutamento=addmf(fis_Recrutamento,'input',4,'alto','trimf',[16,25,25]);

%|0|---|28-33-38|---|50| ---|61-66-71|---|100|
fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'baixo','trimf',[0,0,38]);
fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'medio','trimf',[28,50,71]);
fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'alto','trimf',[61,100,100]);

regras = [
    1 1 1 0 3 1 2
    2 2 2 0 2 1 2
    3 3 3 0 1 1 2
    0 0 0 1 1 1 1
    0 0 0 2 2 1 1
    0 0 0 3 3 1 1
];

fis_Recrutamento = addrule(fis_Recrutamento, regras);

entrada = [0 400 700 25];

out = evalfis(entrada, fis_Recrutamento)

end
