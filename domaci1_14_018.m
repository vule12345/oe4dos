% OE4DOS First homework 11/12/2017
% Student : Vuk Vukomanovic 2014/0018
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

% Input image
disp('Reading image')
street = imread('ulazne_slike/street.tif');
figure
imshow(street);
set(gcf, 'Name', 'Ulazna slika');
title('Ulazna slika','Interpreter','LaTex','FontSize',16),grid on

% Greyscale 
street_gray = rgb2gray(street);

% Histogram of input image
street_hist = imhist(street_gray);
figure;
bar(street_hist/numel(street_gray));
set(gcf, 'Name', 'Histogram ulazne slike');
title('Histogram ulazne slike','Interpreter','LaTex','FontSize',16),grid on

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

% Logarithmic contrast enhancement
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
disp('First part of homework end here.')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%