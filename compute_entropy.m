function [ entro ] = compute_entropy( p )
%COMPUTE_ENTROPY Summary of this function goes here
% Detailed explanation goes here
entro = - sum(p .* log(p), 2);

end


