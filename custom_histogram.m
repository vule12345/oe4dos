function result = custom_histogram(img, depth)
%custom_histogram Funcion for calcuting histogram od input image.
%   Function takes 2 arguments. First argument img is integer type image
%   with values in range [0,1]. Second arugment depth represents range of
%   bins in histogram(value in image).

%img = uint16(round(double(img*depth)));

result = zeros(1,depth);

for bin=1:depth+1
    
    result(bin) = sum(img(:)== (bin-1));
    
end

end

