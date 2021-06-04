function [K] = transform(r1,c1,r2,c2,r3,c3,r4,c4,r1_o,c1_o,r2_o,c2_o,r3_o,c3_o,r4_o,c4_o)

    
    RC = [r1 c1 r1*c1 1; r2 c2 r2*c2 1; r3 c3 r3*c3 1; r4 c4 r4*c4 1];
    r = [r1_o;r2_o;r3_o;r4_o];
    c = [c1_o;c2_o;c3_o;c4_o];
    
    K1 = inv(RC)*r;
    K2 = inv(RC)*c; 
    
    K = [K1;K2];

   
end
