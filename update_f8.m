function para = update_f8(para, hyperpara)

    %initialize new matrix
    L = hyperpara.L;
    d = hyperpara.d;

    v_b0_n8j = 10 * ones(1,L-1);
    m_b0_n8j = para.m_b0;
    v_b_n8j = 10 * ones(d,L-1);
    m_b_n8j = zeros(d,L-1);

    %k = 1 for L, j = 1 to d
    %L * d
    for j = 1:d
        %L dimension vector
        %b0 = test(para,hyperpara, v_b0_n8j,m_b0_n8j,v_b_n8j, m_b_n8j,j);

        v_b0_n8j = (1 ./ ((1 ./ para.v_b0) - (1 ./ para.h_v_b08(j,:))));
        m_b0_n8j = v_b0_n8j .* ((para.m_b0 ./ para.v_b0) - para.h_m_b08(j,:) ./ para.h_v_b08(j,:));

        v_b_n8j(j,:) = (1 ./ ((1 ./ para.v_b(j,:)) - (1 ./ para.h_v_b8(j,:))));
        m_b_n8j(j,:) = v_b_n8j(j,:) .* (para.m_b(j,:) ./ para.v_b(j,:) - para.h_m_b8(j,:) ./ para.h_v_b8(j,:));

                        if j==36
            disp >>>>>>>
            disp before
            disp <<<<<<<
        	disp vb0;
            disp(1./para.v_b0);
        
            disp vb08
            disp(1./para.h_v_b08(j,:));
            
            disp vb0n8
            disp(1./v_b0_n8j);
            
        	disp vb;
            disp(1./para.v_b(j,:));
        
            disp vb8
            disp(1./para.h_v_b8(j,:));
            
            disp vbn8
            disp(1./v_b_n8j(j,:));   
            
            disp mb0;
            disp(para.m_b0);
        
            disp mb08
            disp(para.h_m_b08(j,:));
            
            disp mb0n8
            disp(m_b0_n8j);
            
        	disp mb;
            disp(para.m_b(j,:));
        
            disp mb8
            disp(para.h_m_b8(j,:));
            
            disp mbn8
            disp(m_b_n8j(j,:)); 
            
        end
        para.h_m_b08(j,:) = m_b_n8j(j,:);
        para.h_v_b08(j,:) = v_b_n8j(j,:) + hyperpara.v0;
        para.h_m_b8(j,:) = m_b0_n8j;
        para.h_v_b8(j,:) = v_b0_n8j + hyperpara.v0;

        para.v_b0 = (1 ./ ((1 ./ v_b0_n8j) + (1 ./ para.h_v_b08(j,:))));
        para.m_b0 = para.v_b0 .* ((m_b0_n8j ./ v_b0_n8j) + para.h_m_b08(j,:) ./ para.h_v_b08(j,:));
        
        para.v_b(j,:) = (1 ./ ((1 ./ v_b_n8j(j,:)) + (1 ./ para.h_v_b8(j,:))));
        para.m_b(j,:) = para.v_b(j,:) .* ((m_b_n8j(j,:) ./ v_b_n8j(j,:)) + para.h_m_b8(j,:) ./ para.h_v_b8(j,:));
    end
    
end

function b0 = test(tmp_para,hyperpara, v_b0_n8j,m_b0_n8j,v_b_n8j, m_b_n8j,j)
        
        para = tmp_para;
        v_b0_n8j = (1 ./ ((1 ./ para.v_b0) - (1 ./ para.h_v_b08(j,:))));
        m_b0_n8j = v_b0_n8j .* ((para.m_b0 ./ para.v_b0) - para.h_m_b08(j,:) ./ para.h_v_b08(j,:));

        v_b_n8j(j,:) = (1 ./ ((1 ./ para.v_b(j,:)) - (1 ./ para.h_v_b8(j,:))));
        m_b_n8j(j,:) = v_b_n8j(j,:) .* (para.m_b(j,:) ./ para.v_b(j,:) - para.h_m_b8(j,:) ./ para.h_v_b8(j,:));

        para.h_m_b08(j,:) = m_b_n8j(j,:);
        para.h_v_b08(j,:) = v_b_n8j(j,:) + hyperpara.v0;
        para.h_m_b8(j,:) = m_b0_n8j;
        para.h_v_b8(j,:) = v_b0_n8j + hyperpara.v0;

        para.v_b0 = (1 ./ ((1 ./ v_b0_n8j) + (1 ./ para.h_v_b08(j,:))));
        para.m_b0 = para.v_b0 .* ((m_b0_n8j ./ v_b0_n8j) + para.h_m_b08(j,:) ./ para.h_v_b08(j,:));
        
        b0 = para.m_b0;

end