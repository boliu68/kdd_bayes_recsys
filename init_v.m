function v = init_v(O, n,d)
    v = zeros(n,d);
    v(O) = 10 - rand;
    v = sparse(v);

end