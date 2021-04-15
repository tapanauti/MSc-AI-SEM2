%take input of all images from file 

path = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI-SEM2/Emedded_Image/Assignment1/3-NoLabel';
path1 = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI-SEM2/Emedded_Image/Assignment1/6-CapMissing';
rng(10);
[c1,c2,c3,c4,c5]= deal(0);
imagefiles = dir(fullfile(path,'*.jpg'));
for i=1:numel(imagefiles)
    filename = fullfile(path,imagefiles(i).name);
    I = imread(filename);
    I = rgb2gray(I);
    for j=1:6
        switch j            
            case 1
                J1 = imnoise(I,'gaussian',0,0.5);
                nolabel=labelmiss(J1);    
                if nolabel
                    c1 = c1 + 1;
                end
            case 2
                J2 = imnoise(I,'gaussian',0,0.7);
                nolabel=labelmiss(J2);    
                if nolabel
                    c2 = c2 + 1;
                end
            case 3
                J3 = imnoise(I,'gaussian',0,0.8);
                nolabel=labelmiss(J3);    
                if nolabel
                    c3 = c3 + 1;
                end
            case 4
                J4 = imnoise(I,'gaussian',0,0.9);
                nolabel=labelmiss(J4);    
                if nolabel
                    c4 = c4 + 1;
                end
            case 5
                J5 = imnoise(I,'gaussian',0,1);
                nolabel=labelmiss(J5);    
                if nolabel
                    c5 = c5 + 1;
                end
        end
                
    end

end
fprintf('No Label \n');
a1 = c1 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 0.5 is : %d \n',a1);
a2 = c2 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 0.7 is : %d \n',a2);
a3 = c3 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 0.8 is : %d \n',a3);
a4 = c4 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 0.9 is : %d \n',a4);
a5 = c5 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 1 is : %d \n',a5);
%}
% No Cap
[c1,c2,c3,c4,c5]= deal(0);
imagefiles1 = dir(fullfile(path1,'*.jpg'));
for i=1:numel(imagefiles1)
    filename = fullfile(path1,imagefiles1(i).name);
    I = imread(filename);
    I = rgb2gray(I);
    for j=1:6
        switch j            
            case 1
                J1 = imnoise(I,'gaussian',0,0);
                nocap=capmissing(J1);    
                if nocap
                    c1 = c1 + 1;
                end
            case 2
                J2 = imnoise(I,'gaussian',0,0.1);
                nocap=capmissing(J2);    
                if nocap
                    c2 = c2 + 1;
                end
            case 3
                J3 = imnoise(I,'gaussian',0,0.13);
                nocap=capmissing(J3);    
                if nocap
                    c3 = c3 + 1;
                end
            case 4
                J4 = imnoise(I,'gaussian',0,0.17);
                nocap=capmissing(J4);    
                if nocap
                    c4 = c4 + 1;
                end
            case 5
                J5 = imnoise(I,'gaussian',0,0.25);
                nocap=capmissing(J5);    
                if nocap
                    c5 = c5 + 1;
                end
        end
                
    end

end
fprintf('No Cap \n');
a1 = c1 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0 is : %d \n',a1);
a2 = c2 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.1 is : %d \n',a2);
a3 = c3 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.13 is : %d \n',a3);
a4 = c4 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.17 is : %d \n',a4);
a5 = c5 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.25 is : %d \n',a5);

X = [a1,a2,a3,a4,a5];
Y = [0,0.1,0.13,0.17,0.25];
plot (X,Y,'*','MarkerSize',10);
title('Performance of system with noise')
ylabel('Variance')
xlabel('Accuracy')

