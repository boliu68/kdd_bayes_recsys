function para = init_para(O, hyperpara)

n = hyperpara.n;
d = hyperpara.d;
h = hyperpara.h;
L = hyperpara.L;

%Initilization for the total parameters
para.a_vV = 0.000001 * ones(1, h) * d;
para.b_vV = 0.000001 * ones(1, h) * d;

para.a_vU = 0.000001 * ones(1, h) * n;
para.b_vU = 0.000001 * ones(1, h) * n;

para.m_mV = rand(1,h);
para.v_mV = hyperpara.iv * ones(1,h) / (n + 1);

para.m_mU = rand(1,h);
para.v_mU = hyperpara.iv * ones(1,h) / (n + 1);

para.a_gmacol = hyperpara.a0 * ones(1,d);
para.b_gmacol = hyperpara.b0 * ones(1,d);

para.a_gmarow= hyperpara.a0 * ones(1,n);
para.b_gmarow= hyperpara.b0 * ones(1,n);

para.m_b0 = hyperpara.m_b0;
para.v_b0 = hyperpara.v0 * ones(1, L-1);

para.m_b = repmat(para.m_b0, d,1) - rand(d,L-1);
para.v_b = hyperpara.iv * ones(d,L-1) / (n + 1);

para.m_a = sparse(zeros(n,d));
para.m_a(O) = rand(nnz(O),1);
para.v_a = init_v(O,n,d,hyperpara.iv) / (L+1);%hyperpara.iv * ones(n,d) + rand(n,d);

para.m_c = sparse(zeros(n,d));
para.m_c(O) = rand(nnz(O),1);
para.v_c = init_v(O,n,d,hyperpara.iv) / 2;%hyperpara.iv * ones(n,d) + rand(n,d);

para.m_u = 10 * (rand(n,h) - 0.5);
para.v_u = hyperpara.iv * ones(n,h) / sqrt(n);% / sqrt(L);

para.m_v = 10 * (rand(d,h) - 0.5);
para.v_v = hyperpara.iv * ones(d,h) / sqrt(n);% / sqrt(L)

%for f1
para.h_a_vV1 = 0.00001 * ones(1, h);
para.h_b_vV1 = 0.00001 * ones(1, h);

%f2
para.h_a_vU2 = 0.00001 * ones(1, h);
para.h_b_vU2 = 0.00001 * ones(1, h);

%f3
para.h_m_mV3 = zeros(1,h);
para.h_v_mV3 = ones(1,h);

%f4
para.h_m_mU4 = zeros(1,h);
para.h_v_mU4 = ones(1,h);

%f5
para.h_a_gmacol5 = hyperpara.a0 * ones(1,d);
para.h_b_gmacol5 = hyperpara.b0 * ones(1,d);

%f6
para.h_a_gmarow6 = hyperpara.a0 * ones(1,n);
para.h_b_gmarow6 = hyperpara.b0 * ones(1,n);

%f7
para.h_m_b07 = hyperpara.m_b0;
para.h_v_b07 = hyperpara.v0 * ones(size(para.h_m_b07));

%f8
para.h_m_b08 = repmat(para.m_b0,d,1);%zeros(d,L-1);
para.h_v_b08 = hyperpara.iv * ones(d,L-1);
para.h_m_b8 = repmat(para.m_b0, d, 1);%zeros(d,L-1);
para.h_v_b8 = hyperpara.iv * ones(d,L-1);

%f9
para.h_v_mV9 = hyperpara.iv * ones(d,h);
para.h_m_mV9 = zeros(d,h);
para.h_v_v9 = hyperpara.iv * ones(d,h);
para.h_m_v9 = zeros(d,h);
para.h_a_vV9 = 0.00001 * ones(d,h);
para.h_b_vV9 = 0.00001 * ones(d,h);

