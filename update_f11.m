function para = update_f11(para, hyperpara, O)
    
    %udpate f11 based on observation matrix O
    %%
    %n * k and d * k
    v_v_n11 = (1 ./ ((1 ./ para.v_v) - (1 ./ para.h_v_v11)));
    m_v_n11 = v_v_n11 .* (para.m_v ./ para.v_v - para.h_m_v11 ./ para.h_v_v11);
    
    v_u_n11 = (1 ./ ((1 ./ para.v_u) - (1 ./ para.h_v_u11))) ;
    m_u_n11 = v_u_n11 .* (para.m_u ./ para.v_u - para.h_m_u11 ./ para.h_v_u11);
    
    %%
    %n * d matrix
    
    upd = (1 ./ ((1 ./ para.v_c) - (1 ./ para.h_v_c11)));
    v_c_n11(O) = upd(O);
    upd = v_c_n11 .* (para.m_c ./ para.v_c - para.h_m_c11 ./ para.h_v_c11);
    m_c_n11(O) = upd(O);
    
    %%
    %upate n * d only for those of O%
    uv = (para.m_u * para.m_v');
    para.m_c(O) = uv(O);
    
    uv = (para.m_u .^ 2 * para.v_v' + para.v_u * (para.m_v .^ 2)' + para.v_u * para.v_v')
    para.v_c(O) = uv(O);
    
    %%
    %refine hat f11
    %avoid negative
    upd = (1 ./ ((1 ./ para.v_v) + (1 ./ v_v_n11)));
    para.h_v_v11(upd >= 0) = upd(upd >= 0);
    
    para.h_m_v11 = para.h_v_v11 .* (para.m_v ./ para.v_v - m_v_n11 ./ v_v_n11);
    
    upd = (1 ./ ((1 ./ para.v_u) + (1 ./ v_u_n11)));
    para.h_v_u11(upd >= 0) = upd(upd >= 0);
    
    para.h_m_u11 = para.h_v_u11 .* (para.m_u ./ para.v_u - m_u_n11 ./ v_u_n11);
    
    %for i j \in O
    upd = (1 ./ ((1 ./ para.v_c) - (1 ./ v_c_n11)));
    para.h_v_c11(O & (upd >= 0)) = upd(O & (upd >= 0));
    
    upd = para.h_v_c11 .* (para.m_c ./ para.v_c - m_c_n11 ./ v_c_n11);
    para.h_m_c11(O) = upd(O);
    
end