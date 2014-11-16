function para = unpdate_f12(para, hyperpara, O)

%%
%initialize
d = hyperpara.d;
n = hyperpara.n;
h = hyperpara.h;
L = hyperpara.L;

v_a_n12ij = 10 * ones(n,d);
m_a_n12ij = zeros(n,d);
v_c_n12ij = 10 * ones(n,d);
m_c_n12ij = zeros(n,d);
a_gmarow_n12ij = zeros(1,n);
b_gmarow_n12ij = zeros(1,n);
a_gmacol_n12ij = zeros(1,d);
b_gmacol_n12ij = zeros(1,d);

%update
%    for i = 1:n
%     for j = 1:d
%
%         if full(O(i,j)) ~= 1
%             continue
%         end
[nnz_i, nnz_j, nnz_r] = find(O);

for idx = 1:size(nnz_i)
    i = nnz_i(idx);
    j = nnz_j(idx);
    
    v_a_n12ij(i,j) = (1 / ((1 / para.v_a(i,j)) - (1 / para.h_v_a12(i,j))));
    m_a_n12ij(i,j) = v_a_n12ij(i,j) * (para.m_a(i,j) / para.v_a(i,j) - para.h_m_a12(i,j) / para.h_v_a12(i,j));
    
    v_c_n12ij(i,j) = (1 / ((1 / para.v_c(i,j)) - (1 / para.h_v_c12(i,j))));
    m_c_n12ij(i,j) = v_c_n12ij(i,j) * (para.m_c(i,j) / para.v_c(i,j) - para.h_m_c12(i,j) / para.h_v_c12(i,j));
    
    a_gmarow_n12ij(i) = para.a_gmarow(i) - para.h_a_gmarow12(i,j) + 1;
    b_gmarow_n12ij(i) = para.b_gmarow(i) - para.h_b_gmarow12(i,j);
    
    a_gmacol_n12ij(j) = para.a_gmacol(j) - para.h_a_gmacol12(i,j) + 1;
    b_gmacol_n12ij(j) = para.b_gmacol(j) - para.h_b_gmacol12(i,j);
    
    %Normalize
    
    if a_gmacol_n12ij(j) > 2 && b_gmacol_n12ij(j) > 0 && a_gmarow_n12ij(i) > 2 && b_gmarow_n12ij(i) > 0 && v_a_n12ij(i,j) > 0 && v_c_n12ij(i,j) > 0
        
        mean_value = m_c_n12ij(i,j);
        std_value = v_a_n12ij(i,j) + v_c_n12ij(i,j) + b_gmarow_n12ij(i) * b_gmacol_n12ij(j) / ((a_gmarow_n12ij(i) + 1) * (a_gmacol_n12ij(j) + 1));
        std_value1row = v_a_n12ij(i,j) + v_c_n12ij(i,j) + b_gmarow_n12ij(i) * b_gmacol_n12ij(j) / ((a_gmarow_n12ij(i) + 2) * (a_gmacol_n12ij(j) + 1));
        std_value2row = v_a_n12ij(i,j) + v_c_n12ij(i,j) + b_gmarow_n12ij(i) * b_gmacol_n12ij(j) / ((a_gmarow_n12ij(i) + 3) * (a_gmacol_n12ij(j) + 1));
        std_value1col = v_a_n12ij(i,j) + v_c_n12ij(i,j) + b_gmarow_n12ij(i) * b_gmacol_n12ij(j) / ((a_gmarow_n12ij(i) + 1) * (a_gmacol_n12ij(j) + 2));
        std_value2col = v_a_n12ij(i,j) + v_c_n12ij(i,j) + b_gmarow_n12ij(i) * b_gmacol_n12ij(j) / ((a_gmarow_n12ij(i) + 1) * (a_gmacol_n12ij(j) + 3));
        
        
        Z = normpdf(m_a_n12ij(i,j), mean_value, sqrt(std_value));
        Z1row = normpdf(m_a_n12ij(i,j), mean_value, sqrt(std_value1row));
        Z2row = normpdf(m_a_n12ij(i,j), mean_value, sqrt(std_value2row));
        Z1col = normpdf(m_a_n12ij(i,j), mean_value, sqrt(std_value1col));
        Z2col = normpdf(m_a_n12ij(i,j), mean_value, sqrt(std_value2col));
        
        %update the hat f
        
        upd_v_1 = v_c_n12ij(i,j) + b_gmarow_n12ij(i) * b_gmacol_n12ij(j) / ((a_gmarow_n12ij(i) + 1) * (a_gmacol_n12ij(j) + 1));
        upd_v_2 = v_a_n12ij(i,j) + b_gmarow_n12ij(i) * b_gmacol_n12ij(j) / ((a_gmarow_n12ij(i) + 1) * (a_gmacol_n12ij(j) + 1));
        if upd_v_1 > 0 && upd_v_2 > 0
            para.h_m_a12(i,j) = m_c_n12ij(i,j);
            para.h_v_a12(i,j) = v_c_n12ij(i,j) + b_gmarow_n12ij(i) * b_gmacol_n12ij(j) / ((a_gmarow_n12ij(i) + 1) * (a_gmacol_n12ij(j) + 1));
            
            para.h_m_c12(i,j) = m_a_n12ij(i,j);
            para.h_v_c12(i,j) = v_a_n12ij(i,j) + b_gmarow_n12ij(i) * b_gmacol_n12ij(j) / ((a_gmarow_n12ij(i) + 1) * (a_gmacol_n12ij(j) + 1));
            
            %adrow, bdrow, adcol, bdcol
            adrow = a_gmarow_n12ij(i) * (Z1row ^ 2) / ((a_gmarow_n12ij(i) + 1) * Z * Z2row - a_gmarow_n12ij(i) * (Z1row ^ 2));
            bdrow = b_gmarow_n12ij(i) * Z * Z1row   / ((a_gmarow_n12ij(i) + 1) * Z * Z2row - a_gmarow_n12ij(i) * (Z1row ^ 2));
            
            adcol = a_gmacol_n12ij(j) * (Z1col ^ 2) / ((a_gmacol_n12ij(j) + 1) * Z * Z2col - a_gmacol_n12ij(j) * (Z1col ^ 2));
            bdcol = b_gmacol_n12ij(j) * Z * Z1col   / ((a_gmacol_n12ij(j) + 1) * Z * Z2col - a_gmacol_n12ij(j) * (Z1col ^ 2));
            
            
            para.h_a_gmarow12(i,j) = adrow - a_gmarow_n12ij(i) + 1;
            para.h_b_gmarow12(i,j) = bdrow - b_gmarow_n12ij(i);
            
            para.h_a_gmacol12(i,j) = adcol - a_gmacol_n12ij(j) + 1;
            para.h_b_gmacol12(i,j) = bdcol - b_gmacol_n12ij(j);
 
    %recompute Q
    para.v_a(i,j) = (1 / ((1 / v_a_n12ij(i,j)) + (1 / para.h_v_a12(i,j))));
    para.m_a(i,j) = para.v_a(i,j) * (m_a_n12ij(i,j) / v_a_n12ij(i,j) + para.h_m_a12(i,j) / para.h_v_a12(i,j));
    para.v_c(i,j) = (1 / ((1 / v_c_n12ij(i,j)) + (1 / para.h_v_c12(i,j))));
    para.m_c(i,j) = para.v_c(i,j) * (m_c_n12ij(i,j) / v_c_n12ij(i,j) + para.h_m_c12(i,j) / para.h_v_c12(i,j));
    
    para.a_gmarow(i) = a_gmarow_n12ij(i) + para.h_a_gmarow12(i,j) - 1;
    para.b_gmarow(i) = b_gmarow_n12ij(i) + para.h_b_gmarow12(i,j);
    para.a_gmacol(j) = a_gmacol_n12ij(j) + para.h_a_gmacol12(i,j) - 1;
    para.b_gmacol(j) = b_gmacol_n12ij(j) + para.h_b_gmacol12(i,j);
           end
    end
    
end

end