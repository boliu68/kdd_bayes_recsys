function para = update_f13(para, hyperpara, O, R)

	for i = 1:n
		for j = 1:d
			for k = 1:L-1

				v_b_n13ijk(j,k) = (1 / ((1 / para.v_b(j,k)) - (1 / para.h_v_b13ijk(j,k))));
				m_b_n13ijk(j,k) = v_b_n13ijk(j,k) * (para.m_b(j,k) / para.v_b(j,k) - para.h_m_b13ijk(j,k) / para.v_b_13ijk(j,k));

				v_a_n13ijk(i,j) = (1 / ((1 / para.v_a(i,j)) - (1 / para.h_v_a13ijk(i,j))));
				m_a_n13ijk(i,j) = v_a_n13ijk(i,j) * (para.m_a(i,j) / para.v_a(i,j) - para.h_m_a13ijk(i,j) / para.h_v_a13ijk(i,j));

				alpha = sign(R(i,j) - k - 0.5) * (m_a_n13ijk(j,k) - m_b_n13ijk(j,k)) / sqrt((v_a_n13ijk(j,k) + v_b_n13ijk(j,k)));
				phi_alpha = pdf('Normal', alpha, 0, 1);
				cphi_alpha = pdf()

				bta = - phi_alpha / cphi_alpha * (alpha + phi_alpha / cphi_alpha) / (v_a_n13ijk(j,k) + v_b_n13ijk(j,k));
				kta = - (sign(R(i,j) - k - 0.5) / sqrt(v_a_n13ijk(j,k) + v_b_n13ijk(j,k))) / (alpah + phi_alpha / cphi_alpha);

				para.h_m_b13ijk(j,k) = m_b_n13ijk(j,k) + kta;
				para.h_v_b13ijk(j,k) = - v_b_n13ijk(j,k) - 1/bta;
				para.h_m_a13ijk(i,j) = m_a_n13ijk(i,j) - kta;
				para.h_v_a13ijk(i,j) = - v_a_n13ijk(i,j) - 1/bta;

				%recompute 
				para.v_b(j,k) = (1 / ((1 / v_b_n13ijk(j,k)) - (1 - para.h_v_b13ijk(j,k))));
				para.m_b(j,k) = para.v_b(j,k) * (m_b_n13ijk(j,k) / v_b_n13ijk(j,k) + para.h_m_b13ijk(j,k) / para.h_v_b13ijk(j,k));
				para.v_a(i,j) = (1 / ((1 / v_a_n13ijk(i,j)) - (1 / para.h_v_a13ijk(i,j))));
				para.m_a(i,j) = para.v_a(i,j) * (m_a_n13ijk(i,j) / v_a_n13ijk(i,j) + para.h_m_a13ijk(i,j) / para.h_v_a13ijk(i,j));

			end
		end
	end

end