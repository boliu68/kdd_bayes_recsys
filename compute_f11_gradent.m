function [ g_m_u, g_m_v ] = compute_f11_gradent(hyperpara,  para,O, local_para )
%COMPUTE_F11_GRADENT Summary of this function goes here
%   Detailed explanation goes here
n = hyperpara.n;
h = hyperpara.h;
L = hyperpara.L;
d = hyperpara.d;

[obs_row, obs_col, ~] = find(O);

m_c_11 = local_para.m_c_n11(O);
v_c_11 = local_para.v_c_n11(O);
m_u_11_t = local_para.m_u_n11(obs_row,:);
v_u_11_t = local_para.v_u_n11(obs_row,:);
v_v_11_t = local_para.v_v_n11(obs_col,:);

m_v_11 = local_para.m_v_n11;
m_u_11 = local_para.m_u_n11;
v_u_11 = local_para.v_u_n11;
v_v_11 = local_para.v_v_n11;

m_u = para.m_u;
m_v = para.m_v;
v_v = para.v_v;
v_u = para.v_u;

m_u_t = para.m_u(obs_row, :);
m_v_t = para.m_v(obs_col, :);
v_v_t = para.v_v(obs_col, :);
v_u_t = para.v_u(obs_row, :);



mumv = dot(m_u_t, m_v_t, 2);

tmp1 = m_c_11 - mumv;
tmp1 = bsxfun(@times, tmp1, m_v_t);
tmp1 = (tmp1 + v_v_t .* m_u_t);
tmp1 = bsxfun(@rdivide, tmp1, v_c_11);

tmp = ones(n,h);
for i = 1: h
    tmp(:,i) = accumarray(obs_row, tmp1(:,i), [n, 1]);
end
tmp2 = (m_u - m_u_11)./v_u_11;

g_m_u = tmp + tmp2;


tmp1 = m_c_11 - mumv;
tmp1 = bsxfun(@times, tmp1, m_u_t);
tmp1 = (tmp1 + v_u_t .* m_v_t);
tmp1 = bsxfun(@rdivide, tmp1, v_c_11);

tmp = ones(d,h);
for i = 1: h
    tmp(:,i) = accumarray(obs_col, tmp1(:,i), [d, 1]);
end

tmp2 = (m_v - m_v_11)./v_v_11;

g_m_v = tmp + tmp2;



end

