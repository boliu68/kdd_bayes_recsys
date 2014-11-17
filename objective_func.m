function [ obj ] = objective_func(para, O,local_para)
%COMPUTE_ENTROPY Summary of this function goes here
%   Detailed explanation goes here

m_c_n11 = local_para.m_c_n11;
v_c_n11 = local_para.v_c_n11;
m_u_n11 = local_para.m_u_n11;
v_u_n11 = local_para.v_u_n11;
m_v_n11 = local_para.m_v_n11;
v_v_n11 = local_para.v_v_n11;


[nnz_i, nnz_j, ~] = find(O);

nnz_mu = para.m_u(nnz_i,:)';
nnz_mv = para.m_v(nnz_j,:)';
nnz_vu = para.v_u(nnz_i,:)';
nnz_vv = para.v_v(nnz_j,:)';

nnz_mu2 = nnz_mu .^2 ;
nnz_mv2 = nnz_mv .^2 ;

obj1 = sum(((m_c_n11(O)' - dot(nnz_mu, nnz_mv)).^2 + dot(nnz_vu,nnz_mv2)  + dot(nnz_vv, nnz_mu2) + dot(nnz_vu,nnz_vv)) ./ (2 * v_c_n11(O)'));
obj2 = sum(sum((para.v_u + para.m_u.^2 - 2*para.m_u.*m_u_n11) ./ (2 * v_u_n11)));
obj3 = sum(sum((para.v_v + para.m_v.^2 - 2*para.m_v.*m_v_n11) ./ (2 * v_v_n11)));
obj4 = sum(sum(log(para.v_u)) + sum(log(para.v_v)));

obj = obj1 + obj2 + obj3 - obj4

end

