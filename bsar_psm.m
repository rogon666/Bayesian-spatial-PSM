%% Estimation, BSAR-Probit model
clc
close all
p = path;
addpath(p,'aux_fun')
disp('Estimating...')
disp('(this might take a while)')
tic
    res = psm_bsarp(y,x,W,ndraw,nomit,prior,I);
    disp('Estimation concluded')
ttoc = toc;
%% Figures
    chaint_nnm = chainthin(res.sdraw_nnm);
    chaint_scm = chainthin(res.sdraw_scm);
    chaint_srm = chainthin(res.sdraw_srm);
    figure
    pepfigures(res.sdraw_nnm,chaint_nnm); 
    suptitle('Spatial Average Treatment Effect - NN matching'); 
    figure
    pepfigures(res.sdraw_scm,chaint_scm); 
    suptitle('Spatial Average Treatment Effect - SCM matching');
    figure
    pepfigures(res.sdraw_srm,chaint_srm); 
    suptitle('Spatial Average Treatment Effect - SRM matching');
%% Intervalos de credibilidad Bayesianos (ICB)
    bci = 0.95;  % ICB al 95% de probabilidad
    ateci_nnm = quantile(res.sdraw_nnm,[(1-bci)/2 1 - (1-bci)/2]);
    ateci_scm = quantile(res.sdraw_scm,[(1-bci)/2 1 - (1-bci)/2]);
    ateci_srm = quantile(res.sdraw_srm,[(1-bci)/2 1 - (1-bci)/2]);
    clc
disp('===========================================')
disp('Bayesian Spatial PSM estimation')
disp('SAR model (Probit link function)')
disp('-----------------------------------------------------------------------------')
disp('                        Posterior mean      95% credible interval')
disp(['SATE (NNM)           ', mat2str(mean(res.sdraw_nnm),3), '                   ', mat2str(ateci_nnm,3)])
disp(['SATE (SCM)           ', mat2str(mean(res.sdraw_scm),3), '                   ', mat2str(ateci_scm,3)])
disp(['SATE (SRM)           ', mat2str(mean(res.sdraw_srm),3), '                   ', mat2str(ateci_srm,3)])
disp('-----------------------------------------------------------------------------')
disp('Estimation time:')
fprintf('%d minutes, %f seconds\n',floor(ttoc/60),rem(ttoc,60))
disp('-----------------------------------------------------------------------------')
disp('SATE: Spatial Average Treatment Effect')
disp('NNM : Nearest Neighbor Matching')
disp('SCM : Spatial Caliper Matching')
disp('SRM : Spatial Radial Matching')
disp('SAR : Spatial Autoregressive Model')
disp('===========================================')
clear ateci_nnm ateci_scm ateci_srm bci ttoc chaint_*
path(p); clear p