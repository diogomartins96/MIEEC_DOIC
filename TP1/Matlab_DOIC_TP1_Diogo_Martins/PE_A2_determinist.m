%***********************************************************************%
%*********************** State Estimation - A2 *************************%
%*************** Evolutionary Programing - Determinist *****************%
%******************* Diogo Martins & Ines Trigo ************************%
%***********************************************************************%

clc
clear
close all

%% Get Data
Pmax=[80, 60, 70, 60];
Pmin=[40, 20, 30, 20];

%Cost Coefficients for each generator
a=[1100, 1200, 300, 650];
b=[20,25, 10, 20];
c=[0.1, 0.07, 0.2, 0.05];


%Stuf we can change for the report_____________________________________
NumPOP = 50;
simga = 0.7;
stop=0.001;
load_precent = 1.25; %changes from 0.75pu to 1.25
Line_Lim_precent = 0.5; %changes from 0.5 to 1.2
%_______________________________________________________________________

%Network Data
NumGenerator = length(Pmax);
Bar = 5;

Pc = [50;100;0;0;50]*load_precent;
P_load = sum(Pc);

Line_lim_ini = [48; 59; 89; 94; 59; 74]/100;
Line_Lim = Line_lim_ini * Line_Lim_precent*0.85;

A = Amatrix


%% Initial Population
matrixPOP = GeraPop(Pmax, Pmin, NumPOP, P_load );


for initiatePOP=1:30

% Clone matrix
clonePOP=Clone(matrixPOP);

% Mutate
mutPOP_ini=mutate(matrixPOP, clonePOP, simga,P_load);

%Choose new individuals

[ChosenPOP_ini, BestPrice_ini] = deterministic_A2(mutPOP_ini, NumPOP, a,...
    b, c, Pmax, Pmin,Pc, A, Line_Lim);

%newGen
matrixPOP = ChosenPOP_ini;
end 


for i=1:3000

% Clone matrix
clonePOP=Clone(matrixPOP);

% Mutate
mutPOP_ini=mutate(matrixPOP, clonePOP, simga,P_load);


%Choose new individuals

[ChosenPOP, BestPrice] = deterministic_A2(mutPOP_ini, NumPOP, a, b, ...
	c, Pmax, Pmin, Pc, A, Line_Lim);

%Saving data for plotting
 Price_History(i) = BestPrice;
 Production_G31_History(i) = ChosenPOP(1,1);
 Production_G32_History(i) = ChosenPOP(2,1);
 Production_G41_History(i) = ChosenPOP(3,1);
 Production_G42_History(i) = ChosenPOP(4,1);


%Stoping criteria

if i>22
	if ( abs(Price_History(i-21)-Price_History(i))<stop)
        if (abs(Price_History(i-20)-Price_History(i-1))<stop)
		break
        end
	end

end
 
 
%newGen
matrixPOP = ChosenPOP;
end 

%% Results Display 
fprintf('Best Solution\nP (MW) =\n');
disp(ChosenPOP(:,1))
fprintf('Best Solution\nCost (Euro/MWh) = ');
disp(BestPrice)
fprintf('Number of iterations: ');
disp(i)

figure(1)
plot(Production_G31_History);
hold on 
plot(Production_G32_History);
hold on 
plot(Production_G41_History);
hold on 
plot(Production_G42_History);
title('Evolution of prodruction in the best individual')
xlabel('Number of iterations')
ylabel('Production (MW)')
legend('G31','G32','G41','G42')


figure(2)
plot(Price_History);
title('Evolution of BestPrice in the best individual')
xlabel('Number of iterations')
ylabel('Price (Euro/MWh)')





