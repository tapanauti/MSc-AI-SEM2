path = 'C:/Users/CS-Guest-2/Desktop/Nuig/MSc_AI/MSc-AI/Emedded_Image/Assignment1/7-DeformedBottle/deformedbottle-image008.jpg';
img = imread(path);
img = rgb2gray(img);

cropimg = img(150:280 , 120:260);

binary = imbinarize(cropimg,double(140/256));

figure

%a=imshow(binary);
b= imshow(cropimg)
fprintf('\n');

<<<<<<< HEAD
% ok
=======
>>>>>>> 512cb7f
