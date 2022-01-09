%% Post-estimation routines
%  Spatial correlation estimator
% ------------------------------------------
p = path;
path(p,'aux_fun')
chain = res.pdraw;
% Thinning:
    [chaint, athin] = chainthin(chain);
% Intervalos de credibilidad Bayesianos (ICB)
    bci = 0.95;  % ICB al 95% de probabilidad
    ci_full = quantile(chain,[(1-bci)/2 1 - (1-bci)/2]);
    ci_thin = quantile(chaint,[(1-bci)/2 1 - (1-bci)/2]);
% ----------------------------------------
% Figures
figure
pepfigures(chain,chaint)
suptitle('Spatial correlation coefficient (Bayesian estimation)')
% -------------------------------------
% Tables
disp('============================================')
disp('Spatial correlation coefficient (Bayesian estimation)')
disp('-----------------------------------------------------------------------------')
disp('                          Posterior mean      95% credible interval')
disp(['Unthinned chain      ', mat2str(median(chain),3), '                ', mat2str(ci_full,3)])
disp(['Thinned chain*        ', mat2str(median(chaint),3), '                ', mat2str(ci_thin,3)])
disp('-----------------------------------------------------------------------------')
disp(['(*) Thin (automatic): ' mat2str(athin)])
disp('============================================')
    clear acf athin bci bounds chain chaint ci_full ci_thin g gbins h 
    path(p); clear p