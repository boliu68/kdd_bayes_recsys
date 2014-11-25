clc;
clear;

datapath = 'movielens10k.mat';
R = importdata(datapath);
% R = randi([0,5],200,200);
R = sparse(R);
O = R > 0;
% 
% %
n = size(R,1);
d = size(R,2);
L = 5;
h = 500;

tr_fraction = 0.8;

%random split the Training data and test data
% [nnz_i, nnz_j, ~] = find(O);
% O_tr = O;
% O_tst = sparse(zeros(n,d));
% 
% count = 0;
% while true
%     
%     row_gt2 = zeros(n,1);
%     row_gt2(sum(O,2) > 1) = 1;
%     col_gt2 = zeros(1,d);
%     col_gt2(sum(O) > 1)=1;
%     
%     is_gt2 = sparse(((row_gt2 * col_gt2) == 1) & O_tr);
%     
%     if sum(is_gt2) == 0
%        break 
%     end
%     
%     [nnz_i, nnz_j, ~] = find(is_gt2);
%     idx = randi([1,length(nnz_i)]);
%     
%     O_tst(nnz_i(idx), nnz_j(idx)) = 1;
%     O_tr(nnz_i(idx), nnz_j(idx)) = 0;
%     count = count + 1;
% 
%     if count > floor((1 -tr_fraction) * nnz(O))
%        break 
%     end
% end
% 
% % tr_idx = randsample(nnz(O), floor(tr_fraction * nnz(O)));
% % tr_id=sub2ind(size(O),nnz_i(tr_idx),nnz_j(tr_idx));
% % 
% % O_tr(tr_id) = 1;
% O_tr = O_tr == 1;
% O_tst = (O - O_tr) == 1;

O_tr_tst = importdata('O.mat');
O_tr = O_tr_tst.O_tr;
O_tst = O_tr_tst.O_tst;

hyperpara.n = n;
hyperpara.d = d;
hyperpara.L = L;
hyperpara.h = h;
hyperpara.iv = 100000;


%% Setting hyperparameters
hyperpara.m_mu = 0;
hyperpara.m_mv = 0;
hyperpara.v_mu = 1;
hyperpara.v_mv = 1;

hyperpara.a0d = 10/2;
hyperpara.b0d = 10/2;

hyperpara.a0 = 10/2;
hyperpara.b0 = 10*sqrt(10) /2;

hyperpara.m_b0 = [-6 -2 2 6];
hyperpara.v0 = 10000;

max_iter = 10;   %iteration number

%% Initialization should be here
para = init_para(O_tr, hyperpara);

for iter = 1:max_iter
    disp(['Iteration:',int2str(iter)])
     if iter == 1
        para = update_f1(para, hyperpara);
        para = update_f2(para, hyperpara);
        para = update_f3(para, hyperpara);
        para = update_f4(para, hyperpara);
        para = update_f5(para, hyperpara);
        para = update_f6(para, hyperpara);
        para = update_f7(para, hyperpara);
     end
    para = update_f8(para, hyperpara);
    para = update_f9(para, hyperpara);
    para = update_f10(para, hyperpara);
    para = update_f11(para, hyperpara, O_tr, iter);
    para = update_f12(para, hyperpara, O_tr, iter);
    para = update_f13(para, hyperpara, O_tr, R);
end
[pred_entry.row, pred_entry.col, ~] = find(O_tst);
%trick
para.m_b = sort(para.m_b,2);
%
[ Rpred ] = predfun( para, hyperpara, pred_entry);

tr_err = rmse(Rpred * [1:5]', R, O_tst)
random_err = rmse(1+4*rand(nnz(O_tst),1), R, O_tst)
