function [thisGlcm] = get_glcm(f)
    o=[1 1];
    G = zeros(256,256);
    [R,C]=size(f);
    o1 = o(1);
    o2 = o(2);
    for r = 1:R-o1
        for c = 1: C-o2
            i = f(r,c)+1;
            j = f(r+o1,c+o2)+1;
            G(i,j) = G(i,j)+1;
        end
    end
    thisGlcm = G;
end
   