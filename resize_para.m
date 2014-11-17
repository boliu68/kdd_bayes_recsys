function para = resize_para(hyperpara)

n = hyperpara.n;
d = hyperpara.d;
h = hyperpara.h;
L = hyperpara.L;

para.m_a = [para.m_a; sparse(zeros(1,d))];
para.v_a = [para.v_v;(hyperpara.iv * ones(n,d))/L];

para.m_c = [para.m_c; sparse(zeros(n,d))];
para.v_c = [para.v_c;(hyperpara.iv * ones(n,d)/L)];

para.m_u = [para.m_u; 10 * rand(1,h) - 0.5];
para.v_u = [para.v_u; para.iv * ones(1,h)]% / sqrt(L);

%f6
para.h_a_gmarow = [para.h_a_gmarow6; hyperpara.a0];
para.h_b_gmarow = [para.h_b_gmarow6; hyperpara.b0];

%f10
para.h_v_mU10 = [para.h_v_mU10;hyperpara.iv * ones(1,h)];
para.h_m_mU10 = [para.h_m_mU10;zeros(1,h)];
para.h_v_u10 = [para.h_v_u10; hyperpara.iv * ones(1,h)];
para.h_m_u10 = [para.h_m_u10; zeros(1,h)];
para.h_a_vU10 = [para.h_a_vU10;zeros(1,h)];
para.h_b_vU10 = [para.h_b_vU10;zeros(n,h)];

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
end