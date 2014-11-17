function para = resize_para(O, hyperpara)

n = hyperpara.n;
d = hyperpara.d;
h = hyperpara.h;
L = hyperpara.L;

para.m_a = [para.m_a; sparse(zeros(1,d))];
para.v_a = init_v(O,n,d,hyperpara.iv) / (L+1);%hyperpara.iv * ones(n,d) + rand(n,d);

para.m_c = [para.m_c; sparse(zeros(n,d))];

para.v_c = [para.v_c; para.iv * ones(1,d)];%hyperpara.iv * ones(n,d) + rand(n,d);

para.m_u = [para.m_u; 10 * rand(1,h) - 0.5];
para.v_u = [para.v_u; para.iv * ones(1,h)]% / sqrt(L);

%f6
para.h_a_gmarow = [para.h_a_gmarow6; hyperpara.a0];
para.h_b_gmarow = [para.h_b_gmarow6; hyperpara.b0];

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
para.h_v_mU10 = [para.h_v_mU10;hyperpara.iv * ones(1,h)];
para.h_m_mU10 = [para.h_m_mU10;zeros(1,h)];
para.h_v_u10 = [para.h_v_u10; hyperpara.iv * ones(1,h)];
para.h_m_u10 = [para.h_m_u10; zeros(1,h)];
para.h_a_vU10 = [para.h_a_vU10;zeros(1,h)];
para.h_b_vU10 = [para.h_b_vU10;zeros(n,h)];

% [para.m_mU, para.v_mU] = init_gaussian(para.h_m_mUhyperpara.iv, para.h_v_mUhyperpara.iv);
% [para.m_u, para.v_u] = init_gaussian(para.h_m_uhyperpara.iv, para.h_v_uhyperpara.iv);
% [para.a_vU, para.b_vU] = init_inverse_gma(para.h_a_vUhyperpara.iv, para.h_b_vUhyperpara.iv);


%f11 not use EP
para.h_v_u11 = [para.h_v_u11; hyperpara.iv * ones(1,h)];
para.h_m_u11 = [para.h_m_u11;zeros(1,h)];
para.h_v_c11 = [para.h_v_c11;hyperpara.iv * sparse(ones(1,d))]%hyperpara.iv * ones(n,d);
para.h_m_c11 = [para.h_m_c11;sparse(zeros(1,d))];


%f12
para.h_m_a12 = [para.h_m_a12;sparse(zeros(1,d))];
para.h_v_a12 = [para.h_v_a12;hyperpara.iv * ones(1,d)];
para.h_m_c12 = [para.h_m_c12; sparse(zeros(1,d))];
para.h_v_c12 = [para.h_v_c12;hyperpara.iv * ones(1,d)];
para.h_a_gmarow12 = [para.h_a_gmarow12; a0 * sparse(ones(1,d))];

para.h_b_gmarow12 = [para.h_b_gmarow12; b0 * sparse(ones(1,d))];

para.h_a_gmacol12 = [para.h_a_gmacol12; a0 * sparse(ones(n,d))];

para.h_b_gmacol12 = [para.h_b_gmacol12; b0 * sparse(ones(n,d))];


for k = 1:L-1
    
    h_m_b13_tmp = [para.h_m_b13{k};sparse(hyperpara.m_b0(k) * ones(1,d))];
    para.h_m_b13{k} = h_m_b13_tmp;
    
    h_v_b13_tmp = [para.h_v_b13{k};sparse(hyperpara.iv * ones(1,d))];
    para.h_v_b13{k} = h_v_b13_tmp;
    
    h_m_a13_tmp = [para.h_m_a13{k};sparse(hyperpara.iv * ones(1,d))];
    para.h_m_b13{k} = h_m_b13_tmp;
    
    h_v_a13_tmp = [para.h_v_a13{k};sparse(hyperpara.iv * ones(1,d))];
    para.h_v_a13{k} = h_v_a13_tmp;
    
end

%para.v_b = hyperpara.iv * ones(d,L-1);
%para.m_qb = zeros(d,L-1);
%para.v_a = hyperpara.iv * ones(n,d);
%para.m_a = zeros(n,d);


end