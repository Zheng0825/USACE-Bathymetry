clc
clear 

% N = 116; 
% dx = 10; 

N = 47; 
dx = 25; 

[h,x] = get_hOct1;
[hgrid,xq] = interp_h(h,x,dx);
h_guess = initialize_h_guess_pointwise(hgrid, xq, dx);

% load('k_2_5percNoisedata.mat','k'); 
 load('k_1percNoisedata_N47.mat','k'); 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fmincon: Find minimum of constrained nonlinear multivariable function
%options = optimoptions('Display','off');
options  = optimset('Display', 'iter', 'TolFun', 1e-5, 'MaxIter', 30);          %,'MaxIter',10   %,'TolFun',1e-3
h_hat3   = fminsearch(@objective_2norm, h_guess, options);              %, [], [], [], [], zeros(N,1), repmat(12, [N,1]), []


figure(3)
stem(hgrid, '*b');
hold on
stem(h_hat3, '^r');
hold on
stem(h_guess, '<')
title('fmincon method', 'fontSize',14)
xlabel('Distance from the coastline','FontSize',14);
ylabel('Depth','FontSize',14);
legend({'True h', 'Recovered h', 'initial guess h'},'FontSize',14);

