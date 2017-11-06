% OE4DOS First homework 11/12/2017
% Student : Vuk Vukomanovic 2014/0018
% Git: 
% This script contains first 4 tasks
clear
clc
close all
warning('off', 'images:initSize:adjustingMag')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. 
% Enhance contrast of image ,,street.tif,, with various methods.
% Report holds explanations of why certain method were used
% In first part of code methods are used in RGB picture, in second half all
% methods are used in LAB picture and than convereted back to RGB

disp('First part of homework starts here.');
% Input image
disp('Reading ,street.tif,, image')
street = imread('ulazne_slike/street.tif');
figure
imshow(street);
set(gcf, 'Name', 'Ulazna slika, street');
title('Ulazna slika','Interpreter','LaTex','FontSize',16),grid on

% Greyscale 
street_gray = rgb2gray(street);

% Histogram of input image
street_hist = imhist(street_gray);
figure;
bar(street_hist/numel(street_gray));
set(gcf, 'Name', 'Histogram ulazne slike, street');
title('Histogram ulazne slike','Interpreter','LaTex','FontSize',16),grid on
xlabel('Vrednost piskela','Interpreter','LaTex','FontSize',16)

%Scaling image
street_scaled = mat2gray(street);
%%% 1.a : RGB image
disp('RGB image processing');

% Logarithmic contrast enhancement
k=100;
street_log = im2uint8(log(1+k*street_scaled)/log(k));
figure
imshow(street_log);
set(gcf, 'Name', 'Slika nakon upotrebe log-a');
title('Slika nakon upotrebe log-a','Interpreter','LaTex','FontSize',16),grid on

% Gamma contrast enhancement
gamma = 0.4;
street_gamma = street_scaled.^gamma;
figure
imshow(street_gamma)
set(gcf, 'Name', 'Slika nakon upotrebe gamma metode');
title('Slika nakon upotrebe gamma metode','Interpreter','LaTex','FontSize',16),grid on

% Histogram equalization
street_eq_hist = histeq(street_scaled);
figure
imshow(street_eq_hist)
set(gcf, 'Name', 'Slika nakon upotrebe ekvalizacije histograma');
title('Slika nakon upotrebe ekvalizacije histograma','Interpreter','LaTex','FontSize',16),grid on
figure
equ_histogram = imhist(street_eq_hist);
bar(equ_histogram/numel(street_eq_hist))
title('Histogram nakon ekvalizacije','Interpreter','LaTex','FontSize',16),grid on
xlabel('Vrednost piskela','Interpreter','LaTex','FontSize',16)

%%% 1.b : LAB image
disp('Lab image processing, this may take a while...')
% Converting from RGB to Lab
street_lab =rgb2lab(street_scaled,'ColorSpace','adobe-rgb-1998');
max_luminosity = 100;
L = street_lab(:,:,1)/max_luminosity;

% Logarithmic contrast enhancement
street_lab_log = street_lab;
street_lab_log(:,:,1) =log(1+50*L)/log(51)*max_luminosity;
street_lab_log = lab2rgb(street_lab_log,'ColorSpace','adobe-rgb-1998');
figure
imshow(street_lab_log);
set(gcf, 'Name', 'Slika nakon upotrebe log-a na Lab slici');
title('Slika nakon upotrebe log-a na Lab slici','Interpreter','LaTex','FontSize',16)

% Gamma contrast enhancement
street_lab_gamma = street_lab;
street_lab_gamma (:,:,1) = (L.^0.35)*max_luminosity;
street_lab_gamma  = lab2rgb(street_lab_gamma ,'ColorSpace','adobe-rgb-1998');
figure
imshow(street_lab_gamma);
set(gcf, 'Name', 'Slika nakon upotrebe gamma metode na Lab slici');
title('Slika nakon upotrebe gamma metode na Lab slici','Interpreter','LaTex','FontSize',16)

