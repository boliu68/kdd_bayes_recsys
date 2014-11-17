function rmse_err = rmse(prediction, R, O)

%Test
%RMSE
rmse_err = sqrt(sum((R(O) - prediction).^2) / length(prediction));


end