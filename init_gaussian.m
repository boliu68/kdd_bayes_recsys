function [m, v] = init_gaussian(h_m, h_v)
    %size h_m = size h_v = (x,y,z)
    %where z is the number of factors
    
    %return m,v such that p(theta|m,v) = \prod_i p(theta|m(:,:,i),
    %v(:,:,i));
    %Assume Gaussian
    %the return m, v should be the same size with m,v
    %sometimes h_m should be 4 dimension
    [x,y,z] = size(h_m);
    
    m = mean(h_m, 3) + rand(size(h_m(:,:,1)));
    v = mean(h_v, 3) + rand(size(h_v(:,:,1)));
    
end