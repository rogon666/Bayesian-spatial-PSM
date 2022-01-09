%% Post-estimation routines
% Gelman-Rubin statistic
% (Bayesian Natural-Conjugate version of the Smith & Todd test)
p = path;
path(p,'aux_fun')
disp('Gelman-Rubin statistic')
path(p); clear p