function [ query_entry ] = active_get_entry( para, hyperpara,O, user )
%ACTIVE_GET_ENTRY Summary of this function goes here
%   Detailed explanation goes here

O_user = O(user, :);

val_user = find(O_user);

Nval_user = length(val_user);

inforgain  = zeros(Nval_user,1);
for i = 1:Nval_user
     test_entry.row = user;
     test_entry.col = val_user(i);
     
     inforgain(i) = compute_user_infogain( para, hyperpara, test_entry );
end

%[~, query_entry] = max(inforgain);
[~, query_entry] = sort(inforgain, 2, 'descend');

end

