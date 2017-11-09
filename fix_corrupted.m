function fixed_image = fix_corrupted( corrupted_image , display)
%fix_corrupted Fixes grayscales image with pre defined distorsions
%   B = fix_corrupted(A) transfroms the input grayscale image so that all
%   predefined distortions are removed. Output B is also grayscale image
%   with intensity of pixels [0,255].
%
%   B = fix_corrupted(A,'on') transfroms the input grayscale image so that all
%   predefined distortions are removed. Second parametar specifes if image
%   and all of it's steps will imshow in separate window. Defaul value of
%   display is 'off'
%
%   Example
% ----------
%   B = fix_corrupted(A,'on')

if ~exist('display','var')
     % third parameter does not exist, so default it to something
      display = 42;
end


% Removing salt and papper noise with median filter;
impluse_noise_removed = medfilt2(corrupted_image, [5 5], 'symmetric');

% Making negative of filtered image
negative  = 255 - impluse_noise_removed;

% % Using laplacian to sharpen negative image
% laplacian_mask =  [0 1 0; 1 -4 1; 0 1 0];
% negative_laplacian_edge = imfilter(double(negative), laplacian_mask, 'replicate');
% negative_filtered = (double(negative) - negative_laplacian_edge);

low_pass_mask = fspecial('average', 1);
low_pass_response = imfilter(double(negative), low_pass_mask,'replicate');
high_pas_compontent = double(negative) - low_pass_response;
negative_filtered = uint8(double(negative) + high_pas_compontent);

negative_filtered = mat2gray(negative_filtered);

% Enhance contrast of sharpend image
%contrast_enhanced = histeq(negative_filtered, imhist(original1));
contrast_enhanced = uint8(imadjust(negative_filtered,[15 228]/255,[0 255]/255,1.2)*255);

fixed_image = contrast_enhanced;

if(display == 'on') 
    figure
    imshow(impluse_noise_removed);
    set(gcf, 'Name', 'Salt and papper noise removed');

    figure
    imshow(negative);
    set(gcf, 'Name', 'Negative image');

    figure
    imshow(negative_filtered);
    set(gcf, 'Name', 'Sharpened');

    figure
    imshow(im2uint8(contrast_enhanced));
    set(gcf, 'Name', 'Contrast enhancement');

end

end

