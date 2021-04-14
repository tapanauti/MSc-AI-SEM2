%take input of all images from file 

path1 = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI-SEM2/Emedded_Image/Assignment1/6-CapMissing';
rng(10);

% No Cap
c=0;
imagefiles1 = dir(fullfile(path1,'*.jpg'));
for i=1:numel(imagefiles1)
    filename = fullfile(path1,imagefiles1(i).name);
    I = imread(filename);
    J = imnoise(I,'gaussian',0,0.3);
    imshow(J);
    nocap=capmissing(J);    
    if nocap
        c = c + 1;
    end
     
end
a = c / numel(imagefiles1) * 100;
fprintf('Accuracy for noise of variance 0.3 is : %d \n',a);
%  Fault Functions


function CM = capmissing(img)

img = rgb2gray(img);

cropimg = img(5:60 , 140:220);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

pause(0.5);
CM = blackv < 30;

end



