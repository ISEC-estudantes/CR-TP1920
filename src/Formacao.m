
function [ fis_GRH ] = Formacao()

%PASSO 1: crie a estrutura FIS de nome fis_GRH 
%%mamdani default gang
fis_GRH = newfis('GRH');


%PASSO 2: criar variaveis linguisticas ?servico?, ?comida? e ?gorjeta?

%%Formação
fis_GRH=addvar(fis_GRH,'input','percentCustoForm',[0 0.05]);%medio
fis_GRH=addvar(fis_GRH,'input','horasForm',[0 45]);%medio
fis_GRH=addvar(fis_GRH,'input','horasFormFN1',[0 100]);%alto

%PASSO 3: fun??es de perten?a para cada vari?vel criada anteriormente
fis_GRH=addmf(fis_GRH,'input',1,'fraco','gaussmf',[1.5 0]);
fis_GRH=addmf(fis_GRH,'input',2,'ma','trapmf',[0 0 1 3]);
fis_GRH=addmf(fis_GRH,'output',1,'fraca','trimf',[0 5 10]);

%PASSO 4: criar matriz de regras e adicionar com addrule
regras=[
    
    
];%COMPLETAR


%PASSO 5: avaliar para v?rios valores de service e comida com evalfis
for servico=0:10
    for comida=0:10
        entrada=[servico comida];
        out = evalfis(entrada,fis_GRH);
        fprintf('servi?o = %d\nComida = %d\nGorjeta = %f\n\n',servico, comida, out);
    end
end
 
end