% Histogram equalization
street_lab_eq = street_lab;
street_lab_eq (:,:,1) = histeq(L)*max_luminosity;
street_lab_eq  = lab2rgb(street_lab_eq ,'ColorSpace','adobe-rgb-1998');
figure
imshow(street_lab_eq);
set(gcf, 'Name', 'Slika nakon upotrebe gamma metode na Lab slici');
title('Slika nakon upotrebe gamma metode na Lab slici','Interpreter','LaTex','FontSize',16)
disp('First part of homework ends here.')

% Write to fail and calculate variance
std_deviation = sqrt(var(double(street_log(:))));
disp("Standardn deviation of contrast enhanced image :")
disp(std_deviation)

imwrite(street_log,'izlazne_slike/street_out.jpg', 'Quality',100);

% Histogram of output image
bar(imhist(street_log)/numel(street_log));
set(gcf, 'Name', 'Histogram izlazne slike');
title('Histogram izlazne slike','Interpreter','LaTex','FontSize',16)
xlabel('Vrednost piskela','Interpreter','LaTex','FontSize',16)

disp('First part of homework ends here.')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2. Sharpen image ,,lange.jpg,, with various methods to find best one
% Report holds explanations of why certain method were used

disp('Second part of homework starts here.')

% Input image
disp('Reading image')
lange = double(imread('ulazne_slike/lange.jpg'));
disp('Processing')
figure
imshow(lange/255);
set(gcf, 'Name', 'Ulazna slika, lange');
title('Ulazna slika, lange','Interpreter','LaTex','FontSize',16)

% Low pass filter method
low_pass_mask = fspecial('average',5);
lange_low_freq = imfilter(lange, low_pass_mask, 'replicate');
lange_high_pass = lange - lange_low_freq;
k=1;
lange_filtered = uint8(lange + k*lange_high_pass);
figure
imshow(lange_filtered);
set(gcf, 'Name', 'Low pass filter metoda');
title('Low pass filter metoda','Interpreter','LaTex','FontSize',16)


% Laplacian filter methods
laplacian_mask =  [0 1 0; 1 -4 1; 0 1 0];
lange_laplacian_edge = imfilter(lange, laplacian_mask, 'replicate');
lange_laplacian = uint8(lange + lange_laplacian_edge);
figure
imshow(lange_laplacian);
set(gcf, 'Name', 'Laplacian filter');
title('Laplacian filter','Interpreter','LaTex','FontSize',16)


% Sobel-gradient method

% Calculting gradient
sobel = [-1 0 1; -2 0 2; -1 0 1];
lange_sobel =  imfilter(lange, sobel, 'replicate');
figure
imshow(lange_sobel, []);
set(gcf, 'Name', 'Sobel gradient ulazne slike');
title('Sobel gradient ulazne slike','Interpreter','LaTex','FontSize',16)

% Smoothing gradient response
low_pass_mask_1 = fspecial('average',10);
lange_sobel_low = imfilter(lange_sobel, low_pass_mask_1, 'replicate');

figure
imshow(lange_sobel_low,[]);
set(gcf, 'Name', 'Usrednjen gradient');
title('Usrednjen gradient','Interpreter','LaTex','FontSize',16)

temp_lange = mat2gray(lange_sobel_low)*255;

% Adding image with images to original image
lange_sobel_result = im2uint8(mat2gray(lange+temp_lange));
figure
imshow(lange_sobel_result);
set(gcf, 'Name', 'Slika nakon sabiranja pocente slike i dobijeng rezultata');
title('Slika nakon sabiranja','Interpreter','LaTex','FontSize',16)

lange_sobel_result = imadjust(lange_sobel_result);
figure
imshow(lange_sobel_result)
set(gcf, 'Name', 'Slika nakon porpravke kontrasta');
title('Slika nakon porpravke kontrasta','Interpreter','LaTex','FontSize',16)

imwrite(lange_sobel_result,'izlazne_slike/lange_sharp.jpg', 'Quality',100);

disp('Second part of homework ends here.')