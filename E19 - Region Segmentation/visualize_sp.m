function visualize_sp ( f, regionIm )

g = zeros(size(f), 'uint8');

r0 = min(regionIm(:));
r1 = max(regionIm(:));

for r = r0:r1
    t = regionIm == r;
    
    t2 = f(t);
    if ( numel(t2) > 0)
        g(t) = uint8(mean(t2));
    end
end

imshow ( g );