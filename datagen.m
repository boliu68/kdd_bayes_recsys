%This file Generate toy data according to Houlsby2014

%% Parameter Setting
n = 50;  % #Users
d = 40; % #Items

L = 5; % #Classes

h = 10;  % The rank of matrix

%%prior parameters

m_mu = 0;
m_mv = 0;
v_mu = 1;
v_mv = 1;

m_u = normrnd(m_mu, v_mu, [1,h]);
m_v = normrnd(m_mv, v_mv, [1,h]);

%a_0', b_0'
a0p = 10/2;
b0p = 10/2;
v_u = gamrnd(a0p, 1/b0p, [1,h]);
v_v = gamrnd(a0p, 1/b0p, [1,h]);

a0 = 10/2;
b0 = 10*sqrt(10) /2;

gam_row = gamrnd(a0, 1/b0, [1,n]);
gam_col = gamrnd(a0, 1/b0, [1,d]);

m_b0 = [-6 -2 2 6];
v0 = 0.1;

b0 = normrnd(m_b0, v0 * ones(size(m_b0)));

%% Parameters

% u
U = zeros(h, n);
for i = 1:n
    U(:,i) = normrnd(m_u, v_u);
end

% v
V = zeros(h, d);
for i = 1:d
    V(:,i) = normrnd(m_v, v_v);
end

% c
C = U' * V;

% a
A = normrnd(C, gam_row' * gam_col);

% B
B = zeros(L-1, d);
for i = 1:d
    B(:,i) = normrnd(b0, v0);
end

%R
tmp = zeros(size(A));
for i = 1: L-1
    tmp = tmp + bsxfun(@ge, A, B(i,:));
end


R = tmp + 1;
R = sparse(R);
O = sparse(randi([0,1],size(R)) == 1);



B = B';
V = V';
U = U';


