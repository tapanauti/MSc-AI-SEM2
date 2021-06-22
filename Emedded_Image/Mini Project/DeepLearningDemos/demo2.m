%{
path = 'C:\Users\CS-Guest-2\Desktop\Nuig\MSc_AI\MSc-AI\Embeded_Image\stress';
imagefiles = dir(fullfile(path,'*.TIF'));
for i=1:length(imagefiles)
    filename = fullfile(path,imagefiles(i).name);
    I = imread(filename);  
    [centers,radii] = imfindcircles(I,[9 70],'ObjectPolarity','bright', ...
    'Sensitivity',0.82);   
    imshow(I)  
    drawnow
    h = viscircles(centers,radii);
    pause(1)    
end
%}


path = 'C:\Users\CS-Guest-2\Desktop\Nuig\MSc_AI\MSc-AI\Embeded_Image\stress';
imagefiles = dir(fullfile(path,'*.TIF'));
for i=1:length(imagefiles)
    filename = fullfile(path,imagefiles(i).name);
    I = imread(filename);  
    [centers,radii] = imfindcircles(I,[9 70],'ObjectPolarity','bright', ...
    'Sensitivity',0.82);   
    pause(1) 
    if centers >0
        x = centers(1) - (1.5 * radii);
        X = 70;
        y = centers(2) - (1.5 * radii);
        Y = 70;
        img = imcrop(I,[x y X Y]);
        imshow(img);
        pause(1)
    end
     
end

