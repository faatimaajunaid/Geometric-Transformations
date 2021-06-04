function [value] = interpolate(A,r,c,r1,c1,r2,c2)

    
    RC = [r1 c1 r1*c1 1; r1 c2 r1*c2 1; r2 c1 r2*c1 1; r2 c2 r2*c2 1];
    X = [A(r1,c1);A(r1,c2);A(r2,c1);A(r2,c2)];
    
    B = double(inv(RC))*double(X);
    b1 = B(1);
    b2 = B(2);
    b3 = B(3);
    b4 = B(4);
    
    value = b1*r+b2*c+b3*r*c+b4;
    value = uint8(value);
    
   
    
end
