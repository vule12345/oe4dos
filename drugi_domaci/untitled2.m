clear
clc
close all
% 
% house = double(imread('ulazne_slike/roof.jpg'));
% 
% figure
% imshow(house,[]);
% 
% 
% 
% 
% scale_factor = 0.5;
% 
% % Filtering image to prevent anti-aliasing
% input = double(house);
% [old_M, old_N] = size(input);
% P = 2*old_M-1; Q = 2*old_N-1;
% 
% % Spectrum of input image
% input_spectrum = fftshift(fft2(input, P, Q));
% 
% % Low pass filter
% D0 = max(old_M,old_N)/(scale_factor)/2;
% H = lpfilter('gaussian', P, Q, D0);
% H = fftshift(H);
% 
% % Convolution
% Gp = input_spectrum.*H;
% 
% % Back to spatial domain
% input = ifft2(ifftshift(Gp));
% 
% 
% % Calculating size of new image
% new_M = floor(scale_factor*old_M);
% new_N = floor(scale_factor*old_N);
% 
% % Allocating memory of output image
% output = zeros(new_M, new_N);
% 
% % Indices of new scaled image
% new_rows = (1:new_M);
% new_columns = (1:new_N);
% 
% % Calculating nearest indices to original image
% old_rows = round( (new_rows-1)*(old_M-1)/(scale_factor*old_M-1)+1 );
% old_columns = round( (new_columns-1)*(old_N-1)/(scale_factor*old_N-1)+1 );
% 
% % Applying 
% output(new_rows,new_columns) = input(old_rows,old_columns);
% 
% 
% 
% figure
% imshow(output,[])


% Reading blurred image
etf = double(imread('ulazne_slike/etf_blur.tif'));

% Reading motion 
motion = double(imread('ulazne_slike/kernel.tif'));

% Show input image
figure
imshow(etf,[])
set(gcf, 'Name', 'Ulazna zamucena slika, etf');

% Show motion
figure
imshow(motion,[]);
set(gcf, 'Name', 'Pokret');

%Size of input image
[M, N] = size(etf);

% Size for caclulating  spectrum
P = 2*M-1; Q = 2*N-1;

% Calculating spectrum of input image
etf_spectrum = fftshift(fft2(etf, P, Q));

% Calculating spectrum of motion
motion_spectrum = fftshift(fft2(motion, P, Q));

% Wiener filter
% Conastant for Wiener's filter
K = 1e-4;
W = (abs(motion_spectrum).^2)./(abs(motion_spectrum).^2 + K);

% Filtering
result_spectrum = (etf_spectrum./motion_spectrum).*W;

figure
imshow(log(1+abs(result_spectrum)),[]);
set(gcf, 'Name', 'Spektar slike nakon uklanjanja degradacije usled pokreta');

% Inverse fourirer transofrmation
result_estimate = ifft2(ifftshift(result_spectrum));

% Cutting image to right dimesnions
result_estimate = result_estimate(1:M, 1:N);
result_estimate = result_estimate(1:532, 1:800);

% Show image after removing motion blur
figure
imshow(result_estimate,[])
set(gcf, 'Name', 'Slika nakon uklanjanja degradacije usled pokreta');

% After Wiener's filter additional methods were used

%%%%%%%%%%%%%%%%%%%%%%%%
%%1.Simple low pass filter

% H = lpfilter('gaussian', P, Q, 150);
% H = fftshift(H);
% figure; 
% imshow(log(1+abs(H)), []);
% set(gcf, 'Name', 'Spektar koriscenog low pass filtra');
% 
% % Konvolucija u frek domenu
% Gp = result_spectrum.*H;
% figure; 
% imshow(log(1+abs(Gp)), []);
% set(gcf, 'Name', 'Spektar nakon filtriranja sa low pass filtrom');
% gp = ifft2(ifftshift(Gp));
% g = gp(1:M, 1:N);
% 
% figure; 
% imshow(g(1:532, 1:800),[]);
% set(gcf, 'Name', 'Slika nakon filtriranja sa low pass filtrom');


% %%%%%%%%%%%%%%%%%%%%%%%%
% %%2. Adaptive local averaging
% 
% % Variance of noise , empirically calculated by finding unifrom polygon on
% % image
% nvar = 2.2484e-06;
% low_pass_filter = fspecial('average', [7,7]);
% gavg = imfilter(result_estimate, low_pass_filter, 'replicate');
% gsqr_avg = imfilter(result_estimate.^2, low_pass_filter, 'replicate');
% gvar = gsqr_avg - gavg.^2;
% w = nvar./gvar;
% w(w>1)=1;
% result_averageg = result_estimate + w.*(gavg - result_estimate);
% figure; 
% imshow(result_averageg(1:532, 1:800),[]);
% set(gcf, 'Name', 'Slika nakon filtriranja sa adaptivnim usrednjavanjem');

% %%%%%%%%%%%%%%%%%%%%%%%%
% % %% 3. Creating cross filter
% fil =zeros(P,Q);
% % Widht of rectangles
% coeff=30;
% 
% % Rectangle part
% fil((uint16(P/2)-coeff):(uint16(P/2)+coeff), uint16(Q/4):uint16(Q*3/4)) = 1;
% fil(uint16(P/4):uint16(P*3/4), uint16(Q/2)-coeff:(uint16(Q/2)+coeff)) = 1;
% 
% % Gaussian in the middle
% H = lpfilter('gaussian', P, Q, 150);
% H = fftshift(H);
% 
% % Creation of cross
% cross_filter = H +fil;
% cross_filter(cross_filter>1) = 1;
% 
% % Show filter spectrum
% figure
% imshow(log(1+abs(cross_filter)),[]);
% set(gcf, 'Name', 'Custom krst filter');
% 
% % Convolution
% cross_spectrum = result_spectrum.*cross_filter;
% 
% % Show filtered spectrum
% figure
% imshow(log(1+abs(cross_spectrum)),[]);
% set(gcf, 'Name', 'Custom krst filter');
% 
% % Inverse FFT 
% cross_spatial = ifft2(ifftshift(cross_spectrum));
% 
% figure
% imshow(cross_spatial(1:532, 1:800),[]);
% set(gcf, 'Name', 'Rezultat uklanja koriscenjem krst filtra');


















