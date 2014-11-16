function para = update_f10(para, hyperpara)

d = hyperpara.d;
n = hyperpara.n;
h = hyperpara.h;
L = hyperpara.L;

v_mU_n10ik = 10 * ones(1,h);
m_mU_n10ik = zeros(1,h);
v_u_n10ik = 10 * ones(n,h);
m_u_n10ik = zeros(n,h);
a_vU_n10ik = zeros(1,h);
b_vU_n10ik = zeros(1,h);

for i = 1:n
    for k = 1:h
        v_mU_n10ik = (1 ./ ((1 ./ para.v_mV(k)) - (1 ./ para.h_v_mU10(i,:))));
        m_mU_n10ik = v_mU_n10ik .* (para.m_mU(k) ./ para.v_mU(k) - para.h_m_mU10(i,:) ./ para.h_v_mU10(i,:));
        
        v_u_n10ik(i,k) = (1 ./ ((1 ./ para.v_u(i,k)) - (1 ./ para.h_v_u10(i,k))));
        m_u_n10ik(i,k) = v_u_n10ik(i,k) .* (para.m_u(i,k) ./ para.v_u(i,k) - para.h_m_u10(i,k) ./ para.h_v_u10(i,k));
        
        a_vU_n10ik = para.a_vU - para.h_a_vU10(i,:) + 1;
        b_vU_n10ik = para.b_vU - para.h_b_vU10(i,:);
        
        %%
        %normalize Z
        if (v_u_n10ik(i,k) > 0) & (v_mU_n10ik(k) > 0) & (b_vU_n10ik(k) > 0) & ((2 * a_vU_n10ik(k) - 2) >0)
            
            mean_val = m_u_n10ik(i,k);
            std_val = v_u_n10ik(i,k) + v_mU_n10ik(k) + 2 * b_vU_n10ik(k) ./ (2 * a_vU_n10ik(k) - 2);
            std_val1 = v_u_n10ik(i,k) + v_mU_n10ik(k) + 2 * b_vU_n10ik(k) ./ (2 * a_vU_n10ik(k));
            std_val2 = v_u_n10ik(i,k) + v_mU_n10ik(k) + 2 * b_vU_n10ik(k) ./ (2 * a_vU_n10ik(k) + 2);
            
            Z = normpdf(m_mU_n10ik(k), mean_val, sqrt(std_val));
            Z1 = normpdf(m_mU_n10ik(k), mean_val, sqrt(std_val1));
            Z2 = normpdf(m_mU_n10ik(k), mean_val, sqrt(std_val2));
            
            %update for hat_....
            %%
            para.h_v_mU10(i,k) = 2 * b_vU_n10ik(k) ./ (2 *a_vU_n10ik(k) - 2) + v_u_n10ik(i,k);
            para.h_m_mU10(i,k) = m_u_n10ik(i,k);
            para.h_v_u10(i,k) = 2 * b_vU_n10ik(k) ./ (2 * a_vU_n10ik(k) - 2) + v_mU_n10ik(k);
            para.h_m_u10(i,k) = m_mU_n10ik(k);
            
            %a dot and b dot
            ad = (a_vU_n10ik(k) .* Z1 .* Z1) ./ ((a_vU_n10ik(k) + 1) .* Z .* Z2 - a_vU_n10ik(k) .* Z1 .* Z1);
            bd = (b_vU_n10ik(k) .* Z .* Z1) ./ ((a_vU_n10ik(k) + 1) .* Z .* Z2 - a_vU_n10ik(k) .* Z1 .* Z1);
            
            para.h_a_vU10(i,k) = ad - a_vU_n10ik(k) + 1;
            para.h_b_vU10(i,k) = bd - b_vU_n10ik(k);
            
            %             para.v_mU(k) = (1 ./ ((1 ./ v_mU_n10ik(k)) + (1 ./ para.h_v_mU10(i,k))));
            %             para.m_mU(k) = para.v_mU(k) .* (m_mU_n10ik(k) ./ v_mU_n10ik(k) + para.h_m_mU10(i,k) ./ para.h_v_mU10(i,k));
            %
            %             para.v_u(i,k) = (1 ./ ((1 ./ v_u_n10ik(i,k)) + (1 ./ para.h_v_u10(i,k))));
            %             para.m_u(i,k) = para.v_u(i,k) .* (m_u_n10ik(i,k) ./ v_u_n10ik(i,k) + para.h_m_u10(i,k) ./ para.h_v_u10(i,k));
            %
            %             para.a_vU(k) = a_vU_n10ik(k) + para.h_a_vU10(i,k) - 1;
            %             para.b_vU(k) = b_vU_n10ik(k) + para.h_b_vU10(i,k);
            
        end
        %%
        para.v_mU(k) = (1 ./ ((1 ./ v_mU_n10ik(k)) + (1 ./ para.h_v_mU10(i,k))));
        para.m_mU(k) = para.v_mU(k) .* (m_mU_n10ik(k) ./ v_mU_n10ik(k) + para.h_m_mU10(i,k) ./ para.h_v_mU10(i,k));
        
        para.v_u(i,k) = (1 ./ ((1 ./ v_u_n10ik(i,k)) + (1 ./ para.h_v_u10(i,k))));
        para.m_u(i,k) = para.v_u(i,k) .* (m_u_n10ik(i,k) ./ v_u_n10ik(i,k) + para.h_m_u10(i,k) ./ para.h_v_u10(i,k));
        
        para.a_vU(k) = a_vU_n10ik(k) + para.h_a_vU10(i,k) - 1;
        para.b_vU(k) = b_vU_n10ik(k) + para.h_b_vU10(i,k);
        
    end
end

end