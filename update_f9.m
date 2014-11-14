function para = update_f9(para, hyperpara)

    d = size(para.h_v_v, 1);

    for j = 1:d
           %h dimension
            v_mV_n9jk = (1 ./ ((1 ./ para.v_mV) - (1 ./ para.h_v_mV9jk)));
            m_mV_n9jk = v_mV_n9jk .* (para.m_mV .* (1 ./ para.v_mV) - para.h_m_mV9jk .* (1 ./ para.h_v_mV9jk));
            
            %d * h matrix
            v_v_n9jk(j,:) = (1 ./ ((1 ./ para.v_v(j,:)) - (1 ./ para.h_v_v9jk(j,:))));
            m_v_n9jk(j,:) = v_v_n9jk(j,:) .* (para.m_v(j,:) .* (1 ./ para.v_v(j,:)) - para.h_m_v9jk(j,:) .* (1 ./ para.h_v_v9jk(j,:)));
            
            %h dimension
            a_vV_n9jk = (para.a_vV - para.h_a_vV9jk + 1);
            b_vV_n9jk = (para.b_vV - para.h_b_vV9jk);
            
            is_update = ( b_vV_n9jk > 0) & ((2 * a_vV_n9jk - 2) > 0) & (v_mV_n9jk > 0) & (v_v_n9jk(j,:) > 0) 
            
            %normalization of h dimension
            mean_val = m_v_n9jk(j,(is_update))
            %might need sqrt here
            std_val = v_v_n9jk(j,is_update) + v_mV_n9jk(is_update) + (2 * b_vV_n9jk(is_update)) ./ (2 * a_vV_n9jk(is_update) - 2);
            std_val1 = v_v_n9jk(j,is_update) + v_mV_n9jk(is_update) + (2 * b_vV_n9jk(is_update)) ./ (2 * a_vV_n9jk(is_update));
            std_val2 = v_v_n9jk(j,is_update) + v_mV_n9jk(is_update) + (2 * b_vV_n9jk(is_update)) ./ (2 * a_vV_n9jk(is_update) + 2);
            
            Z = pdf('Normal', m_mV_n9jk, mean_val, std_val);
            Z1 = pdf('Normal', m_mV_n9jk, mean_val, std_val1);
            Z2 = pdf('Normal', m_mV_n9jk, mean_val, std_val2);
            
            para.h_v_mV9jk(is_update) = 2 * b_vV_n9jk(is_update) ./ (2 * a_vV_n9jk(is_update) - 2) + v_v_n9jk(j,is_update);
            para.h_m_mV9jk(is_update) = m_v_n9jk(j,is_update);
            para.h_v_v9jk(j,is_update) = 2 * b_vV_n9jk(is_update) / (2 * a_vV_n9jk(is_update) - 2) + v_mV_n9jk(is_update);
            para.h_m_v9jk(j,is_update) = m_mV_n9jk(is_update);
            
            %a dot and b dot
            ad = (a_vV_n9jk(is_update) .* Z1 .* Z1) ./ ((a_vV_n9jk(is_update) + 1) .* Z .* Z2 - a_vV_n9jk(is_update) .* Z1 .* Z1);
            bd = (b_vV_n9jk(is_update) .* Z .* Z1) ./ ((a_vV_n9jk(is_update) + 1) .* Z .* Z2 - a_vV_n9jk(is_update) .* Z1 .* Z1);
            
            para.h_a_vV9jk(is_update) = ad - a_vV_n9jk(is_update) + 1;
            para.h_b_vV9jk(is_update) = bd - b_vV_n9jk(is_update);
            
            para.v_mV = (1 ./ ((1 ./ v_mV_n9jk) + (1 ./ para.h_v_mV9jk)));
            para.m_mV = para.v_mV .* (m_mV_n9jk ./ v_mV_n9jk + para.h_m_mV9jk ./ para.h_v_mV9jk);
            
            para.v_v(j,:) = (1 ./ ((1 ./ v_v_n9jk(j,:)) + (1 ./ para.h_v_v9jk(j,:))));
            para.m_v(j,:) = para.v_v(j,:) .* (m_v_n9jk(j,:) ./ v_v_n9jk(j,:) + para.h_m_v9jk(j,:) ./ para.h_v_v9jk(j,:));
            
            para.a_vV = a_vV_n9jk + para.h_a_vV9jk - 1;
            para.b_vV = b_vV_n9jk + para.h_b_vV9jk;
            
    end

end