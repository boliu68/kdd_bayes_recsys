function para = update_f8(para, hyperpara)

    %k = 1 for L, j = 1 to d
    %L * d
    for j = 1:d
        %L dimension vector
        v_b0_n8j = (1 ./ ((1 ./ para.v_b0) - (1 ./ para.h_v_b08j)));
        m_b0_n8j = v_b0_n8j .* ((para.m_b0 .* (1 ./ para.v_b0) - para.h_m_b08j .* (1 ./ para.h_v_b08j)));

        v_b_n8j(j,:) = (1 ./ ((1 ./ para.v_b(j,:)) - (1 ./ para.h_v_b8j(j,:))));
        m_b_n8j(j,:) = v_b_n8j(j,:) .* (para.m_b(j,:)  .* (1 ./ para.v_b(j,:)) - para.h_m_b8j(j,:) .* (1 ./ para.h_v_b8j(j,:)));

        para.h_m_b08j = m_b_n8j(j,:);
        para.h_v_b08j = v_b_n8j(j,:) + para.v0;
        para.h_m_b8j = m_b0_n8j;
        para.h_v_b8j = v_b0_n8j + para.v0;

        para.v_b0 = (1 ./ ((1 ./ v_b0_n8j) + (1 ./ para.h_v_b08j)));
        para.m_b0 = para.v_b0 .* (m_b0_n8j .* (1 ./ v_b0_n8j) + para.h_m_b08j .* (1 ./ para.h_v_b08j));
        
        para.v_b(j,:) = (1 ./ ((1 ./ v_b_n8j(j,:)) + (1 ./ para.h_v_b8j(j,:))));
        para.m_b(j,:) = para.v_b(j,:) .* (m_b_n8j(j,:) .* (1 ./ v_b_n8j(j,:)) + para.h_m_b8j(j,:) .* (1 ./ para.h_v_b8j(j,:)));
    end
    
end