%para.a_vV = ones(1,h);
%para.b_vV = ones(1,h);
% [para.m_mV, para.v_mV] = init_gaussian(para.h_m_mV9, para.h_v_mV9);
% [para.m_v, para.v_v] = init_gaussian(para.h_m_v9, para.h_v_v9);
% [para.a_vV, para.b_vV] = init_inverse_gma(para.h_a_vV9, para.h_b_vV9);
% para.m_mV = zeros(1,h);
% para.v_mV = hyperpara.iv * ones(1,h) / sqrt(h);
% para.a_vV = ones(1,h);
% para.b_vV = ones(1,h);

%f10
para.h_v_mU10 = hyperpara.iv * ones(n,h);
para.h_m_mU10 = zeros(n,h);
para.h_v_u10 = hyperpara.iv * ones(n,h);
para.h_m_u10 = zeros(n,h);
para.h_a_vU10 = 0.00001 * ones(n,h);
para.h_b_vU10 = 0.00001 * ones(n,h);

% [para.m_mU, para.v_mU] = init_gaussian(para.h_m_mUhyperpara.iv, para.h_v_mUhyperpara.iv);
% [para.m_u, para.v_u] = init_gaussian(para.h_m_uhyperpara.iv, para.h_v_uhyperpara.iv);
% [para.a_vU, para.b_vU] = init_inverse_gma(para.h_a_vUhyperpara.iv, para.h_b_vUhyperpara.iv);


%f11 not use EP
para.h_v_v11 = hyperpara.iv * ones(d,h);
para.h_m_v11 = zeros(d,h);
para.h_v_u11 = hyperpara.iv * ones(n,h);
para.h_m_u11 = zeros(n,h);
para.h_v_c11 = init_v(O,n,d,hyperpara.iv);%hyperpara.iv * ones(n,d);
para.h_m_c11 = sparse(zeros(n,d));


%f12
para.h_m_a12 = sparse(zeros(n,d));
para.h_v_a12 = init_v(O,n,d,hyperpara.iv);%hyperpara.iv * ones(n,d);
para.h_m_c12 = sparse(zeros(n,d));
para.h_v_c12 = init_v(O,n,d,hyperpara.iv);%hyperpara.iv * ones(n,d);
para.h_a_gmarow12 = sparse(zeros(n,d));
para.h_a_gmarow12(O) = hyperpara.a0;

para.h_b_gmarow12 = sparse(zeros(n,d));
para.h_b_gmarow12(O) = hyperpara.b0;

para.h_a_gmacol12 = sparse(zeros(n,d));
para.h_a_gmacol2(O) = hyperpara.a0;

para.h_b_gmacol12 = sparse(zeros(n,d));
para.h_b_gmacol12(O) = hyperpara.b0;



%  [para.m_a, para.v_a] = init_gaussian(para.h_m_a12, para.h_v_a12);
%  [para.a_gmarow, para.b_gmarow] = init_inverse_gma(para.h_a_gmarow12, para.h_b_gmarow12);
%  [para.a_gmacol, para.b_gmacol] = init_inverse_gma(para.h_a_gmacol12, para.h_b_gmacol12);

%
%  para.h_m_b13 = sparse(zeros(n,d,L-1));
%  para.h_v_b13 = zeros()%hyperpara.iv * ones(n,d,L-1);
%  para.h_m_a13 = zeros(n,d,L-1);
%  para.h_v_a13 = hyperpara.iv * ones(n,d,L-1);
for k = 1:L-1
    h_m_b13_tmp = sparse(zeros(n,d));
    h_m_b13_tmp(O) = hyperpara.m_b0(k);
    para.h_m_b13{k} = h_m_b13_tmp;
end
%para.h_m_b13 = repmat(h_m_b13_cell}, 1, L-1);
para.h_v_b13 = repmat({init_v(O,n,d,hyperpara.iv)}, 1, L-1);
para.h_m_a13 = repmat({sparse(zeros(n,d))}, 1, L-1);
para.h_v_a13 = repmat({init_v(O, n,d,hyperpara.iv)}, 1, L-1);


%para.v_b = hyperpara.iv * ones(d,L-1);
%para.m_qb = zeros(d,L-1);
%para.v_a = hyperpara.iv * ones(n,d);
%para.m_a = zeros(n,d);


end
