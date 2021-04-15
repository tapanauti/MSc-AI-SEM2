% Basic frequency domain filtering 
A=imread('1.jpg'); 
A = rgb2gray(A);
J = imnoise(A,'gaussian',0,0.15);
B=fft2(J); 
B=fftshift(B);
[rows, cols]=size(A);

% set up a “mask” to do the filtering

mask=zeros(rows,cols); 
%mask(96:192,118:235)=1; %#ok<*BDSCA>
mask(108:180,132:220)=1; %#ok<*BDSCA>
% apply the filter (simple multiplication of the mask by the spectrum of
% the image)
B2 = B.*mask;
Arecon=ifft2(B2);
figure;
subplot(1,2,1), imshow(mask); 
subplot(1,2,2), imagesc(abs(Arecon)); 
axis image; axis off; colormap(gray)

