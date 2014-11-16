function para = update_f9(para, hyperpara)

d = hyperpara.d;
n = hyperpara.n;
h = hyperpara.h;
L = hyperpara.L;

v_mV_n9jk = 10 * ones(1,h);
m_mV_n9jk = rand(1,h);
v_v_n9jk = 10 * ones(d,h);
m_v_n9jk = rand(d,h);
a_vV_n9jk = rand(1,h);
b_vV_n9jk = rand(1,h);

for j = 1:d
    for k = 1:h
        %h dimension
        v_mV_n9jk = (1 ./ ((1 ./ para.v_mV) - (1 ./ para.h_v_mV9(j,:))));
        m_mV_n9jk = v_mV_n9jk .* ((para.m_mV ./ para.v_mV - para.h_m_mV9(j,:)) ./ para.h_v_mV9(j,:));
        
        %d * h matrix
        v_v_n9jk(j,k) = (1 ./ ((1 ./ para.v_v(j,k)) - (1 ./ para.h_v_v9(j,k))));
        m_v_n9jk(j,k) = v_v_n9jk(j,k) .* ((para.m_v(j,k) ./ para.v_v(j,k)) - para.h_m_v9(j,k) ./ para.h_v_v9(j,k));
        
        %h dimension
        a_vV_n9jk = (para.a_vV - para.h_a_vV9(j,:) + 1);
        b_vV_n9jk = (para.b_vV - para.h_b_vV9(j,:));
        
        if ( b_vV_n9jk(k) > 0) && ((2 * a_vV_n9jk(k) - 2) > 0) && (v_mV_n9jk(k) > 0) && (v_v_n9jk(j,k) > 0)
            
            %normalization of h dimension
            mean_val = m_v_n9jk(j,k);
            %might need sqrt here
            std_val = v_v_n9jk(j,k) + v_mV_n9jk(k) + (2 * b_vV_n9jk(k)) ./ (2 * a_vV_n9jk(k) - 2);
            std_val1 = v_v_n9jk(j,k) + v_mV_n9jk(k) + (2 * b_vV_n9jk(k)) ./ (2 * a_vV_n9jk(k));
            std_val2 = v_v_n9jk(j,k) + v_mV_n9jk(k) + (2 * b_vV_n9jk(k)) ./ (2 * a_vV_n9jk(k) + 2);
            
            Z = normpdf(m_mV_n9jk(k), mean_val, sqrt(std_val));
            Z1 = normpdf(m_mV_n9jk(k), mean_val, sqrt(std_val1));
            Z2 = normpdf(m_mV_n9jk(k), mean_val, sqrt(std_val2));
            
            para.h_v_mV9(j,k) = 2 * b_vV_n9jk(k) ./ (2 * a_vV_n9jk(k) - 2) + v_v_n9jk(j,k);
            para.h_m_mV9(j,k) = m_v_n9jk(j,k);
            para.h_v_v9(j,k) = 2 * b_vV_n9jk(k) / (2 * a_vV_n9jk(k) - 2) + v_mV_n9jk(k);
            para.h_m_v9(j,k) = m_mV_n9jk(k);
            
            %a dot and b dot
            ad = (a_vV_n9jk(k) .* Z1 .* Z1) ./ ((a_vV_n9jk(k) + 1) .* Z .* Z2 - a_vV_n9jk(k) .* Z1 .* Z1);
            bd = (b_vV_n9jk(k) .* Z .* Z1) ./ ((a_vV_n9jk(k) + 1) .* Z .* Z2 - a_vV_n9jk(k) .* Z1 .* Z1);
            
            para.h_a_vV9(j,k) = ad - a_vV_n9jk(k) + 1;
            para.h_b_vV9(j,k) = bd - b_vV_n9jk(k);
            
            para.v_mV(k) = (1 ./ ((1 ./ v_mV_n9jk(k)) + (1 ./ para.h_v_mV9(j,k))));
            para.m_mV(k) = para.v_mV(k) .* (m_mV_n9jk(k) ./ v_mV_n9jk(k) + para.h_m_mV9(j,k) ./ para.h_v_mV9(j,k));
            
            para.v_v(j,k) = (1 ./ ((1 ./ v_v_n9jk(j,k)) + (1 ./ para.h_v_v9(j,k))));
            para.m_v(j,k) = para.v_v(j,k) .* (m_v_n9jk(j,k) ./ v_v_n9jk(j,k) + para.h_m_v9(j,k) ./ para.h_v_v9(j,k));
            
            para.a_vV(k) = a_vV_n9jk(k) + para.h_a_vV9(j,k) - 1;
            para.b_vV(k) = b_vV_n9jk(k) + para.h_b_vV9(j,k);
            
        end
        %         para.v_mV(k) = (1 ./ ((1 ./ v_mV_n9jk(k)) + (1 ./ para.h_v_mV9(j,k))));
        %         para.m_mV(k) = para.v_mV(k) .* (m_mV_n9jk(k) ./ v_mV_n9jk(k) + para.h_m_mV9(j,k) ./ para.h_v_mV9(j,k));
        %
        %         para.v_v(j,k) = (1 ./ ((1 ./ v_v_n9jk(j,k)) + (1 ./ para.h_v_v9(j,k))));
        %         para.m_v(j,k) = para.v_v(j,k) .* (m_v_n9jk(j,k) ./ v_v_n9jk(j,k) + para.h_m_v9(j,k) ./ para.h_v_v9(j,k));
        %
        %         para.a_vV(k) = a_vV_n9jk(k) + para.h_a_vV9(j,k) - 1;
        %         para.b_vV(k) = b_vV_n9jk(k) + para.h_b_vV9(j,k);
    end
end

end