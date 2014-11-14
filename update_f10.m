function para = update_f10(para, hyperpara)

    for i = 1:d
       
        v_mU_n10ik = (1 ./ ((1 ./ para.v_mV) - (1 ./ para.h_v_mU10ik)));
        m_mU_n10ik = v_mU_n10ik .* (para.m_mU ./ para. v_mU - para.h_m_mU10ik ./ para.h_v_mU10ik);
        
        v_u_n10ik(i,:) = (1 ./ ((1 ./ para.v_u(i,:)) - (1 ./ para.h_v_u10ik(i,:))));
        m_u_n10ik(i,:) = v_u_n10ik(i,:) .* (para.m_u(i,:) ./ para.v_u(i,:) - para.h_m_u10ik(i,:) ./ para.h_v_u_10ik(i,:));
        
        a_vU_n10ik = para.a_vU - para.h_a_vU10ik + 1;
        b_vU_n10ik = para.b_vU - para.h_b_vU10ik;
        
        %%
        %normalize Z
        is_update = (v_u_n10ik(i,:) > 0) & (v_mU_n10ik > 0) & (b_vU_n10ik > 0) & ((2 * a_vU_n10ik - 2) >0);
        
        mean_val = m_u_n10ik(i,is_update);
        std_val = v_u_n10ik(i,is_update) + v_mU_n10ik(is_update) + 2 * b_vU_n10ik(is_update) ./ (2 * a_vU_n10ik(is_update) - 2);
        std_val1 = v_u_n10ik(i,is_update) + v_mU_n10ik(is_update) + 2 * b_vU_n10ik(is_update) ./ (2 * a_vU_n10ik(is_update));
        std_val2 = v_u_n10ik(i,is_update) + v_mU_n10ik(is_update) + 2 * b_vU_n10ik(is_update) ./ (2 * a_vU_n10ik(is_update) + 2);
        
        Z = pdf('Normal', m_mU_n10ik(is_update), mean_val, sqrt(std_val));
        Z1 = pdf('Normal', m_mU_n10ik(is_update), mean_val, sqrt(std_val1));
        Z2 = pdf('Normal', m_mU_n10ik(is_update), mean_val, sqrt(std_val2));
        
        %update for hat_....
        %%
        para.h_v_mU10ik(is_update) = 2 * b_vU_n10ik(is_update) ./ (2 *a_vU_n10ik(is_update) - 2) + v_u_n10ik(i,is_update);
        para.h_m_mU10ik(is_update) = m_u_n10ik(i,is_update);
        para.h_v_u10ik(i,is_update) = 2 * b_vU_n10ik(is_update) ./ (2 * a_vU_n10ik(is_update) - 2) + v_mU_n10ik(is_update);
        para.h_m_u10ik(i,is_update) = m_mU_n10ik(is_update);
        
        %a dot and b dot
        ad = (a_vU_n10ik(is_update) .* Z1 .* Z1) ./ ((a_vU_n10ik(is_update) + 1) .* Z .* Z2 - a_vU_n10ik(is_update) .* Z1 .* Z1);
        bd = (b_vU_n10ik(is_update) .* Z .* Z1) ./ ((a_vU_n10ik(is_update) + 1) .* Z .* Z2 - a_vU_n10ik(is_update) .* Z1 .* Z1);
        
        para.h_a_vU10ik(is_update) = ad - a_vU_n10ik(is_update) + 1;
        para.h_b_vU10ik(is_update) = bd - b_vU_n10ik(is_update);
        
        %%
        para.v_mU = (1 ./ ((1 ./ v_mU_n10ik) + (1 ./ para.h_v_mU10ik)));
        para.m_mU = para.v_mU .* (m_mU_n10ik ./ v_mU_n10ik + para.h_m_mU10ik ./ para.h_v_mU10ik);
        
        para.v_u(i,:) = (1 ./ ((1 ./ v_u_n10ik(i,:)) + (1 ./ para.h_v_u10ik(i,:))));
        para.u_u(i,:) = para.v_u(i,:) .* (m_u_n10ik(i,:) ./ v_u_n10ik(i,:) + para.h_m_u10ik(i,:) ./ para.h_v_u10ik(i,:));
        
        para.a_vU = a_vU_n10ik + para.h_a_vU10ik - 1;
        para.b_vU = b_vU_n10ik + para.h_b_vU10ik;
        
    end

end