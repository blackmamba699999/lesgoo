% filename = uigetfile('*')
% filename = char2string(filename)

% for i = 1:2

filename = uigetfile('*');
Data = importdata(filename);
Setpoints = zeros([64,1]);
mu = zeros([1536,1]); % Dimension should max number of lines
% Kn =input('Normal Force Constant in uN/um:')
Kn = 86.45;
Kl = 209.55;
% Kl=input('Lateral Force Constant in uN/um:')

DeflSenN=input('Load up Normal deflection sensitivity in um/V:');
DeflSenL=input('Lateral deflection sensitivity in um/V:');
% Vstartup=input('Load up starting voltage:');
% Vstepup=input('Load up step size:');
Vstartdown= .1;
Vstepdown=.2;
V = Data(:,3);
% Setpoints(1,1) = Vstartdown;
% Setpoints(33,1) = Vstartup;

for i = 1:24; %upper limit = # of files taken
    Setpoints(i,1) = Vstartdown + (i-1)*Vstepdown;
%     mu(i,1) =  V(i,1).*(Kl*DeflSenL/(Kn*DeflSenN*Setpoints(i,1)))
    for j = 1 : 64;
        mu((((i-1)*64)+j),1) = V((((i-1)*64)+j),1).*(Kl*DeflSenL/(Kn*DeflSenN*Setpoints(i,1)));
    end
end
% for j = 33:64
%     Setpoints(j,1) = Vstartup + (j-33)*Vstepup
%     mu(j,1) =  V(j,1).*(Kl*DeflSenL/(Kn*DeflSenN*Setpoints(j,1)))
% 
% end


ylim([0 2])
hold on
% Data = Data(1:32000,:);
% mu = mu(1:32000);
% mu = flipud(mu); %flip for load down
% Data(:,3:4) = flipud(Data(:,3:4)); %flip for load down
plot(Data(:,2), Data(:,3), 'x', 'Color', uisetcolor)
xlabel('Time in seconds')
ylabel('mu');
Data = horzcat(Data, mu);
save(uiputfile, 'Data', '-ASCII')

% % plot(Data(:,2), mu, 'Color', uisetcolor)
% % end
% for i = 1:3000
%     line([32*i 32*i], [0 2], 'Color', 'r')
% end