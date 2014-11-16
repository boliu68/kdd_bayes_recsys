function para = update_f13(para, hyperpara, O, R)

d = hyperpara.d;
n = hyperpara.n;
h = hyperpara.h;
L = hyperpara.L;

v_b_n13ijk = 10 * ones(d,L-1);
m_b_n13ijk = zeros(d,L-1);
v_a_n13ijk = 10 * ones(n,L-1);
m_a_n13ijk = zeros(n,L-1);

% 	for i = 1:n
% 		for j = 1:d
[nnz_i, nnz_j, ~] = find(O);

for idx = 1:size(nnz_i)
    i = nnz_i(idx);
    j = nnz_j(idx);
    for k = 1:L-1
        
        v_b_n13ijk(j,k) = (1 / ((1 / para.v_b(j,k)) - (1 / para.h_v_b13{k}(i,j))));
        m_b_n13ijk(j,k) = v_b_n13ijk(j,k) * (para.m_b(j,k) / para.v_b(j,k) - para.h_m_b13{k}(i,j) / para.h_v_b13{k}(i,j));
        
        v_a_n13ijk(i,j) = (1 / ((1 / para.v_a(i,j)) - (1 / para.h_v_a13{k}(i,j))));
        m_a_n13ijk(i,j) = v_a_n13ijk(i,j) * (para.m_a(i,j) / para.v_a(i,j) - para.h_m_a13{k}(i,j) / para.h_v_a13{k}(i,j));
        
        if v_a_n13ijk(i,j) > 0 && v_b_n13ijk(j,k) > 0% && (v_a_n13ijk(j,k) + v_b_n13ijk(j,k)) > 0
            alpha = sign(R(i,j) - k - 0.5) * (m_a_n13ijk(i,j) - m_b_n13ijk(j,k)) / sqrt((v_a_n13ijk(i,j) + v_b_n13ijk(j,k)));
            phi_alpha = normpdf(alpha, 0, 1);
            cphi_alpha = normcdf(alpha, 0, 1);
            
            bta = - phi_alpha / cphi_alpha * (alpha + phi_alpha / cphi_alpha) / (v_a_n13ijk(i,j) + v_b_n13ijk(j,k));
            kta = - (sign(R(i,j) - k - 0.5) / sqrt(v_a_n13ijk(i,j) + v_b_n13ijk(j,k))) / (alpha + phi_alpha / cphi_alpha);
            
            if (- v_b_n13ijk(j,k) - 1/bta) > 0 && ( - v_a_n13ijk(i,j) - 1/bta) > 0
                para.h_m_b13{k}(i,j) = m_b_n13ijk(j,k) + kta;
                para.h_v_b13{k}(i,j) = - v_b_n13ijk(j,k) - 1/bta;
                para.h_m_a13{k}(i,j) = m_a_n13ijk(i,j) - kta;
                para.h_v_a13{k}(i,j) = - v_a_n13ijk(i,j) - 1/bta;
                
                para.v_b(j,k) = (1 / ((1 / v_b_n13ijk(j,k)) + (1 / para.h_v_b13{k}(i,j))));
                para.m_b(j,k) = para.v_b(j,k) * (m_b_n13ijk(j,k) / v_b_n13ijk(j,k) + para.h_m_b13{k}(i,j) / para.h_v_b13{k}(i,j));
                para.v_a(i,j) = (1 / ((1 / v_a_n13ijk(i,j)) + (1 / para.h_v_a13{k}(i,j))));
                para.m_a(i,j) = para.v_a(i,j) * (m_a_n13ijk(i,j) / v_a_n13ijk(i,j) + para.h_m_a13{k}(i,j) / para.h_v_a13{k}(i,j));
                
            end
        end
%         para.v_b(j,k) = (1 / ((1 / v_b_n13ijk(j,k)) + (1 / para.h_v_b13{k}(i,j))));
%         para.m_b(j,k) = para.v_b(j,k) * (m_b_n13ijk(j,k) / v_b_n13ijk(j,k) + para.h_m_b13{k}(i,j) / para.h_v_b13{k}(i,j));
%         para.v_a(i,j) = (1 / ((1 / v_a_n13ijk(i,j)) + (1 / para.h_v_a13{k}(i,j))));
%         para.m_a(i,j) = para.v_a(i,j) * (m_a_n13ijk(i,j) / v_a_n13ijk(i,j) + para.h_m_a13{k}(i,j) / para.h_v_a13{k}(i,j));
        
        
    end
end
end