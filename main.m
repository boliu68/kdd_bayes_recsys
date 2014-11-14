% This is the main function of this project

%n: #Users
%d: #Items
%L: #Classes
%h: The rank of matrix

%% Setting hyperparameters
m_mu = 0;
m_mv = 0;
v_mu = 1;
v_mv = 1;

a0p = 10/2;
b0p = 10/2;

a0 = 10/2;
b0 = 10*sqrt(10) /2;

m_b0 = [-6; -2; 2; 6];
v0 = 0.1;

max_iter = 100;   %iteration number

%% Initialization should be here

a_gamcol = a0 * zeros(d,1);
b_gamcol = b0 * zeros(d,1);

a_gamrow = a0 * zeros(n,1);
b_gamrow = b0 * zeros(n,1);

m_b = zeros(d, L-1);
v_b = 10 * ones(d,L-1);

m_a = zeros(n, d);
v_a = 10 * ones(n, d);

m_c = zeros(n, d);
v_c = 10 * ones(n, d);

m_u = zeros(n, h);
v_u = 10 * ones(n. h);

m_v = zeros(d, h);
v_v = 10 * ones(d, h);

m_mu = m_mu * ones(h, 1);
v_mu = v_mu * ones(h, 1);

m_mv = m_mv * ones(h, 1);
v_mu = v_mu * ones(h, 1);

a_vu = ones(h, 1);
b_vu = ones(h, 1);

a_vv = ones(h, 1);
b_vv = ones(h, 1);


% This is the iteration of update
for iter = 1:max_iter
    
    
    
    
    
end

