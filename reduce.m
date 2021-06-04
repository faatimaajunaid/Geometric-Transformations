
function [output_averaging,output_median,output_decimation] = reduce(inputfile,new_x, new_y)  
%inputfile = 'cameraman.tif'; 
%inputfile = 'coins.png'; 
%inputfile = 'moon.tif'; 
% inputfile = 'liftingbody.png'; 

A = imread(inputfile);
[rows,columns,dim] = size(A);

% new_x = 128;
% new_y = 256;

x_factor = rows/new_x;
y_factor = columns/new_y;
for i=1:rows
    for j=1:columns
        output_averaging(i,j) = 0;
        output_median(i,j) = 0;
        output_decimation(i,j) = 0;
    end
end

for i=1:new_y
    for j=1:new_x
        temp = A(y_factor*(i-1)+1:y_factor*i,x_factor*(j-1)+1:x_factor*j);
        temp = double(temp);
        temp = temp(:);%vectorize the matrix
        output_median(i,j) = median(temp);
        output_averaging(i,j) = mean(temp);
        output_decimation(i,j) = temp(1);
    end
end

output_median=uint8(output_median);
output_averaging=uint8(output_averaging);
output_decimation=uint8(output_decimation);

outstr1=strcat('averaging_',inputfile);
imwrite(output_averaging,outstr1);
title(outstr1);
outstr2=strcat('median_',inputfile);
imwrite(output_median,outstr2);
title(outstr2);
outstr3=strcat('decimation_',inputfile);
imwrite(output_decimation,outstr3);
title(outstr3);


end
