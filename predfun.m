function [ Rpred ] = predfun( para, hyperpara, pred_entry )
%This function will predict the dicrete distribution of the require entry
%   #class : L , #pred_entry : nPred
%   pred_entry.row : the row  of the entry (should be a vector)  
%   pred_entry.col : the col  of the entry (should be a vector)
%  Rpred: a matrix size of  nPred * L,each row is a discrete probablity
%  of the class. each row is a instance, each col is a class

L = hyperpara.L;

m_b = para.m_b;
m_u = para.m_u;
m_v = para.m_v;
v_v = para.v_v;
v_u = para.v_u;


a_gamrow = para.a_gmarow;
b_gamrow = para.b_gmarow;
a_gamcol = para.a_gmacol;
b_gamcol = para.b_gmacol;


v_b = para.v_b;

pred_row = pred_entry.row;
pred_col = pred_entry.col;


nPred = length(pred_row);

m_u_t = m_u(pred_row,:);
m_v_t = m_v(pred_col,:);
v_u_t = v_u(pred_row,:);
v_v_t = v_v(pred_col,:);

m_c_star = dot(m_u_t , m_v_t,2);
v_c_star = dot((m_u_t.^2),v_v_t,2) + dot(v_u_t , (m_v_t.^2),2) + dot(v_u_t , v_v_t,2);

%ind2 = sub2ind(size(m_c_star), pred_row, pred_col);
b_gamrow_t = b_gamrow(pred_row);
a_gamrow_t = a_gamrow(pred_row);
b_gamcol_t = b_gamcol(pred_col);
a_gamcol_t = a_gamcol(pred_col);
v_gam = (b_gamrow_t.* b_gamcol_t).*(1./((a_gamrow_t+1).*(a_gamcol_t + a_gamcol_t )));
v_gam = reshape(v_gam, [L-1,1]);
Rpred = zeros(nPred, L);
for i = 1:L    
        

    
    if i == 5
	zeta1 = inf;
    else
    ind = sub2ind(size(m_b), pred_row, i*ones(size(pred_row)));
    ind3 = sub2ind(size(v_b), pred_col, i*ones(size(pred_col)));
	zeta1 = (m_b(ind') - m_c_star) .* (v_c_star + v_b(ind3') + v_gam).^(0.5);
    end
    if i == 1
	zeta2 = -inf;
    else 
	ind = sub2ind(size(m_b), pred_row, (i-1)*ones(size(pred_row)));
	ind3 = sub2ind(size(v_b), pred_col, (i-1)*ones(size(pred_col)));
	zeta2 = (m_b(ind') - m_c_star) .* (v_c_star + v_b(ind3') + v_gam).^(0.5);
    end
    Rpred(:, i) =  normcdf(zeta1) - normcdf(zeta2);
end



end

