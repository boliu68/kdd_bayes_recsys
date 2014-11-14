function para = unpdate_f12(para, hyperpara, O)

    %%
    %update Q_n12 ij for i,j \in O
    upd = (1 ./ ((1 ./ para.v_a) - (1 ./ h_v_a12ij)));
    v_a_n12ij(O) = upd(O);
    
    upd = v_a_n12ij .* (para.m_a ./ para.v_a - para.h_m_a12ij ./ para.h_v_a12ij);
    m_a_n12ij(O) = upd(O);
    
    upd = (1 ./ ((1 ./ para.v_c) - (1 ./ para.h_v_c12ij)));
    v_c_n12ij(O) = upd(O);
    
    upd = v_c_n12ij .* (para.m_c ./ para.v_c - para.h_m_c12ij ./ para.h_v_c12ij);
    m_c_n12ij(O) = upd(O);
    
    %n dimension
    a_gmarow_n12ij = para.a_gmarow - para.h_a_gmarow12ij + 1;
    b_gmarow_n12ij = para.b_gmarow - para.h_b_gmarow12ij;
    
    %d dimension
    a_gmacol_n12ij = para.a_gmacol - para.h_a_gmacol12ij + 1;
    b_gmacol_n12ij = para.b_gmacol - para.h_b_gmacol12ij;
    
    %%
    %Normalization
    Z = zeros(n, d);
    Z1row = zeros(n, d);
    Z2row = zeros(n, d);
    Z1col = zeros(n,d);
    Z2col = zeros(n,d);
    
    mean_val = m_c_n12ij;
    std_val = v_a_n12ij + v_c_n12ij + (b_gmarow_n12ij' * b_gmacol_n12ij) ./ ((a_gmarow_n12ij + 1)' * (a_gmacol_n12ij + 1));
    std_val_1row = v_a_n12ij + v_c_n12ij + (b_gmarow_n12ij' * b_gmacol_n12ij) ./ ((a_gmarow_n12ij + 2)' * (a_gmacol_n12ij + 1));
    std_val_2row = v_a_n12ij + v_c_n12ij + (b_gmarow_n12ij' * b_gmacol_n12ij) ./ ((a_gmarow_n12ij + 3)' * (a_gmacol_n12ij + 1));
    std_val_1col = v_a_n12ij + v_c_n12ij + (b_gmarow_n12ij' * b_gmacol_n12ij) ./ ((a_gmarow_n12ij + 1)' * (a_gmacol_n12ij + 2));
    std_val_2col = v_a_n12ij + v_c_n12ij + (b_gmarow_n12ij' * b_gmacol_n12ij) ./ ((a_gmarow_n12ij + 1)' * (a_gmacol_n12ij + 3));
    
    is_positive = (a_gmacol_n12ij > 2) & (b_gmacol_n12ij > 0) & (a_gmarow_n12ij > 2) & (b_gmarow_n12ij > 0) & (v_a_n12ij > 0) & (v_c_n12ij > 0);
    Z(is_positive) = pdf('Normal',m_a_n12ij(is_positive), mean_val(is_positive), sqrt(std_val(is_positive)));
    Z1row(is_positive) = pdf('Normal',m_a_n12ij(is_positive), mean_val(is_positive), sqrt(std_val_1row(is_positive)));
    Z2row(is_positive) = pdf('Normal',m_a_n12ij(is_positive), mean_val(is_positive), sqrt(std_val_2row(is_positive)));
    Z1col(is_positive) = pdf('Normal',m_a_n12ij(is_positive), mean_val(is_positive), sqrt(std_val_1col(is_positive)));
    Z2col(is_positive) = pdf('Normal',m_a_n12ij(is_positive), mean_val(is_positive), sqrt(std_val_2col(is_positive)));

end