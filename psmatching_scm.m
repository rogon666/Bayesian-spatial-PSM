function SATE = psmatching_scm(y,X,B,I,W)
%% Spatial caliper propensity score matching
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   y: vector (n x 1) binario (1,0) que indexa a las n-regiones con acceso (1) y sin acceso (0)
%   X: matrix (n x p) de p-covariantes de control 
%   B: vector (n x 1) de pesos (importancia) de cada covariante
%   I: vector (n x 1) con la variable de impacto de acceso financiero
%   W: matriz (n x n) cuadrada de distancias euclideanas entre regiones
% (0) M: matriz (n x n) cuadrada, binaria, de cercania entre regiones
M = converse(W);
% (1) Propensity Score
    probit = @(Xbhat) normcdf(Xbhat,0,1); % función probit (CDF de una distribución normal)
    pscore = probit(X*B);             % mapea las estimaciones del modelo espacial a probabilidades
% (2) Matching
diff = zeros(1,sum(y)); % pre-allocating (crea un vector vacio para agilizar el bucle)
wm = M(y==1,:);         % sub-matriz de proximidad binaria (para regiones CON acceso)
It = I(y==1);           % impacto en las regiones con acceso
Iu = I(y==0);           % impacto en las regiones sin acceso
pst = pscore(y==1);     % probabilidades de las regiones con acceso
% ---------------
% En el siguiente bucle se comparara la probabilidad 
% de cada region con acceso pst(k) con las probabilidades
% de todas las regiones sin acceso (psu), ponderadas por 
% la distancia geográfica (espacial) de cada región a la región k
for k = 1:sum(y)                        % para k= 1,...,sum(y) regiones con acceso
        wmpscore = pscore.*wm(k,:)';            % probabilidades ponderadas por la distancia entre regiones (scores espaciales)
        psw = wmpscore(y==0);           % probabilidades ponderadas de las regiones sin acceso 
                                        % (scores espaciales de regiones
                                        % sin acceso financiero)                                
        dis = abs(pst(k)-psw);          % distancia entre scores
        indu = dis == min(dis(:));          % mínima distancia entre scores
        diff(k) = It(k) - mean(Iu(indu));   % diferencia entre la región k y el promedio de
                                            % las regiones matcheadas
end
SATE = mean(diff);                % Efecto de tratamiento medio espacial
                                  % Spatial Average Treatment Effect (SATE)