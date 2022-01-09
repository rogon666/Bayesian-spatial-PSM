%% Matriz de proximidad
% Funci�n que convierte la Matriz de distancias 
% euclideanas W a una matriz binaria de proximidad M
%   1: regiones cercanas entre s�
%   0: regiones alejadas entre s�
function M = converse(W)
    l = size(W,1);
    M = zeros(l,l);
    u = 0;
for i = 1:l
    for j = 1:l
        if W(i,j) > u
            M(i,j) = 1;
        else
            M(i,j) = 0;
        end
    end
end