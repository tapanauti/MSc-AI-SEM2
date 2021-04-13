%take input of all images from file - ref = https://in.mathworks.com/matlabcentral/answers/135030-how-to-read-and-display-multiple-images-from-folder

path = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI/Emedded_Image/Assignment1/3-NoLabel';

imagefiles = dir(fullfile(path,'*.jpg'));
for i=1:numel(imagefiles)
    filename = fullfile(path,imagefiles(i).name);
    I = imread(filename);
    J = imnoise(I,'gaussian',0,0.6);
    nobottle=labelmiss(J);    
    if nobottle
        print = fprintf('%s: ', path) + fprintf('underfilled');
    else
        print = fprintf('%s: ', path) + fprintf('No faults');
    end
    fprintf('\n');
    imshow(J)


end

% All Fault Functions

function LM = labelmiss(img)

img = rgb2gray(img);

cropimg = img(160:250 , 110:240);

binary = imbinarize(cropimg,double(70/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));
pause(0.3);
LM = blackv >50 ;

end

%{

function CM = capmissing(img)

img = rgb2gray(img);

cropimg = img(5:60 , 140:220);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

pause(0.3);
CM = blackv < 30;

end

%}

