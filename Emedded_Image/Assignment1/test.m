%take input of all images from file 

path1 = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI-SEM2/Emedded_Image/Assignment1/6-CapMissing';
rng(10);

% No Cap
[c,c1]= deal(0);
imagefiles1 = dir(fullfile(path1,'*.jpg'));
for i=1:numel(imagefiles1)
    filename = fullfile(path1,imagefiles1(i).name);
    I = imread(filename);
    I = rgb2gray(I);
    J = imnoise(I,'gaussian',0,0.15);
    imshow(J);
    nocap=capmissing(J);    
    if nocap
        c = c + 1;
    end
    B=fft2(J); 
    B=fftshift(B);
    [rows, cols]=size(J);
    % set up a “mask” to do the filtering
    dim=5;
    mask=zeros(rows,cols); 
    mask(96:192,118:235)=1; 
    %mask(108:180,132:220)=1;
    % apply the filter (simple multiplication of the mask by the spectrum of
    % the image)
    B2 = B.*mask;
    IMG=ifft2(B2);
    figure; 
    imagesc(abs(IMG)); 
    axis image; axis off; colormap(gray)
    nocap1=capmissing(abs(IMG));
    if nocap1
        c1 = c1 + 1;
    end
  
     
end
a = c / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.15 is : %d \n',a);
a1 = c1 / numel(imagefiles1) * 100;
fprintf('Accuracy after averaging filter : %d \n',a1);
%  Fault Functions


function CM = capmissing(img)

cropimg = img(5:60 , 140:220);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

pause(0.5);
CM = blackv < 30;

end


