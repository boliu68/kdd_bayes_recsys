

n = hyperpara.n;
d = hyperpara.d;
h = hyperpara.h;
L = hyperpara.L;


%for f1
para.h_a_vV1 = hypapara.a0d * ones(1, h);
para.h_b_vV1 = hypapara.b0d * ones(1, h);
para.a_vV = para.h_a_vV1;
para.b_vV = para.h_b_vV1;

%f2
para.h_a_vU2 = hyperpara.a0d * ones(1, h);
para.h_b_vU2 = hyperpara.b0d * ones(1, h);
para.a_vU = para.h_a_vU2;
para.b_vU = para.h_b_vU2;

%f3
para.h_m_mV3 = zeros(1,h);
para.h_v_mV3 = ones(1,h);
para.m_mV = zeros(1,h);
para.v_mV = ones(1,h);

%f4
para.h_m_mU4 = zeros(1,h);
para.h_v_mU4 = ones(1,h);
para.m_mU = zeros(1,h);
para.v_mU = ones(1,h);

%f5
para.h_a_gmacol5 = hyperpara.a0 * ones(1,d);
para.h_b_gmacol5 = hyperpara.b0 * ones(1,d);
para.a_gmacol = para.h_a_gmacol5;
para.b_gmacol = para.h_b_gmacol5;

%f6
para.h_a_gmarow= hyperpara.a0 * ones(1,n);
para.h_b_gmarow= hyperpara.b0 * ones(1,n);
para.a_gmarow= para.h_a_gmacol5;
para.b_gmarow= para.h_b_gmacol5;

%f7
para.h_m_b07 = hyperpara.m_b0;
para.h_v_b07 = hyperpara.v0 * ones(size(para.h_m_b07));
para.m_b0 = para.h_m_b07;
para.v_b0 = para.h_v_b07;

%f8
para.h_m_b08 = zeros(1,L-1,d);
para.h_v_b08 = 10 * ones (1,L-1,d);
para.h_m_b8 = zeros(d,L-1,d);
para.h_v_b8 = 10 * ones(d,L-1,d);

para.m_b0 = zeros(1, L-1);
para.v_b0 = 10 * ones(1, L-1);
%initial Q currently by random
%para.m_b0, para.v_b = init_gaussian(para.h_m_b08, para.h_v_b08);
%[para.m_b, para.v_b] = init_gaussian(para.h_m_b8, para.h_v_b8);

%f9
para.h_v_mV9 = 10 * ones(1,h, d,h);
para.h_m_mV9 = zeros(1,h,d,h);
para.h_v_v9 = 10 * ones(d,h,d,h);
para.h_m_v9 = zeros(d,h,d,h);
para.h_a_vV9 = ones(1,h,d,h);
para.h_b_vV9 = ones(1,h,d,h);

para.a_vV = ones(1,h);
para.b_vV = ones(1,h);
%[para.m_mV, para.v_mV] = init_gaussian(para.h_m_mV9, para.h_v_mV9);
%[para.m_v, para.v_v] = init_gaussian(para.h_m_v9, para.h_v_v9);
%[para.a_vV, para.b_vV] = init_inverse_gma(para.a_vV, para.b_vV);

%f10
para.h_v_mU10ik = 10 * ones(1,h);
para.h_m_mU10ik = zeros(1,h);
para.h_v_u10ik = 10 * ones(n,h);
para.h_m_u10ik = zeros(n,h);
para.h_a_vU10ik = zeros(1,h);
para.h_b_vU10ik = zeros(1,h);

para.v_mU = 10 * ones(1,h);
para.m_mU = zeros(1,h);
para.v_u = 10 * ones(n,h);
para.u_u = zeros(n,h);
para.a_vU = zeros(1,h);
para.b_vU = zeros(1,h);

%f11
para.h_v_v11 = 10 * ones(d,h);
para.h_m_v11 = zeros(d,h);
para.h_v_u11 = 10 * ones(n,h);
para.h_m_u11 = zeros(n,h);
para.h_v_c11 = 10 * ones(n,d);
para.h_m_c11 = zeros(n,d);

para.m_c = zeros(n,d);
para.v_c = 10 * ones(n,d);

%f12
 para.h_m_a12ij = zeros(n,d);
 para.h_v_a12ij = 10 * ones(n,d);
 para.h_m_c12ij = zeros(n,d);
 para.h_v_c12ij = 10 * ones(n,d);
 para.h_a_gmarow12ij = zeros(1,n);
 para.h_b_gmarow12ij = zeros(1,n);
 para.h_a_gmacol12ij = zeros(1,d);
 para.h_b_gmacol12ij = zeros(1,d);

 para.v_a = 10 * ones(n,d);
 para.m_a = zeros(n,d);
 %para.v_c = 10 * ones(n,d);
 %para.m_c = zeros(n,d);
 para.a_gmarow = zeros(1,n);
 para.b_gmarow = zeros(1,n);
 para.a_gmacol = zeros(1,d);
 para.b_gmacol = zeros(1,d);

 %f13
 para.h_m_b13ijk = zeros(d,L-1);
 para.h_v_b13ijk = 10 * ones(d,L-1);
 para.h_m_a13ijk = zeros(n,d);
 para.h_v_a13ijk = 10 * ones(n,d);
 %para.v_b = 10 * ones(d,L-1);
 %para.m_b = zeros(d,L-1);
 %para.v_a = 10 * ones(n,d);
 %para.m_a = zeros(n,d);