% PART 2
[c,c1,c2,c3]= deal(0);
imagefiles1 = dir(fullfile(path1,'*.jpg'));
for i=1:numel(imagefiles1)
    filename = fullfile(path1,imagefiles1(i).name);
    I = imread(filename);
    I = rgb2gray(I);
    J = imnoise(I,'gaussian',0,0.15);
    nocap=capmissing(J);    
    if nocap
        c = c + 1;
    end
    % Average spatial filtering
    h = fspecial('average',[5,5]);
    J2 = imfilter(J,h);
    nocap1=capmissing(J2);
    if nocap1
        c1 = c1 + 1;
    end
    %Gaussian spatial filtering
    h = fspecial('gaussian',[3,3],1);
    J3 = imfilter(J,h);
    nocap2=capmissing(J3);
    if nocap2
        c2 = c2 + 1;
    end
    % Frequency Domain filtering
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
    nocap1=capmissing(abs(IMG));
    if nocap1
        c3 = c3 + 1;
    end
     
end
a = c / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.15 is : %d \n',a);
fprintf('Part 2 Average Spacial filtering \n');
a1 = c1 / numel(imagefiles1) * 100;
fprintf('Accuracy after averaging spacial filter : %d \n',a1);
a2 = c2 / numel(imagefiles1) * 100;
fprintf('Accuracy after gaussian spacial filter : %d \n',a2);
a3 = c3 / numel(imagefiles1) * 100;
fprintf('Accuracy after frequency domain filter : %d \n',a3);


% frequency domain filtering of all variances for NO cap
[c1,c2,c3,c4,c5]= deal(0);
imagefiles1 = dir(fullfile(path1,'*.jpg'));
for i=1:numel(imagefiles1)
    filename = fullfile(path1,imagefiles1(i).name);
    I = imread(filename);
    I = rgb2gray(I);
    for j=1:6
        switch j            
            case 1
                J1 = imnoise(I,'gaussian',0,0);
                IMG = fd(J1);
                nocap1=capmissing1(abs(IMG));   
                if nocap1
                    c1 = c1 + 1;
                end
            case 2
                J2 = imnoise(I,'gaussian',0,0.1);
                IMG = fd(J2);
                nocap1=capmissing1(abs(IMG));    
                if nocap
                    c2 = c2 + 1;
                end
            case 3
                J3 = imnoise(I,'gaussian',0,0.13);
                IMG = fd(J3);
                nocap1=capmissing1(abs(IMG));    
                if nocap
                    c3 = c3 + 1;
                end
            case 4
                J4 = imnoise(I,'gaussian',0,0.17);
                IMG = fd(J4);
                nocap1=capmissing1(abs(IMG));   
                if nocap
                    c4 = c4 + 1;
                end
            case 5
                J5 = imnoise(I,'gaussian',0,0.25);
                IMG = fd(J5);
                nocap1=capmissing1(abs(IMG));    
                if nocap
                    c5 = c5 + 1;
                end
        end
                
    end

end
fprintf('No Cap \n');
a1 = c1 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0 is : %d \n',a1);
a2 = c2 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.1 is : %d \n',a2);
a3 = c3 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.13 is : %d \n',a3);
a4 = c4 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.17 is : %d \n',a4);
a5 = c5 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.25 is : %d \n',a5);

X = [a1,a2,a3,a4,a5];
Y = [0,0.1,0.13,0.17,0.25];
plot (X,Y,'*','MarkerSize',10);
title('Performance of system with noise')
ylabel('Variance')
xlabel('Accuracy')
% All Fault Functions


function LM = labelmiss(img)

%img = rgb2gray(img);

cropimg = img(160:250 , 110:240);

binary = imbinarize(cropimg,double(70/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));
pause(0.3);
LM = blackv >50 ;

end



function CM = capmissing(img)

%img = rgb2gray(img);

cropimg = img(5:60 , 140:220);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

pause(0.3);
CM = blackv < 30;

end

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


function CM = capmissing1(img)

%img = rgb2gray(img);

cropimg = img(5:60 , 140:220);

binary = imbinarize(cropimg,120);

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

pause(1);
CM = blackv < 30;

end


