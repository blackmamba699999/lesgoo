cd ('C:\Users\Jam\Desktop\temp\MatlabCodes\');

filename = 'area4-2.txt';

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
Img22=flipud(Img22');
  imshow(Img22,[-.13,.16]);
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