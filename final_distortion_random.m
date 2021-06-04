gridsize = 4;
inputfile = 'cameraman.tif'; 
%inputfile = 'moon.tif'; 
% inputfile = 'liftingbody.png'; 

A = imread(inputfile);

[rows,columns] = size(A);


for i=1:rows
    for j=1:columns
        output(i,j) = 0;        
    end
end





mesh_points_original_rows = [1];

step = rows/gridsize;
temp = step;
for i=1:gridsize-1
    mesh_points_original_rows = [mesh_points_original_rows temp];
    mesh_points_original_rows = [mesh_points_original_rows temp+1];
    temp = temp+step;
end

mesh_points_original_rows = [mesh_points_original_rows rows];


mesh_points_original_columns = [1];

step = columns/gridsize;
temp = step;
for i=1:gridsize-1
    mesh_points_original_columns = [mesh_points_original_columns temp];
    mesh_points_original_columns = [mesh_points_original_columns temp+1];
    temp = temp+step;
end

mesh_points_original_columns = [mesh_points_original_columns columns];



[X_o,Y_o] = meshgrid(mesh_points_original_rows,mesh_points_original_columns);

% X_d = [4 100 101 256;30 80 81 240;30 80 81 240;10 120 121 250];
% Y_d = [4 20 20 10; 130 130 130 120; 131 131 131 121; 250 245 245 230];

% X_d=[40 100 101 250;5 170 171 200;5 170 171 200;20 100 101 240];
% Y_d=[5 5 5 5; 120 120 120 120; 121 121 121 121; 250 250 250 250];

X_d = X_o;
Y_d = Y_o;

for i=1:length(mesh_points_original_rows)
    for j=1:length(mesh_points_original_columns)
        if ((i==1 || mod(i,2)==0) && ((j==1 || mod(j,2)==0)))
            if (j==1)
                 X_d(i,j) = X_d(i,j) + randi([0 20]);
            elseif (j==length(mesh_points_original_rows))
                 X_d(i,j) = X_d(i,j) + randi([-20 0]);
            else
                X_d(i,j) = X_d(i,j) + randi([-20 20]);
            end
            
            if (i==1)
                 Y_d(i,j) = Y_d(i,j) + randi([0 20]);
            elseif (i==length(mesh_points_original_columns))
                 Y_d(i,j) = Y_d(i,j) + randi([-20 0]);
            else
                Y_d(i,j) = Y_d(i,j) + randi([-20 20]);
            end    
                 
            end
        end
   
end
    
for i=3:2:length(mesh_points_original_rows)
    X_d(:,i) = X_d(:,i-1)+1;
    Y_d(:,i) = Y_d(:,i-1);
end

for i=3:2:length(mesh_points_original_columns)
    Y_d(i,:) = Y_d(i-1,:)+1;
    X_d(i,:) = X_d(i-1,:);
end

for r=1:rows
    for c=1:columns
        
        
        i=1;
        while (i<=length(mesh_points_original_rows))
            
            if (r >= mesh_points_original_rows(i) && r <= mesh_points_original_rows(i+1))
                break;
            end
            i=i+2;
        end
        
        j=1;
        while (j<=length(mesh_points_original_columns))
            
            if (c >= mesh_points_original_columns(j) && c <= mesh_points_original_columns(j+1))
                break;
            end
            j=j+2;
        end
       
        
       
         K = transform(X_o(j,i),Y_o(j,i),X_o(j,i+1),Y_o(j,i+1),X_o(j+1,i+1),Y_o(j+1,i+1),X_o(j+1,i),Y_o(j+1,i),X_d(j,i),Y_d(j,i),X_d(j,i+1),Y_d(j,i+1),X_d(j+1,i+1),Y_d(j+1,i+1),X_d(j+1,i),Y_d(j+1,i));
     
         k1 = K(1);
         k2 = K(2);
        k3 = K(3);
        k4 = K(4);
        k5 = K(5);
        k6 = K(6);
        k7 = K(7);
        k8 = K(8);
    
   
    
        
        r_o = k1*r+k2*c+k3*r*c+k4;
        c_o = k5*r+k6*c+k7*r*c+k8;
        
        r1 = (floor(r_o));
        c1 = (floor(c_o));
        r2 = (floor(r_o)+1);
        c2 = (floor(c_o)+1);
        
        
        if r2>rows
            r2=rows;
        end
        if c2>columns
            c2=columns;
        end
                

       output(r1,c1) = A(r,c);
      
    end
end
output = uint8(output);
outstr=strcat('distorted_random_gridsize_',num2str(gridsize),'_',inputfile);

figure
imshow(output)
imwrite(output,outstr);
