clear all, clc, close all
cd ('C:\Users\Jam\Desktop\temp\05292014\05292014\MatlabCodes\')

filename =  uigetfile('*.txt');

delimiterIn = ' ';
headerlinesIn = 190;
newData1 = importdata(filename,delimiterIn,headerlinesIn);
vars = fieldnames(newData1);

for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end

%//////////////INPUTS
Imgno=4; %total number of images
xpixels=256; %
ypixels=256; 
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
Img33=(Img33');
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
Friction=(sum((Img222-Img333),2)./xpixels);
Frictionerror=(std((Img222-Img333),0,2)./xpixels);
% 

for count=1:ypixels
 
finaldata(count,1)=setpoint+(count-1)*step;
finaldata(count,2)=Friction(count,1);
finaldata(count,3)=Frictionerror(count,1);
end

save('load up1 mp3 to 2p85v 0p05v steps_001_FL', 'finaldata', '-ASCII');



% w = waitforbuttonpress;
% if w == 0
%     disp('Button click')
% else
%     disp('Key press')
% end

% Imagetwo=A((1+1*Imagepoints):2*Imagepoints)
% Imagetwo2= reshape(Imagetwo, 256, 256)
% imshow(Imagetwo2,[.7,1.0])
% %Imagetwo=A(
% w = waitforbuttonpress;
% if w == 0
%     disp('Button click')
% else
%     disp('Key press')
% end
% Imagethree=A((1+2*Imagepoints):3*Imagepoints)
% Imagethree2= reshape(Imagethree, 256, 256)
% imshow(Imagethree2,[.2,.4])
% w = waitforbuttonpress;
% if w == 0
%     disp('Button click')
% else
%     disp('Key press')
% end
% Imagefour=A((1+3*Imagepoints):4*Imagepoints)
% Imagefour2= reshape(Imagefour, 256, 256)
% imshow(Imagefour2,[5.2,5.5])
% if w == 0
%     disp('Button click')
% else
%     disp('Key press')
% end

for j = 1:256
I = [1:1:256];
plot((256-I),Img44(j,I),'r')
hold on
plot ((256-I),Img33(j,I),'b')
hold on
end