function [ fis_Recrutamento ] = Retencao()

%PASSO 1: crie a estrutura FIS de nome fis_GRH 
%%mamdani default gang
fis_Recrutamento = newfis('Recrutamento');

%PASSO 2: criar variaveis linguisticas ?servico?, ?comida? e ?gorjeta?

%%Retenção
fis_Recrutamento=addvar(fis_Recrutamento,'input','percentEmptN1Desistentes',[0 0.05]);%baixo
fis_Recrutamento=addvar(fis_Recrutamento,'input','percentEmptOperacionaisDesistentes',[0 0.15]);%baixo

%PASSO 3: fun??es de perten?a para cada vari?vel criada anteriormente
fis_Recrutamento=addmf(fis_Recrutamento,'input',1,'fraco','gaussmf',[1.5 0]);

fis_Recrutamento=addmf(fis_Recrutamento,'input',2,'ma','trapmf',[0 0 1 3]);
fis_Recrutamento=addmf(fis_Recrutamento,'output',1,'fraca','trimf',[0 5 10]);

%PASSO 4: criar matriz de regras e adicionar com addrule
regras=[
    
    
];%COMPLETAR


%PASSO 5: avaliar para v?rios valores de service e comida com evalfis
for servico=0:10
    for comida=0:10
        entrada=[servico comida];
        out = evalfis(entrada,fis_Recrutamento);
        fprintf('servi?o = %d\nComida = %d\nGorjeta = %f\n\n',servico, comida, out);
    end
end
 
end