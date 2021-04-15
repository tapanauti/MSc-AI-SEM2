%take input of all images from file 

%path1 = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI-SEM2/Emedded_Image/Assignment1/6-CapMissing';
rng(10);
c5=0;
I = imread('1.jpg');
I = rgb2gray(I);


J5 = imnoise(I,'gaussian',0,0.15);
IMG = fd(J5);
nocap1=capmissing(abs(IMG));    
if nocap
    c5 = c5 + 1;
end
            

fprintf('No Cap \n');
a1 = c1 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0 is : %d \n',a1);

function FD = fd(J)
B=fft2(J); 
B=fftshift(B);
[rows, cols]=size(J);
mask=zeros(rows,cols); 
mask(96:192,118:235)=1; 
%mask(108:180,132:220)=1;
B2 = B.*mask;
IMG=ifft2(B2);
FD = IMG;
end


function CM = capmissing(img)

%img = rgb2gray(img);

cropimg = img(5:60 , 140:220);

binary = imbinarize(cropimg,120);
imshow(binary)
blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

pause(1);
CM = blackv < 30;

end


