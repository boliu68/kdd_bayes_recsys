function para = update_f8(para, hyperpara)

    %initialize new matrix
    L = hyperpara.L;
    d = hyperpara.d;

    v_b0_n8j = 10 * ones(1,L-1);
    m_b0_n8j = zeros(1,L-1);
    v_b_n8j = 10 * ones(d,L-1);
    m_b_n8j = zeros(d,L-1);

    %k = 1 for L, j = 1 to d
    %L * d
    for j = 1:d
        %L dimension vector
        v_b0_n8j = (1 ./ ((1 ./ para.v_b0) - (1 ./ para.h_v_b08(:,:,j))));
        m_b0_n8j = v_b0_n8j .* ((para.m_b0 .* (1 ./ para.v_b0) - para.h_m_b08(:,:,j) .* (1 ./ para.h_v_b08(:,:,j))));

        v_b_n8j(j,:) = (1 ./ ((1 ./ para.v_b(j,:)) - (1 ./ para.h_v_b8(j,:,j))));
        m_b_n8j(j,:) = v_b_n8j(j,:) .* (para.m_b(j,:) .* (1 ./ para.v_b(j,:)) - para.h_m_b8(j,:,j) .* (1 ./ para.h_v_b8(j,:,j)));

        para.h_m_b08(:,:,j) = m_b_n8j(j,:);
        para.h_v_b08(:,:,j) = v_b_n8j(j,:) + hyperpara.v0;
        para.h_m_b8(j,:,j) = m_b0_n8j;
        para.h_v_b8(j,:,j) = v_b0_n8j + hyperpara.v0;

        para.v_b0 = (1 ./ ((1 ./ v_b0_n8j) + (1 ./ para.h_v_b08(:,:,j))));
        para.m_b0 = para.v_b0 .* (m_b0_n8j .* (1 ./ v_b0_n8j) + para.h_m_b08(:,:,j) .* (1 ./ para.h_v_b08(:,:,j)));
        
        para.v_b(j,:) = (1 ./ ((1 ./ v_b_n8j(j,:)) + (1 ./ para.h_v_b8(j,:,j))));
        para.m_b(j,:) = para.v_b(j,:) .* (m_b_n8j(j,:) .* (1 ./ v_b_n8j(j,:)) + para.h_m_b8(j,:,j) .* (1 ./ para.h_v_b8(j,:,j)));
    end
    
end