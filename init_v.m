function v = init_v(O, n,d,iv)
    v = zeros(n,d);
<<<<<<< HEAD
    v(O) = 10 ;
=======
    v(O) = iv + rand - 0.5;
>>>>>>> 3ace767f36d087dc986c66248c61c6b44267fec2
    v = sparse(v);

end