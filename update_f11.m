function para = update_f11(para, hyperpara, O, iter)

d = hyperpara.d;
n = hyperpara.n;
h = hyperpara.h;
L = hyperpara.L;

v_v_n11 = 10 * ones(d,h);
m_v_n11 = zeros(d,h);
v_u_n11 = 10 * ones(n,h);
m_u_n11 = zeros(n,h);
v_c_n11 = sparse(zeros(n,d));
v_c_n11(O) = 10;
m_c_n11 = sparse(zeros(n,d));

%udpate f11 based on observation matrix O
[nnz_i, nnz_j, ~] = find(O);

v_v_n11 = (1 ./ ((1 ./ para.v_v) - (1 ./ para.h_v_v11)));
m_v_n11 = v_v_n11 .* (para.m_v ./ para.v_v - para.h_m_v11 ./ para.h_v_v11);

v_u_n11 = (1 ./ ((1 ./ para.v_u) - (1 ./ para.h_v_u11)));
m_u_n11 = v_u_n11 .* (para.m_u ./ para.v_u - para.h_m_u11 ./ para.h_v_u11);

v_c_n11(O) = (1 ./ ((1 ./ para.v_c(O)) - (1 ./ para.h_v_c11(O))));
m_c_n11(O) = v_c_n11(O) .* (para.m_c(O) ./ para.v_c(O) - para.h_m_c11(O) ./ para.h_v_c11(O));

old_vv = para.v_v;
old_vu = para.v_u;

%%
%Compute for v_u, v_v

m_v_t = para.m_v(nnz_j,:);
m_u_t = para.m_u(nnz_i,:);
v_v_t = para.v_v(nnz_j,:);
v_u_t = para.v_u(nnz_i,:);
v_c_n11_t = v_c_n11(O);

tmp1 = bsxfun(@rdivide, (m_v_t.^2 + v_v_t),  v_c_n11_t);
tmp2 = ones(n,h);
for i = 1:h
    tmp2(:,i) = accumarray(nnz_i, tmp1(:,i), [n,1]);
end
tmp3 = 1./v_u_n11;

para.v_u = 1./(tmp2 + tmp3);
para.v_u(para.v_u <= 0) = old_vu(para.v_u <= 0);

tmp1 = bsxfun(@rdivide,(m_u_t.^2 + v_u_t), v_c_n11_t);
tmp2 = ones(d,h);
for i = 1:h
    tmp2(:,i) = accumarray(nnz_j, tmp1(:,i), [d,1]);
end
tmp3 = 1./v_v_n11;

para.v_v = 1./(tmp2 + tmp3);
para.v_v(para.v_v <= 0) = old_vv(para.v_v <= 0);

%Waiting for Update
local_para.v_v_n11 = v_v_n11;
local_para.m_v_n11 = m_v_n11;
local_para.v_u_n11 = v_u_n11;
local_para.m_u_n11 = m_u_n11;
local_para.v_c_n11 = v_c_n11;
local_para.m_c_n11 = m_c_n11;
option.stepsize = 0.0001;
option.eps = 1;
option.maxiter = 5;
old_mu = para.m_u;
old_mv = para.m_v;
[para.m_u, para.m_v] = f11_gradient_update(para, hyperpara, local_para, option, O);

old_m_c = para.m_c;
old_v_c = para.v_c;
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
para.m_v(~is_update) = old_mv(~is_update);
para.v_v(~is_update) = old_vv(~is_update);

is_update = h_v_u11_upd >0;
para.h_v_u11(is_update) = h_v_u11_upd(is_update);%(1 ./ ((1 ./ para.v_u(i, is_update)) + (1 ./ v_u_n11(i, is_update))));
para.h_m_u11(is_update) = para.h_v_u11(is_update) .* (para.m_u(is_update) ./ para.v_u(is_update) - m_u_n11(is_update) ./ v_u_n11(is_update));
para.m_u(~is_update) = old_mu(~is_update);
para.v_u(~is_update) = old_vu(~is_update);

is_update = h_v_c11_upd>0;
para.h_v_c11(is_update&O) = (1 ./ ((1 ./ para.v_c(is_update&O)) - (1 ./ v_c_n11(is_update&O))));
para.h_m_c11(is_update&O) = para.h_v_c11(is_update&O) .* (para.m_c(is_update&O) ./ para.v_c(is_update&O) - m_c_n11(is_update&O) ./ v_c_n11(is_update&O));
para.v_c((~is_update) & O) = old_v_c((~is_update)&O);
para.m_c((~is_update)&O) = old_m_c((~is_update)&O);

end