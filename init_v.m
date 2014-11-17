function v = init_v(O, n,d,iv)
    v = zeros(n,d);
    v(O) = iv + rand - 0.5;
    v = sparse(v);

end