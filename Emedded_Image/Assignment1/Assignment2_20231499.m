%take input of all images from file 

path = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI-SEM2/Emedded_Image/Assignment1/3-NoLabel';
path1 = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI-SEM2/Emedded_Image/Assignment1/6-CapMissing';
rng(10);
[c1,c2,c3,c4,c5]= deal(0);
imagefiles = dir(fullfile(path,'*.jpg'));
for i=1:numel(imagefiles)
    filename = fullfile(path,imagefiles(i).name);
    I = imread(filename);
    for j=1:6
        switch j            
            case 1
                J1 = imnoise(I,'gaussian',0,0);
                nolabel=labelmiss(J1);    
                if nolabel
                    c1 = c1 + 1;
                end
            case 2
                J2 = imnoise(I,'gaussian',0,0.3);
                nolabel=labelmiss(J2);    
                if nolabel
                    c2 = c2 + 1;
                end
            case 3
                J3 = imnoise(I,'gaussian',0,0.55);
                nolabel=labelmiss(J3);    
                if nolabel
                    c3 = c3 + 1;
                end
            case 4
                J4 = imnoise(I,'gaussian',0,0.6);
                nolabel=labelmiss(J4);    
                if nolabel
                    c4 = c4 + 1;
                end
            case 5
                J5 = imnoise(I,'gaussian',0,0.7);
                nolabel=labelmiss(J5);    
                if nolabel
                    c5 = c5 + 1;
                end
        end
                
    end

end
fprintf('No Label \n');
a1 = c1 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 0 is : %d \n',a1);
a2 = c2 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 0.3 is : %d \n',a2);
a3 = c3 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 0.55 is : %d \n',a3);
a4 = c4 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 0.6 is : %d \n',a4);
a5 = c5 / numel(imagefiles) * 100;
fprintf('Accuracy for noise of variance 0.7 is : %d \n',a5);
%}
% No Cap
[c1,c2,c3,c4,c5]= deal(0);
imagefiles1 = dir(fullfile(path1,'*.jpg'));
for i=1:numel(imagefiles1)
    filename = fullfile(path1,imagefiles1(i).name);
    I = imread(filename);
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
                J3 = imnoise(I,'gaussian',0,0.2);
                nocap=capmissing(J3);    
                if nocap
                    c3 = c3 + 1;
                end
            case 4
                J4 = imnoise(I,'gaussian',0,0.25);
                nocap=capmissing(J4);    
                if nocap
                    c4 = c4 + 1;
                end
            case 5
                J5 = imnoise(I,'gaussian',0,0.3);
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
fprintf('Accuracy for noise of variance 0.2 is : %d \n',a3);
a4 = c4 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.25 is : %d \n',a4);
a5 = c5 / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.3 is : %d \n',a5);
% All Fault Functions


function LM = labelmiss(img)

img = rgb2gray(img);

cropimg = img(160:250 , 110:240);

binary = imbinarize(cropimg,double(70/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));
pause(0.3);
LM = blackv >50 ;

end



function CM = capmissing(img)

img = rgb2gray(img);

cropimg = img(5:60 , 140:220);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

pause(0.3);
CM = blackv < 30;

end



