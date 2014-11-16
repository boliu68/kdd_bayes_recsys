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
[nnz_i, nnz_j, ~] = find(O);

v_v_n11 = (1 ./ ((1 ./ para.v_v) - (1 ./ para.h_v_v11)));
m_v_n11 = v_v_n11 .* (para.m_v ./ para.v_v - para.h_m_v11 ./ para.h_v_v11);

v_u_n11 = (1 ./ ((1 ./ para.v_u) - (1 ./ para.h_v_u11)));
m_u_n11 = v_u_n11 .* (para.m_u ./ para.v_u - para.h_m_u11 ./ para.h_v_u11);

v_c_n11 = (1 ./ ((1 ./ para.v_c) - (1 ./ para.h_v_c11)));
m_c_n11 = v_c_n11 .* (para.m_c ./ para.v_c - para.h_m_c11 ./ para.h_v_c11);

%%
obj = objective_func(para, O, m_c_n11, v_c_n11, m_u_n11, v_u_n11, m_v_n11, v_v_n11)
%Waiting for Update


para.m_c(O) = dot(para.m_u(nnz_i,:)', para.m_v(nnz_j,:)')';
para.v_c(O) = dot((para.m_u(nnz_i,:)').^2, para.v_v(nnz_j,:)')' + dot(para.v_u(nnz_i,:)', (para.m_v(nnz_j,:)').^2)' + dot(para.v_u(nnz_i,:)', para.v_v(nnz_j,:)')';

%%
%refine hat f11 avoid negative
h_v_v11_upd = (1 ./ ((1 ./ para.v_v) - (1 ./ v_v_n11)));
h_v_u11_upd = (1 ./ ((1 ./ para.v_u) - (1 ./ v_u_n11)));
h_v_c11_upd = (1 ./ ((1 ./ para.v_c) - (1 ./ v_c_n11)));

is_update = h_v_v11_upd > 0;
para.h_v_v11(is_update) = h_v_v11_upd(is_update);%(1 ./ ((1 ./ para.v_v(j,is_update)) + (1 ./ v_v_n11(j,is_update))));
para.h_m_v11(is_update) = para.h_v_v11(is_update) .* (para.m_v(is_update) ./ para.v_v(is_update) - m_v_n11(is_update) ./ v_v_n11(is_update));

is_update = h_v_u11_upd >0;
para.h_v_u11(is_update) = h_v_u11_upd(is_update);%(1 ./ ((1 ./ para.v_u(i, is_update)) + (1 ./ v_u_n11(i, is_update))));
para.h_m_u11(is_update) = para.h_v_u11(is_update) .* (para.m_u(is_update) ./ para.v_u(is_update) - m_u_n11(is_update) ./ v_u_n11(is_update));

is_update = h_v_c11_upd>0;
para.h_v_c11(is_update) = (1 ./ ((1 ./ para.v_c(is_update)) - (1 ./ v_c_n11(is_update))));
para.h_m_c11(is_update) = para.h_v_c11(is_update) .* (para.m_c(is_update) ./ para.v_c(is_update) - m_c_n11(is_update) ./ v_c_n11(is_update));


end