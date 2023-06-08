cd ('C:\Users\nitya\Box Sync\Jaron Friction Analysis Work in Progress\Matlab Codes'); %ENTER THE DIRECTORY IN THE PURPLE, must be changed each time

%[y,Fs] = audioread('chime.wav'); %beep for when you have to input x-boundaries
filenames = uigetfile('*.txt','MultiSelect','on')
L = length(filenames);

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


ftrim = filename(1:end-4);
tfn = strcat('top',ftrim, '.png');
dfn = strcat('def',ftrim, '.png');
ffn = strcat('fri', ftrim, '.png');

% [xs,ys] = meshgrid(1:size(Img11,2),1:size(Img11,1));
% p = fit([xs(:),ys(:)],Img11(:),'poly11');
% Img11_planefit = Img11-feval(p,xs,ys);

% [xs,ys] = meshgrid(1:size(Img11_planefit,2),1:size(Img11_planefit,1));
% p = fit([xs(:),ys(:)],Img11_planefit(:),'poly11');
% Img11_planefit = Img11_planefit-feval(p,xs,ys);
% 
% [xs,ys] = meshgrid(1:size(Img11_planefit,2),1:size(Img11_planefit,1));
% p = fit([xs(:),ys(:)],Img11_planefit(:),'poly11');
% Img11_planefit = Img11_planefit-feval(p,xs,ys);

% Img11image = mat2gray(Img11_planefit, [-.011 .011]);
% imshow(Img11image)
Img22image = mat2gray(Img22, [-.8 1.2]);
Img33image = mat2gray (Img33, [0.05 0.7]);
%Img11 is topography, limits are in um
%Img22 is deflection, limits are in V
%Img33 is friction, limits are in V)
% imwrite(Img11image,tfn)
imwrite(Img22image,dfn)
imwrite(Img33image,ffn)
end