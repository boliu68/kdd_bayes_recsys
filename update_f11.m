function para = update_f11(para, hyperpara, O)
    
    d = hyperpara.d;
    n = hyperpara.n;
    h = hyperpara.h;
    L = hyperpara.L;

    v_v_n11 = 10 * ones(d,h);
    m_v_n11 = zeros(d,h);
    v_u_n11 = 10 * ones(n,h);
    m_u_n11 = zeros(n,h);
    v_c_n11 = 10 * ones(n,d);
    m_c_n11 = zeros(n,d);

    %udpate f11 based on observation matrix O
    %%
    %n * k and d * k
    for i = 1:n
        for j = 1:d

            if O(i,j) ~= 1
                continue
            end

            v_v_n11(j,:) = (1 ./ ((1 ./ para.v_v(j,:)) - (1 ./ para.h_v_v11(j,:))));
            m_v_n11(j,:) = v_v_n11(j,:) .* (para.m_v(j,:) ./ para.v_v(j,:) - para.h_m_v11(j,:) ./ para.h_v_v11(j,:));
            
            v_u_n11(i,:) = (1 ./ ((1 ./ para.v_u(i,:)) - (1 ./ para.h_v_u11(i,:))));
            m_u_n11(i,:) = v_u_n11(i,:) .* (para.m_u(i,:) ./ para.v_u(i,:) - para.h_m_u11(i,:) ./ para.h_v_u11(i,:));
            
            %%
            %n * d matrix
            
            v_c_n11(i,j) = (1 ./ ((1 ./ para.v_c(i,j)) - (1 ./ para.h_v_c11(i,j))));
            m_c_n11(i,j) = v_c_n11(i,j) .* (para.m_c(i,j) ./ para.v_c(i,j) - para.h_m_c11(i,j) ./ para.h_v_c11(i,j));
            
            %%
            %upate n * d only for those of O%
            m_c_old = para.m_c(i,j);
            v_c_old = para.v_c(i,j);
            para.m_c(i,j) = (para.m_u(i,:) * para.m_v(j,:)');
            para.v_c(i,j) = (para.m_u(i,:) .^ 2 * para.v_v(j,:)' + para.v_u(i,:) * (para.m_v(j,:) .^ 2)' + para.v_u(i,:) * para.v_v(j,:)');
            
            %%
            %refine hat f11
            %avoid negative

            if (1 ./ ((1 ./ para.v_c(i,j)) - (1 ./ v_c_n11(i,j)))) > 0

                is_update = (1 ./ ((1 ./ para.v_v(j,:)) + (1 ./ v_v_n11(j,:)))) >0 & (1 ./ ((1 ./ para.v_u(i,:)) + (1 ./ v_u_n11(i,:)))) >0 & (1 ./ ((1 ./ para.v_c(i,j)) - (1 ./ v_c_n11(i,j)))) > 0;
                
                para.h_v_v11(j, is_update) = (1 ./ ((1 ./ para.v_v(j,is_update)) + (1 ./ v_v_n11(j,is_update))));
                para.h_m_v11(j, is_update) = para.h_v_v11(j, is_update) .* (para.m_v(j, is_update) ./ para.v_v(j, is_update) - m_v_n11(j, is_update) ./ v_v_n11(j, is_update));
                
                para.h_v_u11(i, is_update) = (1 ./ ((1 ./ para.v_u(i, is_update)) + (1 ./ v_u_n11(i, is_update))));
                para.h_m_u11(i, is_update) = para.h_v_u11(i,is_update) .* (para.m_u(i,is_update) ./ para.v_u(i,is_update) - m_u_n11(i,is_update) ./ v_u_n11(i,is_update));
                
                %for i j \in O
                para.h_v_c11(i,j) = (1 ./ ((1 ./ para.v_c(i,j)) - (1 ./ v_c_n11(i,j))));
                para.h_m_c11(i,j) = para.h_v_c11(i,j) .* (para.m_c(i,j) ./ para.v_c(i,j) - m_c_n11(i,j) ./ v_c_n11(i,j));
            else
                %eliminate the EP update of Q.
                para.m_c(i,j) = m_c_old;
                para.v_c(i,j) = v_c_old;
            end
        end
    end
    
end