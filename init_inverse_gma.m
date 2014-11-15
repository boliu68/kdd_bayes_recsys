function [a,b] = init_inverse_gma(h_a,h_b)
    %size h_m = size h_a = (x,y,z)
    %where z is the number of factors
    
    %return m,v such that p(theta|m,v) = \prod_i p(theta|m(:,:,i),
    %v(:,:,i));
    %Assume Inverse Gaussian
    %the return a, b should be the same size with h_a, and h_b
    
    [x,y,z] = size(h_a);
    
    if z > 1
        a = mean(h_a, 3) - rand(size(h_a(:,:,1)));
        b = mean(h_b, 3) - rand(size(h_b(:,:,1)));
    end
    
    a = mean(h_a, 2) - rand(size(h_a));
    b = mean(h_b, 2) - rand(size(h_b));
    
end