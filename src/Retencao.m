 
function [ fis_Retribuicao ] = Retribuicao()

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

%inputss
%|0|---|0.75-1.25-1.75|---|2.5|---|3.25-3.75-4.25|---|5|
fis_Formacao=addmf(fis_Formacao,'input',1,'baixo','trimf',[0,0,14]);
fis_Formacao=addmf(fis_Formacao,'input',1,'medio','trimf',[8,23,37]);
fis_Formacao=addmf(fis_Formacao,'input',1,'alto','trimf',[31,45,45]);

%|0|---|1.75-3.75-5.75|---|7.5|---|9.25-11.25-13.25|---|15|
fis_Formacao=addmf(fis_Formacao,'input',2,'baixo','trimf',[0,0,5.75]);
fis_Formacao=addmf(fis_Formacao,'input',2,'medio','trimf',[1.75,7.5,13.25]);
fis_Formacao=addmf(fis_Formacao,'input',3,'alto','trimf',[9.25,15,15]);

%output
%|0|---|28-33-38|---|50| ---|61-66-71|---|100|
fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'baixo','trimf',[0,0,38]);
fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'medio','trimf',[28,50,71]);
fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'alto','trimf',[61,100,100]);


regras = [
];

fis_Retribuicao = addrule(fis_Retribuicao, regras);

entrada = [0 400 700 25];

out = evalfis(entrada, fis_Retribuicao)

end
