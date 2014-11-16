function ce = cross_entropy(para, m_u_n11, v_u_n11, m_v_n11, v_v_n11)

    %accoridng to para.m_u
    %para.v_u
    %para.m_v
    %para.v_v
    ce1 = - (para.v_u .^ 2+ para.m_u.^2 + m_u_n11.^2 - 2 * para.m_u .* m_u_n11) ./ (2 * v_u_n11 .^ 2) - ln(2 * pi * v_u_n11 .^ 2);
    ce1 = sum(ce1);
    
    ce2 = - (para.v_v .^ 2+ para.m_v.^2 + m_v_n11.^2 - 2 * para.m_v .* m_v_n11) ./ (2 * v_v_n11 .^ 2) - ln(2 * pi * v_v_n11 .^ 2);
    ce2 = sum(ce2);
    
    ce = ce1 + ce2;
    
end