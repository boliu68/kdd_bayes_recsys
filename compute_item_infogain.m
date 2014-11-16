function [ inforgain ] = compute_item_infogain( para, hyperpara, test_entry )
%COMPUTUTE_INFOGAIN Summary of this function goes here
%   Detailed explanation goes here

 m_v = para.m_v;
 v_v = para.v_v;

 Rpred  = predfun( para, hyperpara, test_entry );
 term1 = compute_entropy(Rpred);
 
 
 i = test_entry.col;
 
 Nsample = 100;
 sample_v = normrnd(repmat(m_v(i,:), [Nsample, 1]), repmat(v_v(i,:), [Nsample, 1]));
 pred_v = compute_pred_v(para, hyperpara, test_entry, sample_v);
 term2 = sum(compute_entropy(pred_v));
 
 inforgain = term1+term2; 
 

end

function [pred_u] = compute_pred_v(para, hyperpara, sample_entry, sample_v)

[Nsample, ~] = size(sample_v);

L = hyperpara.L;

m_b = para.m_b;

m_u = para.m_u;

v_u = para.v_u;


a_gamrow = para.a_gmarow;
b_gamrow = para.b_gmarow;
a_gamcol = para.a_gmacol;
b_gamcol = para.b_gmacol;


v_b = para.v_b;

sample_row = sample_entry.row * ones(Nsample, 1);
sample_col = sample_entry.col * ones(Nsample, 1);


nPred = length(sample_row);

m_v_t = sample_v;
m_u_t = m_u(sample_row,:);
v_u_t = v_u(sample_row,:);


m_c_star = dot(m_u_t , m_v_t,2);
v_c_star = dot(v_u_t , m_v_t.^2,2);

%ind2 = sub2ind(size(m_c_star), sample_row, sample_col);
b_gamrow_t = b_gamrow(sample_row);
a_gamrow_t = a_gamrow(sample_row);
b_gamcol_t = b_gamcol(sample_col);
a_gamcol_t = a_gamcol(sample_col);
v_gam = (b_gamrow_t.* b_gamcol_t).*(1./((a_gamrow_t+1).*(a_gamcol_t + a_gamcol_t )));
v_gam = reshape(v_gam, [L-1,1]);

pred_u = zeros(nPred, L);
for i = 1:L    
    
    if i == 5
	zeta1 = inf;
    else
    ind = sub2ind(size(m_b), sample_col, i*ones(size(sample_col)));
    ind3 = sub2ind(size(v_b), sample_col, i*ones(size(sample_col)));
	zeta1 = (m_b(ind) - m_c_star) .* (v_c_star + v_b(ind3) + v_gam).^(0.5);
    end
    if i == 1
	zeta2 = -inf;
    else 
	ind = sub2ind(size(m_b), sample_col, (i-1)*ones(size(sample_col)));
	ind3 = sub2ind(size(v_b), sample_col, (i-1)*ones(size(sample_col)));
	zeta2 = (m_b(ind) - m_c_star) .* (v_c_star + v_b(ind3) + v_gam).^(0.5);
    end
    pred_v(:, i) =  normcdf(zeta1) - normcdf(zeta2);
end


end



