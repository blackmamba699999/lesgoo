% filename = uigetfile('*')
% filename = char2string(filename)

% for i = 1:2
clear all, close all
filename = uigetfile('*')
Data = importdata(filename);
% Kn =input('Normal Force Constant in uN/um:')
Kn = 27.96
Kl = 165.53
% Kl=input('Lateral Force Constant in uN/um:')

% DeflSenN=   input('Normal deflection sensitivity in um/V:')
% DeflSenL=input('Lateral deflection sensitivity in um/V:')
% Vl = input('Loading Voltage:')
DeflSenN=   119.5
DeflSenL= 125
Vl = 5
V = Data(:,3);
mu = V.*(Kl*DeflSenL/(Kn*DeflSenN*Vl));


ylim([0 2])
hold on
% Data = Data(1:32000,:);
% mu = mu(1:32000);
plot(Data(:,2), mu, 'x', 'Color', uisetcolor)
Data = horzcat(Data, mu);
save(uiputfile, 'Data', '-ASCII')

xlabel('Time in seconds')
ylabel('mu')
% % plot(Data(:,2), mu, 'Color', uisetcolor)
% % end
% for i = 1:3000
%     line([32*i 32*i], [0 2], 'Color', 'r')
% end