function [ Rpred ] = predfun( para, hyperpara, pred_entry )
%PREDFUN Summary of this function goes here
%   Detailed explanation goes here

L = hyperpara.L;

m_b = para.m_b;
m_c = para.m_c;

a_gamrow = para.a_gamrow;
b_gamrow = para.b_gamrow;
a_gamcol = para.a_gamcol;
b_gamcol = para.b_gamcol;

v_c = para.v_c;
v_b = para.v_b;

pred_row = pred_entry.row;
pred_col = pred_entry.col;



nPred = length(pred_row);

Rpred = zeros(nPred, L);

for i = 1:L
    ind = sub2ind(size(m_b), pred_row, i);
    ind2 = sub2ind(size(m_c), pred_row, pred_col);
    ind3 = sub2ind(size(v_b), pred_col, i);
    b_gamrow_t = b_gamrow(pred_row);
    a_gamrow_t = a_gamrow(pred_row);
    b_gamcol_t = b_gamcol(pred_col);
    a_gamcol_t = a_gamcol(pred_col);
    v_gam = (b_gamrow_t.* b_gamcol_t).*(1./((a_gamrow_t+1).*(a_gamcol_t + a_gamcol_t )));
    if i == 5
	zeta1 = inf;
    else
	zeta1 = (m_b(ind) - m_c(ind2)) .* (v_c(ind2) + v_b(ind3), + v_gam).^(0.5);
    end
    if i == 1
	zeta2 = 0;
    else 
	ind = sub2ind(size(m_b), pred_row, i-1);
	ind3 = sub2ind(size(v_b), pred_col, i-1);
	zeta2 = (m_b(ind) - m_c(ind2)) .* (v_c(ind2) + v_b(ind3), + v_gam).^(0.5);
    end
    Rpred(:, i) =  normpdf(zeta1) - normpdf(zeta2);
end



end

