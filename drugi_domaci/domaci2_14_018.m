% OE4DOS Second assignment 11/2017
% Student : Vuk Vukomanovic 2014/0018
% This script contains all sub tasks
% Assigment : http://tnt.etf.rs/~oe4dos/Domaci_zadaci/dos1718_domaci2.pdf
clear
clc
close all
warning('off', 'images:initSize:adjustingMag')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Report holds explanations of why certain method were used

% %% 1. Restauration image girl_print.tif. Image represents digitalized
% % printed image.
% disp('First part of assignment starts here')
% 
% % Loading image
% girl_print = double(imread('ulazne_slike/girl_print.jpg'));
% disp('Girl_print.jpg loaded, processing image')
% 
% % Showing image
% figure
% imshow(girl_print,[]);
% set(gcf, 'Name', 'Ulazna slika, girl_print');
% 
% % Getting image size
% [M, N] = size(girl_print);
% 
% % Calculating FFT of input image
% girl_print_spectrum = fft2(girl_print);
% 
% % Showing image ampl spectrum
% figure;
% imshow(log(1 + abs(fftshift(girl_print_spectrum))),[]);
% set(gcf, 'Name', 'Spektar ulazne slike, girl_print');
% 
% % Selective filtering with notch filter, cnotch funcion is used
% 
% % Centre points of filters
% C1 = [60 36; 100 134; 231 104; 361 76; 404 174;495 45; 508 163; 219 26];
% 
% C2 = [469 65; 86 54; 465 37];
% 
% % Creation of filters
% H_gaussian_big = cnotch('gaussian', 'reject', M, N, C1, 50);
% 
% H_gaussian_small = cnotch('gaussian', 'reject', M, N, C2, 5);
% 
% H_gaussian = H_gaussian_big.*H_gaussian_small;
% 
% % Showing filter ampl spectrum
% figure; 
% imshow(log(1 + abs(fftshift(H_gaussian))),[]);
% set(gcf, 'Name', 'Spektar noc filtra');
% 
% % Convolution
% filtered_spectrum_gaussian = H_gaussian.*girl_print_spectrum;
% 
% % Spectrum after convlution
% figure; 
% imshow(log(1 + abs(fftshift(filtered_spectrum_gaussian))),[]);
% set(gcf, 'Name', 'Spektar nakon filtriranja');
% 
% 
% % Inverse fft, getting back in spatial domain
% girl_print_filtered = ifft2(filtered_spectrum_gaussian);
% 
% figure; 
% imshow(uint8(girl_print_filtered));
% set(gcf, 'Name', 'Slika nakon filtriranja');
% disp('First part of homework ends here');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% 2. Usage of funcion dos_downscale on image roof.jpg
% disp('Second part of homework starts here')
% house = double(imread('ulazne_slike/roof.jpg'));
% 
% % Resizing image by factor 2 with dos_downscale
% smaller_house_2 = dos_downscale(house, 0.5);
% 
% % Resizing image by factor 4 with dos_downscale
% smaller_house_4 = dos_downscale(house, 0.25);
% 
% % Resizing image by factor 7 with dos_downscale
% smaller_house_7 = dos_downscale(house, 1/7);
% 
% figure; 
% imshow(house,[]);
% set(gcf, 'Name', 'Originalna slika, roof');
% 
% figure; 
% imshow(smaller_house_2,[]);
% set(gcf, 'Name', 'Slika nakon decimacije, dos_downscale, faktor 2');
% 
% figure; 
% imshow(smaller_house_4,[]);
% set(gcf, 'Name', 'Slika nakon decimacije, dos_downscale, faktor 4');
% 
% figure; 
% imshow(smaller_house_7,[]);
% set(gcf, 'Name', 'Slika nakon decimacije, dos_downscale, faktor 7');
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%
% % Nearest neighbour resize
% 
% % Resizing image by factor 2 with imresize('nearest')
% smaller_house_2_im_off = imresize(house, 0.5, 'nearest', 'Antialiasing', false);
% 
% % Resizing image by factor 4 with imresize('nearest')
% smaller_house_4_im_off = imresize(house, 0.25, 'nearest', 'Antialiasing', false);
% 
% % Resizing image by factor 8 with imresize('nearest')
% smaller_house_7_im_off = imresize(house, 1/7, 'nearest', 'Antialiasing', false);
% 
% figure; 
% imshow(smaller_house_2_im_off,[]);
% set(gcf, 'Name', 'Imresize, nearest, antialiasing off faktor 2');
% 
% figure; 
% imshow(smaller_house_4_im_off,[]);
% set(gcf, 'Name', 'Imresize, nearest, antialiasing off faktor 4');
% 
% figure; 
% imshow(smaller_house_7_im_off,[]);
% set(gcf, 'Name', 'Imresize, nearest, antialiasing off faktor 7');
% 
% % Resizing image by factor 2 with imresize('nearest')
% smaller_house_2_im_off = imresize(house, 0.5, 'nearest', 'Antialiasing', true);
% 
% % Resizing image by factor 4 with imresize('nearest')
% smaller_house_4_im_off = imresize(house, 0.25, 'nearest', 'Antialiasing', true);
% 
% % Resizing image by factor 8 with imresize('nearest')
% smaller_house_7_im_off = imresize(house, 1/7, 'nearest', 'Antialiasing', true);
% 
% figure; 
% imshow(smaller_house_2_im_off,[]);
% set(gcf, 'Name', 'Imresize, nearest, antialiasing on faktor 2');
% 
% figure; 
% imshow(smaller_house_4_im_off,[]);
% set(gcf, 'Name', 'Imresize, nearest, antialiasing on faktor 4');
% 
% figure; 
% imshow(smaller_house_7_im_off,[]);
% set(gcf, 'Name', 'Imresize, nearest, antialiasing on faktor 7');
% 
% %%%%%%%%%%%%%%%%%%
% % Bilinear resize
% 
% % Resizing image by factor 2 with imresize('bilinear')
% smaller_house_2_im_off = imresize(house, 0.5, 'bilinear', 'Antialiasing', false);
% 
% % Resizing image by factor 4 with imresize('bilinear')
% smaller_house_4_im_off = imresize(house, 0.25, 'bilinear', 'Antialiasing', false);
% 
% % Resizing image by factor 8 with imresize('bilinear')
% smaller_house_7_im_off = imresize(house, 1/7, 'bilinear', 'Antialiasing', false);
% 
% figure; 
% imshow(smaller_house_2_im_off,[]);
% set(gcf, 'Name', 'Imresize, bilinear, antialiasing off faktor 2');
% 
% figure; 
% imshow(smaller_house_4_im_off,[]);
% set(gcf, 'Name', 'Imresize, bilinear, antialiasing off faktor 4');
% 
% figure; 
% imshow(smaller_house_7_im_off,[]);
% set(gcf, 'Name', 'Imresize, bilinear, antialiasing off faktor 7');
% 
% 
% % Resizing image by factor 2 with imresize('bilinear')
% smaller_house_2_im_off = imresize(house, 0.5, 'bilinear', 'Antialiasing', true);
% 
% % Resizing image by factor 4 with imresize('bilinear')
% smaller_house_4_im_off = imresize(house, 0.25, 'bilinear', 'Antialiasing', true);
% 
% % Resizing image by factor 8 with imresize('bilinear')
% smaller_house_7_im_off = imresize(house, 1/7, 'bilinear', 'Antialiasing', true);
% 
% figure; 
% imshow(smaller_house_2_im_off,[]);
% set(gcf, 'Name', 'Imresize, bilinear, antialiasing on faktor 2');
% 
% figure; 
% imshow(smaller_house_4_im_off,[]);
% set(gcf, 'Name', 'Imresize, bilinear, antialiasing on faktor 4');
% 
% figure; 
% imshow(smaller_house_7_im_off,[]);
% set(gcf, 'Name', 'Imresize, bilinear, antialiasing on faktor 7');
% disp('Second part of homework starts here')





