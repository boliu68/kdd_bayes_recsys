function v = init_v(O, n,d)
    v = zeros(n,d);
    v(O) = 10 ;
    v = sparse(v);

end