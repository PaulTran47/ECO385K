%==========================================================================
%% 2 percentage signs represent sections of code;
% 1 percentage sign represents comments for code or commented out code;

% ECO385K Problem Set 1, 3
% Paul Le Tran, plt377
% 12 October, 2021
%==========================================================================

%==========================================================================
%% Problem info
% Read the paper "Unempployment and Vacancy Fluctuations in the Matching
% Model: Inspecting the Mechanism" by Andreas Hornstein, Per Krusell, and
% Giovanni L. Violante. This paper covers the basic Mortensen-Pissarides
% matching model with exogenous separation, and is where you will find how
% to derive equilibrium-characterising equations (21), (22), and (23) as
% the question requests.
%==========================================================================

%==========================================================================
%% Setting up workspace
clear all;
close all;
clc;

home_dir = 'path\to\programmes';

cd(home_dir);
%==========================================================================

%==========================================================================
%% Part 3a: Parametrise the model using Shimer's calibration. Compute the
% wage and unemployment rate.

% Setting Shimer calibration values
r = 0.012;
sigma = 0.10;
theta = 1;
alpha = 0.72;
A = 1.35;
p = 1;
b = 0.4;
beta = alpha;
c = 0.324;

% Computing job-finding and job-filling rates
lambda_w = A*(theta^(1 - alpha));
lambda_f = A*theta^(-alpha);

% Computing equilibrium wage and unemployment rate
u = sigma/(sigma + lambda_w);
w = beta*(p + c*theta) + (1 - beta)*b;
%==========================================================================

%==========================================================================
%% Part 3bi: Consider a permanent change in sigma from 0.01 to 0.15. What
% would the unemployment rate be if there was no change in the job-finding
% rate for each value of sigma? Plot the unemployment rate as a function of
% sigma for fixed job-finding rate.

% Setting Shimer calibration values
r = 0.012;
sigma = 0.10;
theta = 1;
alpha = 0.72;
A = 1.35;
p = 1;
b = 0.4;
beta = alpha;
c = 0.324;
% We will be keeping lambda_w = 1.35 from part 3a constant.

