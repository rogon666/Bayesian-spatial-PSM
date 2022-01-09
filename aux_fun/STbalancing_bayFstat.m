%% Bayesian extension of the Smith & Todd Balancing Regression Approach
% x: vector n x 1 con n-datos de la variable explicativa
%    a la que se quiere evaluar la propiedad de balanceo
% p: PSM scores estimados (n x 1)
% d: variable dicotómica de tratamiento
function Fpval = STbalancing_bayFstat(x,p,d)
Z = [ones(size(x,1),1) p p.^2 p.^3 p.^4 d d.*p d.*p.^2 d.*p.^3 d.*p.^4]; %matriz extendida con polinomions y términos cruzados
T = size(Z,1); % número de datos
k = size(Z,2); % parámetros
%% OLS estimators
b_hat = (Z'*Z)\(Z'*x); 
M_x = eye(T) - Z*inv(Z'*Z)*Z';
s = x'*M_x*x;
%% Prior hyper-parameters
M_prior = eye(k);       % prior precision matrix
b_prior = zeros(k,1);
s_prior = 1;
v_prior = 1;
%% Posterior hyper-parameters (Natural conjugate Bayesian estimators)
M_star = M_prior + Z'*Z;
b_star = inv(M_star)*(M_prior*b_prior + Z'*Z*b_hat);
s_star = s_prior + s + (b_prior - b_hat)'*inv(inv(M_prior)+inv(Z'*Z))*(b_prior - b_hat);
v_star = v_prior + T;
% Linear restrictions
R = [0 0 0 0 0 1 0 0 0 0; ...
     0 0 0 0 0 0 1 0 0 0; ...
     0 0 0 0 0 0 0 1 0 0; ...
     0 0 0 0 0 0 0 0 1 0; ...
     0 0 0 0 0 0 0 0 0 1];
r = [0 0 0 0 0]';
m = 5; % Restricciones en los 5 términos que involucran
       % la variable dicotómica de tratamiento
% Bayesian F-stat
numerador = (R*b_star - r)'...
            *inv(R*inv(M_star)*R')...
            *(R*b_star - r);
denominad = m*s_star;
F = v_star*(numerador/denominad);
%Fstat = finv(0.95,m,v_star); % F inverse cdf
Fpval = fcdf(F,m,v_star);    % Bayesian p-value  