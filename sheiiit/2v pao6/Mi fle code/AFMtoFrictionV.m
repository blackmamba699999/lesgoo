% clear all, clc, close all
cd ('C:\Users\nitya\Box Sync\Jaron Friction Analysis Work in Progress\Matlab Codes'); %ENTER THE DIRECTORY IN THE PURPLE, must be changed each time
%[y,Fs] = audioread('chime.wav'); %beep for when you have to input x-boundaries
filenames = uigetfile('*.txt','MultiSelect','on')
ypixelstotal = 0
filenames = cellstr(filenames)
L = length(filenames);
Nityawants = zeros(L*512,4); %final matrix to be filled with data

for imgnumber = 1:L

    close all

    
filename = filenames(imgnumber)
filename = char(filename)


delimiterIn = ' ';
headerlinesIn = 181;
newData1 = importdata(filename,delimiterIn,headerlinesIn);
vars = fieldnames(newData1);

%first column: scan line. Second column: mean mu. 3rd line: friction error.

for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end
xpixels = textdata{32};
xpixels= xpixels(14:end);
xpixels = str2num(xpixels);
ypixels = textdata{33};
ypixels = ypixels(14:end);
ypixels = str2num(ypixels);
ypixelstotal = ypixelstotal + ypixels
%//////////////INPUTS
Imgno=4; %total number of images
% xpixels=256; %
% ypixels=256; 
finaldata=zeros(ypixels,3);

% 
setpoint= -.3;% force setpoint in volts
step= 0.0;% voltage/load steps for each line
% setpoint = input(setpoint);
% step = input(step);
%////////////////////

length(data);
ImgElem=length(data)/Imgno;
% Images=4; %number of images

% datapoints=Images*xpixels*ypixels;
% Imagepoints=xpixels*ypixels;

Img1=data(1:ImgElem);
Img11= reshape(Img1, xpixels, ypixels);
Img11=flipud(Img11');
 %imshow(Img11',[.1,1.18])
% save('00002_image1', 'Img11', '-ascii');

Img2=data((1+ImgElem):2*ImgElem);
Img22=(reshape(Img2, xpixels, ypixels));
Img22=(Img22');
% imshow(Img22,[-.13,-.06]);
%save('00002_image2', 'Img22', '-ascii');

Img3=data((1+2*ImgElem):3*ImgElem);
Img33= reshape(Img3, xpixels, ypixels);
Img33=flipud(Img33');
 %imshow(Img33, [-.17,-.09]);
%save('00002_image3', 'Img33', '-ascii'); 

Img4=data((1+3*ImgElem):4*ImgElem);
Img44= reshape(Img4, xpixels, ypixels);
Img44=flipud(Img44');
% imshow(Img44);
%save('00002_image4', 'Img44', '-ascii');
%Img22=Img22(((xpixels/4)+1):64,(xpixels*3/4):64);

Img222=Img22(1:ypixels,((xpixels/4)+1):(xpixels*3/4));
Img333=Img33(1:ypixels,((xpixels/4)+1):(xpixels*3/4));

% imshow(Img22,[-.13,-.06]);
%Friction=((sum(Img222,2)./xpixels)-(sum(Img333,2)./xpixels));
% Friction=(sum((Img222-Img333),2)./xpixels);
% Frictionerror=(std((Img222-Img333),0,2)./xpixels);
% % 
% 
% for count=1:ypixels
%  
% finaldata(count,1)=setpoint+(count-1)*step;
% finaldata(count,2)=Friction(count,1);
% % finaldata(count,3)=Frictionerror(count,1);
% % end
% 
% save('load up1 mp3 to 2p85v 0p05v steps_001_FL', 'finaldata', '-ASCII');
Scanup = strcmp(textdata(38),'scanUp        TRUE')
speed = textdata{39};
speed = speed(14:end);
speed = str2num(speed);
if Scanup==1 %flipping for for scan direction
    Img33 = flipud(Img33);
    Img44 = flipud(Img44);

end

% 
% % Plotting all 256 curves so that you can see the range of columns to select
%  for j = 1:ypixels
%  I = [1:1:xpixels];
%  figure(1)
%  plot(I,Img44(j,I),'r')
%  hold on
%  plot (I,Img33(j,I),'b')
%  hold on
%  axis tight
%  xlabel('Distance X')
%  ylabel('Friction Force')
%  end
 
I = [1:1:ypixels]; %rows
refit = 1;
attempt = 1;
 
while refit == 1
%     sound(y, Fs)
%  MinX = input('Minimum X:'); %Minimum column number you want to use for average mu
%  MaxX = input('Maximum X:'); %maximum column number you want to use for average mu
MinX = 30; %Minimum column number you want to use for average mu
 MaxX = 220; %maximum column number you want to use for average mu
 
while MinX < 1 | MaxX > xpixels | MaxX <= MinX; %error-resistant logic loop
    fprintf(2,'Check your boundaries\n')
%      MinX = input('Minimum X:'); %Minimum column number you want to use for average mu
%  MaxX = input('Maximum X:'); %maximum column number you want to use for average mu
   MinX = 30; %Minimum column number you want to use for average mu
   MaxX = 220; %maximum column number you want to use for average mu
end
 
ModImg33 = Img33([1:ypixels],[MinX:MaxX]); %trims the friction data matrix as specified above
ModImg44=Img44([1:ypixels],[MinX:MaxX]);
meanFf = mean(ModImg33,2);
meanFr = mean(ModImg44,2);
FrictionV = abs( .5.*(meanFf - meanFr));
MeanfrictionV = mean(FrictionV); %average of friction over all rows
    figure((attempt+1)) %plots each attempt in a separate figure so you can compare your work as you go
    plot(I,FrictionV,'r')
    axis tight
    xlabel('Row Number')
    ylabel('Average of mean forward and reverse friction')
    hold on
    plot(I,MeanfrictionV,'-b')
    display(attempt)
    display(MeanfrictionV)
    attempt = attempt+1;
%     refit = input('Revise Column number?(yes=1, no = 0):'); %comment out if you don't want to trim -every- frame
    refit = 0 %comment out if you want to trim -every- frame
    STD = std(((ModImg33-ModImg44).*.5),0,2);



end


    
for t = 1:1:ypixels
Nityawants((imgnumber*ypixels)+t-ypixels,1) = (imgnumber-1)*ypixels+t;

if imgnumber == 1
Nityawants((imgnumber*ypixels)+t-ypixels,2) = ((imgnumber-1)*ypixels+t)./speed;
else 
    Nityawants((imgnumber*ypixels)+t-ypixels,2) = Nityawants(((imgnumber*ypixels)+t-ypixels)-1,2)+ 1./speed;
end
Nityawants((imgnumber*ypixels)+t-ypixels,3) = FrictionV(t,1);
Nityawants((imgnumber*ypixels)+t-ypixels,4) = STD(t,1);
end
end
rowstotal = [-255:(ypixelstotal)];
Nityawants = Nityawants(1:ypixelstotal,:);

figure (100)
plot(Nityawants(:,1),Nityawants(:,3),'g')
hold on
plot(Nityawants(:,1),Nityawants(:,3),'xb')

axis ([1 ypixelstotal 0 2])
ylim([0 1.5])

savedfile1 = filename(1:end-4);
savedfile = strcat(savedfile1,'finaldata');


save(savedfile, 'Nityawants', '-ASCII')

for l = 1:L
line([l*ypixels l*ypixels],[0 2], 'Color', 'r')
end