% Creating matrix that stores unemployment rate with corresponding sigma.
u_sigma_matrix = [zeros(length([0.01:0.01:0.15]'), 1) [0.01:0.01:0.15]'];
% Creating counter for loop
counter = 1;
for sigma = [0.01:0.01:0.15]
  u_sigma_matrix(counter, 1) = sigma/(sigma + 1.35);
  counter = counter + 1;
end
clear counter sigma;

% Saving unemployment rate values for plotting purposes in part 3bii.
u_3bi = u_sigma_matrix(:, 1);
clear u_sigma_matrix;

% Creating function for flow-consistent unemployment rate
urate_3bi = @(sigma) sigma(1)/(sigma(1) + 1.35);

% Creating plot of unemployment rate, when keeping lambda_w = 1.35, between
% sigma values [0.01, 0.15].
fplot(urate_3bi, [0.01, 0.15], 'LineWidth', 1.25);

% Creating axes labels
xlabel('\sigma');
ylabel('%');

% Creating legend
legend('Unemployment rate, fixed \lambda_{w} = 1.35', 'Location', 'Northwest');

% Creating title
title({'Equilibrium unemployment rate as function of \sigma,', '\sigma \in [0.01, 0.15]'});

saveas(gcf, 'path\to\graphics\3bi_plot.png');
close(gcf);
clear urate_3bi;
%==========================================================================

%==========================================================================
%% Part 3bii: Consider a permanent change in sigma from 0.01 to 0.15.
% Computer the wage, theta = v/u, job-finding rate, and the unemployment
% rate for each value of sigma. Plot the unemployment rate as a functio nof
% sigma. Compare with the previous question.

% Setting Shimer calibration values
r = 0.012;
sigma = 0.10;
theta = 1;
alpha = 0.72;
A = 1.35;
p = 1;
b = 0.4;
beta = alpha;
c = 0.324;

% We are no longer keeping the job-finding rate constant like in part 3bi.
% This means we need to use equilibrium condition (21) to solve for theta.
% Clearing Shimer calibration value from Shimer in part 3a.
clear theta;

% Creating matrix that stores equilibrium theta and corresponding sigma.
theta_sigma_matrix = [zeros(length([0.01:0.01:0.15]'), 1) [0.01:0.01:0.15]'];
% Creating counter for loop
counter = 1;
for sigma = [0.01:0.01:0.15]
  syms f(theta);
  f(theta) = (p - b)/(r + sigma + beta*A*(theta^(1 - alpha))) == c/((1 - beta)*A*(theta^(-alpha)));
  theta_sigma_matrix(counter, 1) = double(vpasolve(f, theta));
  counter = counter + 1;
end
clear counter sigma f theta;

% Creating matrix that will house equilbrium unemployment rate, equilibrium
% theta, and corresponding sigma for both.
u_theta_sigma_matrix = [zeros(length([0.01:0.01:0.15]'), 1) theta_sigma_matrix];
clear theta_sigma_matrix;
% Creating counter for loop
counter = 1;
for sigma = [0.01:0.01:0.15]
  u_theta_sigma_matrix(counter, 1) = sigma/(sigma + A*(u_theta_sigma_matrix(counter, 2)^(1 - alpha)));
  counter = counter + 1;
end
clear counter sigma;

% Creating matrix that will house equilibrium wage, unemployment rate,
% theta, and corresponding sigma for all.
w_u_theta_sigma_matrix = [zeros(length([0.01:0.01:0.15]'), 1) u_theta_sigma_matrix];
clear u_theta_sigma_matrix;
% Creating counter for loop
counter = 1;
for sigma = [0.01:0.01:0.15]
  w_u_theta_sigma_matrix(counter, 1) = beta*(p + c*w_u_theta_sigma_matrix(counter, 3)) + (1 - beta)*b;
  counter = counter + 1;
end
clear counter sigma;

% Creating matrix that will store equilibrium job-finding rate, wage,
% unemployment rate, theta, and corresponding sigma for all.
jfr_w_u_theta_sigma_matrix = [zeros(length([0.01:0.01:0.15]'), 1) w_u_theta_sigma_matrix];
clear w_u_theta_sigma_matrix;
% Creating counter for loop
counter = 1;
for sigma = [0.01:0.01:0.15]
  jfr_w_u_theta_sigma_matrix(counter, 1) = A*(jfr_w_u_theta_sigma_matrix(counter, 4)^(1 - alpha));
  counter = counter + 1;
end
clear counter sigma;

% Plotting unemployment rate against sigma values used
plot(jfr_w_u_theta_sigma_matrix(:, 5), jfr_w_u_theta_sigma_matrix(:, 3), 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
% Adding plot of unemployment rate values from part 3bi
plot(jfr_w_u_theta_sigma_matrix(:, 5), u_3bi, 'LineWidth', 1.25, 'Color', [1, 0, 0]);
hold off

% Creating axes labels
xlabel('\sigma');
ylabel('%');

% Creating legend
legend('Unemployment rate, varying \lambda_{w} (Blue)', 'Unemployment rate, fixed \lambda_{w} = 1.35 (Red)', 'Location', 'Northwest');

% Creating title
title({'Equilibrium unemployment rates as functions of \sigma,', '\sigma \in [0.01, 0.15]'});

saveas(gcf, 'path\to\graphics\3bii_plot.png');
close(gcf);
clear u_3bi;
%==========================================================================

%==========================================================================
%% Part 3ci: Consider a permanent change in p by 2%. Compute the wage,
% theta, job-finding rate, and the unemployment rate.

%==========================
% ONLY CONSIDERING INCREASE
%==========================

% Setting Shimer calibration values
r = 0.012;
sigma = 0.10;
theta = 1;
alpha = 0.72;
A = 1.35;
p = 1;
b = 0.4;
beta = alpha;
c = 0.324;

% Starting value of p is Shimer's calibration.
p = 1*1.02;

% Calculating equilibrium theta
syms f(theta);
f(theta) = (p - b)/(r + sigma + beta*A*(theta^(1 - alpha))) == c/((1 - beta)*A*(theta^(-alpha)));
theta_ss = double(vpasolve(f(theta), theta));
clear f;

% Calculating equilibrium job-finding rate
lambda_w = A*(theta_ss^(1 - alpha));

% Calculating equilibrium unemployment rate
u = sigma/(sigma + lambda_w);

% Calculating equilibrium wage
w = beta*(p + c*theta_ss) + (1 - beta)*b;

% Storing all into row vector. Note that these were calculated with beta =
% 0.72.
jfr_w_u_theta_beta_3ci = [lambda_w w u theta_ss beta];

clear theta theta_ss lambda_w u w;
%==========================================================================

%==========================================================================
%% Part 3cii: Consider a permanent change in p by 2%. Redo this by varying
% beta from 0.05 to 0.80.

%==========================
% ONLY CONSIDERING INCREASE
%==========================

% Setting Shimer calibration values
r = 0.012;
sigma = 0.10;
theta = 1;
alpha = 0.72;
A = 1.35;
p = 1;
b = 0.4;
beta = alpha;
c = 0.324;

% Starting value of p is Shimer's calibration.
p = 1*1.02;

% Creating a matrix that houses job-finding rate, wage, unemployment rate,
% theta, and corresponding beta.
jfr_w_u_theta_beta_matrix_3cii = [zeros(length([0.05:0.05:0.80]), 5)];
% Creating counter for loop
counter = 1;
for beta = [0.05:0.05:0.80]
  % Calculating equilibrium theta
  syms f(theta);
  f(theta) = (p - b)/(r + sigma + beta*A*(theta^(1 - alpha))) == c/((1 - beta)*A*(theta^(-alpha)));
  theta_ss = double(vpasolve(f(theta), theta));
  clear f;
  
  % Calculating equilibrium job-finding rate
  lambda_w = A*(theta_ss^(1 - alpha));

  % Calculating equilibrium unemployment rate
  u = sigma/(sigma + lambda_w);

  % Calculating equilibrium wage
  w = beta*(p + c*theta_ss) + (1 - beta)*b;
  
  % Storing into matrix as a row
  jfr_w_u_theta_beta_matrix_3cii(counter, :) = [lambda_w w u theta_ss beta];
  counter = counter + 1;
end
clear counter beta theta theta_ss lambda_w u w;
%==========================================================================

%==========================================================================
%% Part 3ciii: Consider a permanent change in p by 2%. Show how the
% responsiveness of the unemployment rate with respect to productivity
% changes by beta.

% What we are essentially doing is seeing how much u changes if p increases
% by 1% for example, for different values of beta.

%==========================
% ONLY CONSIDERING INCREASE
%==========================

% Setting Shimer calibration values
r = 0.012;
sigma = 0.10;
theta = 1;
alpha = 0.72;
A = 1.35;
p = 1;
b = 0.4;
beta = alpha;
c = 0.324;

% We choose our starting p value to be the initial permanent change of 2%.
% This means if our initial value was the Shimer calibration, starting p
% value is 1*1.02 = 1.02. Using a 1% change as the example, we will call
% p_after as follows:
p = 1*1.02;
p_after = p*1.01;

% Creating matrix that stores the per cent change of u from p to p_after,
% and corresponding beta.
upc_beta_matrix_3ciii = zeros(length([0.05:0.05:0.80]), 2);
% Creating counter for loop
counter = 1;
for beta = [0.05:0.05:0.80]
  % Calculating equilibrium theta for both p and p_after
  syms f(theta);
  f(theta) = (p - b)/(r + sigma + beta*A*(theta^(1 - alpha))) == c/((1 - beta)*A*(theta^(-alpha)));
  theta_ss = double(vpasolve(f(theta), theta));
  clear f;
  syms f(theta_after);
  f(theta_after) = (p_after - b)/(r + sigma + beta*A*(theta_after^(1 - alpha))) == c/((1 - beta)*A*(theta_after^(-alpha)));
  theta_after_ss = double(vpasolve(f(theta_after), theta_after));
  clear f;

  % Calculating equilibrium job-finding rates for both p and p_after
  lambda_w = A*(theta_ss^(1 - alpha));
  lambda_w_after = A*(theta_after_ss^(1 - alpha));

  % Calculating equilibrium unemployment rate for both p and p_after
  u = sigma/(sigma + lambda_w);
  u_after = sigma/(sigma + lambda_w_after);

  % Calculating per cent change of u from p to p_after
  u_pc = (u_after - u)/u;

  upc_beta_matrix_3ciii(counter, :) = [u_pc beta];
  counter = counter + 1;
end
clear counter beta theta theta_ss theta_after theta_after_ss lambda_w lambda_w_after u u_after u_pc;

% Plotting per cent change in unemployment rate against beta's used.
plot(upc_beta_matrix_3ciii(:, 2), upc_beta_matrix_3ciii(:, 1)*100, 'LineWidth', 1.25)

% Creating axes labels
xlabel('\beta');
ylabel('%');

% Setting y-axis interval
set(gca, 'ylim', [-0.51, -0.42]);
set(gca, 'ytick', -0.51:0.01:-0.42);

% Setting x-axis interval
set(gca, 'xlim', [0.05, 0.80]);
set(gca, 'xtick', -0.05:0.05:0.80);

% Creating title
title({'Responsiveness of unemployment rate', 'with respect to productivity changes in \beta,', '1% increase in p,', '\beta \in [0.05, 0.80]'});

saveas(gcf, 'path\to\graphics\3ciii_plot.png');
close(gcf);
%==========================================================================
% We see that keeping beta constant, a 1% increase in productivity results
% in the equilibrium unemployment rate to decrease. However, as beta
% increases, the magnitude of this decrease in the unemployment rate gets
% smaller. This means the responsiveness of the unemployment rate with
% respect to productivity decreases as beta increases.
%==========================================================================
%==========================================================================

%==========================================================================
%% Part 3di: Consider a permanent change in p by 2%. Compute the wage,
% theta, job-finding rate, and the unemployment rate.

%==========================
% ONLY CONSIDERING INCREASE
%==========================

% Setting Shimer calibration values
r = 0.012;
sigma = 0.10;
theta = 1;
alpha = 0.72;
A = 1.35;
p = 1;
b = 0.4;
beta = alpha;
c = 0.324;

% Starting value of p is Shimer's calibration.
p = 1*1.02;

% Calculating equilibrium theta
syms f(theta);
f(theta) = (p - b)/(r + sigma + beta*A*(theta^(1 - alpha))) == c/((1 - beta)*A*(theta^(-alpha)));
theta_ss = double(vpasolve(f(theta), theta));
clear f;

% Calculating equilibrium job-finding rate
lambda_w = A*(theta_ss^(1 - alpha));

% Calculating equilibrium unemployment rate
u = sigma/(sigma + lambda_w);

% Calculating equilibrium wage
w = beta*(p + c*theta_ss) + (1 - beta)*b;

% Storing all into row vector. Note that these were calculated with beta =
% 0.72.
jfr_w_u_theta_beta_3di = [lambda_w w u theta_ss beta];

clear theta theta_ss lambda_w u w;
%==========================================================================

%==========================================================================
%% Part 3dii: Consider a permanent change in p by 2%. Redo this by varying
% b from 0.20 to 0.95.

%==========================
% ONLY CONSIDERING INCREASE
%==========================

% Setting Shimer calibration values
r = 0.012;
sigma = 0.10;
theta = 1;
alpha = 0.72;
A = 1.35;
p = 1;
b = 0.4;
beta = alpha;
c = 0.324;

% Starting value of p is Shimer's calibration.
p = 1*1.02;

% Creating a matrix that houses job-finding rate, wage, unemployment rate,
% theta, and corresponding beta.
jfr_w_u_theta_b_matrix_3dii = [zeros(length([0.20:0.05:0.95]), 5)];
% Creating counter for loop
counter = 1;
for b = [0.20:0.05:0.95]
  % Calculating equilibrium theta
  syms f(theta);
  f(theta) = (p - b)/(r + sigma + beta*A*(theta^(1 - alpha))) == c/((1 - beta)*A*(theta^(-alpha)));
  theta_ss = double(vpasolve(f(theta), theta));
  clear f;
  
  % Calculating equilibrium job-finding rate
  lambda_w = A*(theta_ss^(1 - alpha));

  % Calculating equilibrium unemployment rate
  u = sigma/(sigma + lambda_w);

  % Calculating equilibrium wage
  w = beta*(p + c*theta_ss) + (1 - beta)*b;
  
  % Storing into matrix as a row
  jfr_w_u_theta_b_matrix_3dii(counter, :) = [lambda_w w u theta_ss b];
  counter = counter + 1;
end
clear counter b theta theta_ss lambda_w u w;
%==========================================================================

%==========================================================================
%% Part 3diii: Consider a permanent change in p by 2%. Show how the
% responsiveness of the unemployment rate with respect to productivity
% changes by beta.

% What we are essentially doing is seeing how much u changes if p increases
% by 1% for example, for different values of beta.

%==========================
% ONLY CONSIDERING INCREASE
%==========================

% Setting Shimer calibration values
r = 0.012;
sigma = 0.10;
theta = 1;
alpha = 0.72;
A = 1.35;
p = 1;
b = 0.4;
beta = alpha;
c = 0.324;

% We choose our starting p value to be the initial permanent change of 2%.
% This means if our initial value was the Shimer calibration, starting p
% value is 1*1.02 = 1.02. Using a 1% change as the example, we will call
% p_after as follows:
p = 1*1.02;
p_after = p*1.01;

% Creating matrix that stores the per cent change of u from p to p_after,
% and corresponding beta.
upc_b_matrix_3diii = zeros(length([0.20:0.05:0.95]), 2);
% Creating counter for loop
counter = 1;
for b = [0.20:0.05:0.95]
  % Calculating equilibrium theta for both p and p_after
  syms f(theta);
  f(theta) = (p - b)/(r + sigma + beta*A*(theta^(1 - alpha))) == c/((1 - beta)*A*(theta^(-alpha)));
  theta_ss = double(vpasolve(f(theta), theta));
  clear f;
  syms f(theta_after);
  f(theta_after) = (p_after - b)/(r + sigma + beta*A*(theta_after^(1 - alpha))) == c/((1 - beta)*A*(theta_after^(-alpha)));
  theta_after_ss = double(vpasolve(f(theta_after), theta_after));
  clear f;

  % Calculating equilibrium job-finding rates for both p and p_after
  lambda_w = A*(theta_ss^(1 - alpha));
  lambda_w_after = A*(theta_after_ss^(1 - alpha));

  % Calculating equilibrium unemployment rate for both p and p_after
  u = sigma/(sigma + lambda_w);
  u_after = sigma/(sigma + lambda_w_after);

  % Calculating per cent change of u from p to p_after
  u_pc = (u_after - u)/u;

  upc_b_matrix_3diii(counter, :) = [u_pc b];
  counter = counter + 1;
end
clear counter b theta theta_ss theta_after theta_after_ss lambda_w lambda_w_after u u_after u_pc;

% Plotting per cent change in unemployment rate against b's used.
plot(upc_b_matrix_3diii(:, 2), upc_b_matrix_3diii(:, 1)*100, 'LineWidth', 1.25)

% Creating axes labels
xlabel('b');
ylabel('%');

% Creating title
title({'Responsiveness of unemployment rate', 'with respect to productivity changes in b,', '1% increase in p', 'b \in [0.20, 0.95]'});

saveas(gcf, 'path\to\graphics\3diii_plot.png');
close(gcf);
%==========================================================================
% We see that keeping b constant, a 1% increase in productivity results in
% the equilibrium unemployment rate to decrease. Furthermore, as b
% increases, the magnitude of this decrease in the unemployment rate gets
% bigger. This means the responsiveness of the unemployment rate with
% respect to productivity increases as b increases.
%==========================================================================
%==========================================================================