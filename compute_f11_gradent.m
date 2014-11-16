function [ g_m_u, g_m_v ] = compute_f11_gradent( para,O, local_para )
%COMPUTE_F11_GRADENT Summary of this function goes here
%   Detailed explanation goes here

[obs_row, obs_col, ~] = find(O);

m_c_11 = local_para.m_c_n11(O);
v_c_11 = local_para.v_c_n11(O);
m_u_11 = local_para.m_u_n11(obs_row);
v_u_11 = local_para.v_u_n11(obs_row);

m_u = para.m_u(obs_row, :);
m_v = para.m_v(obs_col, :);
v_v = para.v_v(obs_col, :);
v_u = para.v_u(obs_row, :);



mumv = dot(m_u, m_v, 1);

tmp1 = m_c_11 - mumv;
tmp1 = bsxfun(@times, tmp1, m_v);
tmp1 = (tmp1 + v_v .* m_u);
tmp1 = bsxfun(@rdivide, tmp1, v_c_11);

tmp1 = accumarray([obs_row, 1:h], tmp1, [n,h]);

tmp2 = (m_u - m_u_11)./v_u_11;

g_m_u = tmp1 + tmp2;


tmp1 = m_c_11 - mumv;
tmp1 = bsxfun(@times, tmp1, m_u);
tmp1 = (tmp1 + v_u .* m_v);
tmp1 = bsxfun(@rdivide, tmp1, v_c_11);

tmp1 = accumarray([obs_col, 1:h], tmp1, [d,h]);

tmp2 = (m_v - m_v_11)./v_v_11;

g_m_v = tmp1 + tmp2;



end

