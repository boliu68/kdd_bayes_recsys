function [ Rpred ] = predfun( para, hyperpara, pred_entry )
%PREDFUN Summary of this function goes here
%   Detailed explanation goes here

L = hyperpara.L;

m_b = para.m_b;
pred_row = pred_entry.row;
pred_col = pred_entry.col;

nPred = length(pred_row);

Rpred = zeros(nPred, L);

m_cstar = 
for i = 1:L
    ind = sub2ind([size(m_b)], pred_row, i);
    ind2 = sub2ind([size(m_c
    zeta1 = m_b(ind) - 
    Rpred(nPred, :) = 
end



end

