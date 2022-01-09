%% Post-estimation routines
%  Efron's R2
p = path;
path(p,'aux_fun')
eR2 = efronR2(y,x,res.bdraw);
er2 = median(eR2)*100;
disp('===================================')
disp('Efron''s Pseudo R-squared*')
disp('(proportion of explained variance')
disp(' in the spatial probit function): ')
disp([mat2str(er2,4) '%'])
disp('-------------------------------------------------------------')
disp('(*) Efron, B. (1978). Regression and ANOVA') 
disp('with zero-one data: Measures of residual')
disp('variation. Journal of the American Statistical')
disp('Association, 73, pp. 113-121.') 
disp('===================================')
    clear er2 eR2
    path(p); clear p