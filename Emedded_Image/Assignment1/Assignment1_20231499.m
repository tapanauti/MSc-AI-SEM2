<<<<<<< HEAD
%take input of all images from file.
=======
%take input of all images from file 
>>>>>>> 512cb7f
path = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI/Emedded_Image/Assignment1/All';

%get file path for each image
imagefiles = dir(fullfile(path,'*.jpg'));

% for each image check the faults
for i=1:numel(imagefiles)
    filename = fullfile(path,imagefiles(i).name);
    I = imread(filename);
    nobottle=bottlemissing(I);
    name= fprintf('%s: ', filename);
    c = 0;
    %Missing Bottle
    if nobottle
        fprintf('No Fault - Bottle Missing ');
        c = c + 1;
    else
        % Bottle Underfilled
        underfill=underfilled(I);
        if underfill
            fprintf('bottle underfilled, ');
            c = c + 1;
        end
        
        %Cap Missing
        capmiss=capmissing(I);
        if capmiss
            fprintf('cap not present, ');
            c = c + 1;
        end
        
        %All label related faults
        labelmissing=labelmiss(I);
        if labelmissing
            fprintf('bottle underfilled, ');
            c = c + 1;
        else
            notprinted=labelnotprinted(I);
            if labelmissing
                fprintf(' label not printed, ');
                c = c + 1;
            else
                notstraight=labelnotstraight(I);
                if notstraight
                    fprintf('label not straight, ');
                    c = c + 1;
                end                
            end
        end
        
        % Bottle Deformed
        deform=bottledeformed(I);
        overfill=overfilled(I);
        if deform
            fprintf('deformed, ');
            c = c + 1;
            %if bottle deformed it should not detect overfill
            overfill = 0; 
        end
        
        %Bottle Overfill
        if overfill
            fprintf('bottle overfilled, ');
            c = c + 1;
        end   
    end
    if c==0
        fprintf('No Faults Detected, ');
    end
    fprintf('\n');
end

% All Fault Functions
function UF = underfilled(img)

img = rgb2gray(img);

cropimg = img(110:180 , 110:220);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));
pause(0.3);
UF = blackv <30 ;

end

function OF = overfilled(img)

img = rgb2gray(img);

cropimg = img(90:180 , 110:240);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));
pause(0.3);
OF = blackv >50 ;

end

function LM = labelmiss(img)

img = rgb2gray(img);

cropimg = img(160:250 , 110:240);

binary = imbinarize(cropimg,double(70/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));
pause(0.3);
LM = blackv >50 ;

end

function LN = labelnotprinted(img)

img = rgb2gray(img);

cropimg = img(190:270 , 110:240);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));
pause(0.3);
LN = blackv <50 ;

end

function LNS = labelnotstraight(img)

img = rgb2gray(img);

cropimg = img(175:200 , 110:240);

binary = imbinarize(cropimg,double(70/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

pause(0.3);
LNS = blackv > 37;

end

function CM = capmissing(img)

img = rgb2gray(img);

cropimg = img(5:60 , 140:220);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

pause(0.3);
CM = blackv < 30;

end

function DF = bottledeformed(img)

img = rgb2gray(img);

cropimg = img(150:280 , 120:260);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

DF = blackv >72 ;

end

function BM = bottlemissing(img)

img = rgb2gray(img);

cropimg = img(5:280 , 110:240);

binary = imbinarize(cropimg,double(140/256));

blackv = 100 * (sum(binary(:) == 0) / numel(binary(:)));

BM = blackv < 40 ;

end
