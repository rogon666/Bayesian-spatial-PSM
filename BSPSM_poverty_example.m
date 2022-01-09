% --------------------------------------------
% Bayesian Spatial PSM: example file 
% * Probit Link 
% * Spatial Functions: SAM, SEM
%           SAM: Spatial Autoregressive Model
%           SEM: Spatial Error Model
% * Matching technologies: NN, SCM, SRM 
%           NNM: Nearest Neighbors Matching
%           SCM: Spatial Caliper Matching
%           SRM: Spatial Radial Matching
% Rolando Gonzales 
% Original code: December 2014
% Updated and tested to run in MatLab 2020a
% January 2022
% --------------------------------------------
clear; clc
close all
%% Temporary path for auxiliary functions
p = path;
addpath(p,'aux_fun')
%% Data 
    % Poverty data
    load data_poverty
        I = poverty;
        clear poverty
    %Data from Bolivia
    load data_xy_bolivia
            % y: regional financial access
            %   (1 tiene acceso, 0 no tine acceso)
            % X: matrix of control covariates
        n = length(y);
        x = [ones(n,1) X]; % with constant
    % Adjacency matrix
    load W
        contour(W')
        title('Adjacency stochastic matrix: Bolivia, municipality level','FontWeight','bold')
        axis square
        grid on
        colorbar
%% Swarmplots (descriptive analysis)
figure
    swarmplot(I,y)
    ylabel('% of people')
    title('Regional Poverty','FontWeight','bold')
    grid on
    hold off
%% Bayesian estimation: priors & MCMC calibration
    % Prior Hyperparameters
        prior.rmin = 0; % rho lower uniform prior
        prior.rmax = 1; % rho upper uniform prior
    % MCMC calibration
        ndraw  = 11000;
        nomit  = 1000;    % Burn-in
%% Observed differences
clc
disp('=============================')
disp('Observed regional differences')
disp('---------------------------------------------------')
disp('           Regions                  Average')
disp(['With financial access           ' mat2str(mean(I(y==1)),4)])
disp(['Without financial access      ' mat2str(mean(I(y==0)),4)])
disp('---------------------------------------------------')
disp(['Observed difference: ' mat2str(mean(I(y==1)) - mean(I(y==0)),4)])
disp('=============================')
path(p); clear p
%% BS-SPM with a spatial error model (SEM):
run bsem_psm
%% BS-SPM with a spatial autoregressive model (SAR):
% run bsar_psm
% Activate the line above if you want to run BS-PSM with a SAR model