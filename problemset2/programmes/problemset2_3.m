%==========================================================================
%% 2 percentage signs represent sections of code;
% 1 percentage sign represents comments for code or commented out code;

% Answers to question parts that don't involve code can be found at the
% bottom of the programme, in the section ``Questions asked in problemset x
% that don't involve code".

% Text answers to question parts that involve code will be between the
% sub-section label:
%=======
% ANSWER
%=======
% Answer here
%===========
% END ANSWER
%===========

% Comments that are important will be between the sub-section label:
%=====
% NOTE
%=====
% Important note here
%=========
% END NOTE
%=========
% ECO385K Problem Set 2, 3
% Paul Le Tran, plt377
% 04 November, 2021
%==========================================================================

%==========================================================================
%% Setting up workspace
clear all;
close all;
clc;

home_dir = 'path\to\programmes';
data_dir= 'path\to\data';

cd(home_dir);
%==========================================================================

%==========================================================================
%% Part 3a: Setting up and importing data
cd(data_dir);

%======================================
% Importing employment level as a table
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "CE16OV"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
E_lvl = readtable(append(data_dir, '\E.csv'), opts);
% Clear temporary variables
clear opts

%========================================
% Importing unemployment level as a table
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "UNEMPLOY"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
U_lvl = readtable(append(data_dir, '\U.csv'), opts);
% Clear temporary variables
clear opts

%=============================================================
% Importing number unemployed for less than 5 weeks as a table
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "UEMPLT5"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
Ul5w = readtable(append(data_dir, '\U_l5w.csv'), opts);
% Clear temporary variables
clear opts

%=================================================
% Importing average unemployment duration as table
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "UEMPMEAN"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
avgduru = readtable(append(data_dir, '\avg_dur_u.csv'), opts);
% Clear temporary variables
clear opts

% Extracting variables as vectors
E_t = E_lvl{:, 2};
U_t = U_lvl{:, 2};
L_t = E_t + U_t;
U_l5w_t = Ul5w{:, 2};
avg_dur_u_t = avgduru{:, 2};

% Extracting date as a vector
dt = avgduru{:, 1};

% Creating scalar representing total number of months/length of vectors
% Because the outflow probability is one month short by Shimer's
% calculation (seen in part 3b), we will set this scalar as such.
global N;
N = length(E_t) - 1;

clear avgduru E_lvl U_lvl Ul5w;
%==========================================================================

%==========================================================================
%% Part 3b: Calculate the unemployment outflow probability using the definition below:
% F_t = 1 - (U_{t + 1} - U_{t + 1}^{< 5 weeks})/U_t
%=====
% NOTE
%=====
% Observe that the length of the outflow probability will be missing
% September 2020 due to the definition used for calculation.
%=========
% END NOTE
%=========
cd(home_dir);
for i = 1:length(E_t)-1
  F_t(i) = 1 - (U_t(i + 1, 1) - U_l5w_t(i + 1, 1))/U_t(i, 1);
end
clear i;
F_t = F_t';
%=====
% NOTE
%=====
% Observe that the unemployment outflow probability is negative for March
% 2020. This makes no mathematical sense due to F_t \in [0, 1]. Though this
% doesn't affect our calculations in the sense that things break, it does
% affect the intuitiveness of our results for this month.
%=========
% END NOTE
%=========
%==========================================================================

%==========================================================================
%% Part 3c: Calculate f_t = -ln(1 - F_t), where f_t is the outflow rate.
f_t = -log(1 - F_t);
%=====
% NOTE
%=====
% Observe that the unemployment outflow rate is negative for March 2020.
% This makes no mathematical sense due to F_t \in [0, 1]. Though this
% doesn't affect our calculations in the sense that things break, it does
% affect the intuitiveness of our results for this month.
%=========
% END NOTE
%=========
%==========================================================================

%==========================================================================
%% Part 3d: Plot the unemployment outflow rate and the average duration of unemployment together for the 1996 - 2020 period.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
yyaxis left
plot(dt(1:N, 1), f_t*100, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
yyaxis right
plot(dt(1:N, 1), avg_dur_u_t(1:N, 1), 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
yyaxis left
xlabel('Year');
ylabel('%');
yyaxis right
ylabel('Weeks')
xtickangle(45);

% Creating legend
legend('Unemployment outflow rate (Left)', 'Average Duration (Right)', 'Location', 'Northwest');

% Creating title
title({'Unemployment outflow rate and', 'average duration of unemployment'});

saveas(gcf, 'path\to\graphics\3d_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 3e: Calculate the unemployment inflow rate using s_t = U_{t + 1}^{< 5 weeks}/(E_t*(1 - (f_t/2))). Plot the time series for s_t for the 1996 - 2020 period.
for i = 1:length(E_t)-1
  s_t(i) = U_l5w_t(i + 1, 1)/(E_t(i, 1)*(1 - (f_t(i, 1)/2)));
end
clear i;
s_t = s_t';

plot(dt(1:N, 1), s_t*100, 'LineWidth', 1.25, 'Color', [0,0,0]);
grid on
xlabel('Year');
ylabel('%');
hold on

% Creating title
title('Unemployment inflow rate');

saveas(gcf, 'path\to\graphics\3e_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 3f: Calculate the unemployment inflow rate using the actual evolution of the unmployment over time, by solving for s_t directly.
% The evolution of unemployment is as follows:

% U_{t + 1} = (((1 - exp(-s_t - f_t))*s_t)/(s_t + f_t))*L_t + exp(-s_t - f_t)*U_t.
for i = 1:length(E_t(1:N, 1))
  syms f(x);
  f(x) = U_t(i + 1, 1) == (((1 - exp(-x - f_t(i, 1)))*x)/(x + f_t(i, 1)))*L_t(i, 1) + exp(-x - f_t(i, 1))*U_t(i, 1);
  soln = double(vpasolve(f(x), x));
  s_t_direct(i, 1) = soln;
  clear f x;
end
s_t_direct = s_t_direct;

% Plotting the unemployment inflow rates calculated in parts 3e and 3f.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
yyaxis left
plot(dt(1:N, 1), s_t*100, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
yyaxis right
plot(dt(1:N, 1), s_t_direct*100, 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
yyaxis left
xlabel('Year');
ylabel('%');
yyaxis right
ylabel('%')
xtickangle(45);

% Creating legend
legend('Simple unemployment inflow rate (Blue)', 'Direct unemployment inflow rate (Red)', 'Location', 'Northwest');

% Creating title
title('Unemployment inflow rate derived with different methods');

saveas(gcf, 'path\to\graphics\3f_plot.png');
close(gcf);
%=======
% ANSWER
%=======
% We see that the simple calculation for the unemployment inflow rate and
% the calculation using the evolution of unemployment itself are very
% similar in terms of both magnitude and curvature.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 3g: Calculate the steady-state unemployment rate for the 2000-2020 period using u_{t}^{*} = s_t/(s_t + f_t).
u_t_SS = s_t./(s_t + f_t);
u_t_direct_SS = s_t_direct./(s_t_direct + f_t);

% Plotting SS unemployment rates derived with unemployment inflow rates
% from parts 3e and 3f.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(49:N, 1), u_t_SS(49:N, 1)*100, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(49:N, 1), u_t_direct_SS(49:N, 1)*100, 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating legend
legend('Simple SS unemployment rate (Blue)', 'Direct SS unemployment rate (Red)', 'Location', 'Southwest');

% Creating title
title('Flow-steady-state (SS) Unemployment rate derived with different methods');

saveas(gcf, 'path\to\graphics\3g_plot1.png');
close(gcf);

%=====
% NOTE
%=====
% Observe that both derivations of the flow-SS unemployment rate result in
% March 2020 to have a negative value, which does not make sense. However,
% recall that the stock definition of unemployment rate, U_t/L_t is closely
% approximated to the flow-SS value. It is for this close relationship that
% I make the call to replace the March 2020 flow-SS value with the
% approximated stock value.
%=========
% END NOTE
%=========
u_t_stock = U_t./L_t;
u_t_SS(291, 1) = u_t_stock(291, 1);
u_t_direct_SS(291, 1) = u_t_stock(291, 1);


% Plotting SS unemployment rates derived with unemployment inflow rates
% from parts 3e and 3f, and from using the stock-derived value for March
% 2020.
% Changing axes colours
left_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(49:N, 1), u_t_SS(49:N, 1)*100, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(49:N, 1), u_t_direct_SS(49:N, 1)*100, 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Setting y-axis interval
set(gca, 'ylim', [3, 15]);
set(gca, 'ytick', 3:1:15);

% Creating legend
legend('Simple flow-SS unemployment rate (Blue)', 'Direct flow-SS unemployment rate (Red)', 'Location', 'Northwest');

% Creating title
title({'Flow-steady-state (SS) unemployment rate', 'derived with different methods.', 'Note: The March 2020 value is replaced with the', 'corresponding value from the stock unemployment rate'});

saveas(gcf, 'path\to\graphics\3g_plot2.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 3h: Now assume that s_t is fixed at its mean value for the sample and f_t varies over time. Calculate the counterfactual unemployment rate for the 1996 - 2020 period.
% Calculating mean value of s_t and s_t_direct
avg_s_t = mean(s_t);
avg_s_t_direct = mean(s_t_direct);

% Calculating unemployment rates
u_t_avg_s_t_SS = avg_s_t./(avg_s_t + f_t);
u_t_avg_s_t_direct_SS = avg_s_t_direct./(avg_s_t_direct + f_t);

%=====
% NOTE
%=====
% Observe that both derivations of the flow-SS unemployment rate result in
% March 2020 to have a negative value, which does not make sense. However,
% recall that the stock definition of unemployment rate, U_t/L_t is closely
% approximated to the flow-SS value. It is for this close relationship that
% I make the call to replace the March 2020 flow-SS value with the
% approximated stock value.
%=========
% END NOTE
%=========
u_t_avg_s_t_SS(291, 1) = u_t_stock(291, 1);
u_t_avg_s_t_direct_SS(291, 1) = u_t_stock(291, 1);

% Plotting SS unemployment rates derived with mean of unemployment inflow
% rates from parts 3e and 3f, and from using the stock-derived value for
% March 2020.
% Changing axes colours
left_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(49:N, 1), u_t_avg_s_t_SS(49:N, 1)*100, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(49:N, 1), u_t_avg_s_t_direct_SS(49:N, 1)*100, 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Setting y-axis interval
set(gca, 'ylim', [3, 15]);
set(gca, 'ytick', 3:1:15);

% Creating legend
legend('Simple flow-SS unemployment rate (Blue)', 'Direct flow-SS unemployment rate (Red)', 'Location', 'Northwest');

% Creating title
title({'Flow-steady-state (SS) unemployment rate', 'derived with different methods.', 'Note 1: The March 2020 value is replaced with the', 'corresponding value from the stock unemployment rate', 'Note 2: Using the sample average for both inflow rate measures.'});

saveas(gcf, 'path\to\graphics\3h_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 3i: Part 3h: Now assume that f_t is fixed at its mean value for the sample and s_t varies over time. Calculate the counterfactual unemployment rate for the 1996 - 2020 period.
% Calculating mean value of f_t
avg_f_t = mean(f_t);

% Calculating unemployment rates
u_t_avg_f_t_SS = s_t./(s_t + avg_f_t);
u_t_avg_f_t_direct_SS = s_t_direct./(s_t_direct + avg_f_t);

%=====
% NOTE
%=====
% Observe that both derivations of the flow-SS unemployment rate result in
% March 2020 to have a negative value, which does not make sense. However,
% recall that the stock definition of unemployment rate, U_t/L_t is closely
% approximated to the flow-SS value. It is for this close relationship that
% I make the call to replace the March 2020 flow-SS value with the
% approximated stock value.
%=========
% END NOTE
%=========
u_t_avg_f_t_SS(291, 1) = u_t_stock(291, 1);
u_t_avg_f_t_direct_SS(291, 1) = u_t_stock(291, 1);

% Plotting SS unemployment rates derived with mean of unemployment outflow
% rate from part 3c, from unemployment inflow rates from parts 3e and 3f,
% and from using the stock-derived value for March 2020.
% Changing axes colours
left_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(49:N, 1), u_t_avg_f_t_SS(49:N, 1)*100, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(49:N, 1), u_t_avg_f_t_direct_SS(49:N, 1)*100, 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Setting y-axis interval
set(gca, 'ylim', [3, 15]);
set(gca, 'ytick', 3:1:15);

% Creating legend
legend('Simple flow-SS unemployment rate (Blue)', 'Direct flow-SS unemployment rate (Red)', 'Location', 'Northwest');

% Creating title
title({'Flow-steady-state (SS) unemployment rate', 'derived with different methods.', 'Note 1: The March 2020 value is replaced with the', 'corresponding value from the stock unemployment rate', 'Note 2: Using the sample average for outflow rate measure.'});

saveas(gcf, 'path\to\graphics\3i_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 3j: Which margin is more important for unemployment rate fluctuations?
%=======
% ANSWER
%=======
% When comparing the charts produced in parts 3h and 3i, we see that much
% of the observed cyclicality of the unemployment rate is closely matched
% with the countercyclical unemployment rate calculated with varying
% outflow rate and mean inflow rate. As a result, the unemployment outflow
% rate seems to be more important in determining unemployment rate
% fluctuations.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 3k: Apply the decomposition in Elsby, Hobijn, and Sahin (2010) to the COVID-19 recession.
% The decomposition here is equation (6) in the mentioned paper:

% \Delta u_t \approx \beta_{t - 1}*(\Delta ln(s_t) - \Delta ln(f_t)),

% where \beta_{t - 1} = u_{t - 1}(1 - u_{t - 1})

% Calculating \beta_{t - 1} and the difference in the natural logs of s_t,
% s_t_direct, and f_t
%=====
% NOTE
%=====
% Because there is a negative value for f_t in March 2020, we will force it
% to be a value of 0.0001 for computation's sake.
%=========
% END NOTE
%=========
beta = u_t_SS.*(1 - u_t_SS);
ln_s_t = log(s_t);
ln_s_t_direct = log(s_t_direct);
ln_f_t = log(max(f_t, 0.0001));
ln_s_t_diff = diff(ln_s_t);
ln_s_t_direct_diff = diff(ln_s_t_direct);
ln_f_t_diff = diff(ln_f_t);

% Multiplying \beta_{t - 1} with the log-differences_t
for i = 2:N-1
  rhs_s_t(i, 1) = beta(i - 1, 1)*ln_s_t_diff(i, 1);
  rhs_s_t_direct(i, 1) = beta(i - 1, 1)*ln_s_t_direct_diff(i, 1);
  rhs_f_t(i, 1) = beta(i - 1, 1)*ln_f_t_diff(i, 1);
end

% Plotting rhs_s_t and rhs_f_t for January 2020 - July 2020.
% Changing axes colours
left_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(289:length(rhs_f_t), 1), rhs_s_t(289:length(rhs_f_t), 1)*100, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(289:length(rhs_f_t), 1), rhs_f_t(289:length(rhs_f_t), 1)*100, 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
xlabel('Month');
ylabel('Log points');
xtickangle(45);

% Creating legend
legend('\beta_{t - 1}\Deltaln(s_t) (Left)', '\beta_{t - 1}\Deltaln(f_t) (Right)', 'Location', 'Northeast');

% Creating title
title({'Log change in unemployment inflow and outflow rates', 'the COVID-19 recession', 'Note: Using the simple-derived inflow rate measure'});

saveas(gcf, 'path\to\graphics\3k_plot1.png');
close(gcf);

% Plotting rhs_s_t_direct and rhs_f_t for January 2020 - July 2020.
% Changing axes colours
left_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(289:length(rhs_f_t), 1), rhs_s_t_direct(289:length(rhs_f_t), 1)*100, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(289:length(rhs_f_t), 1), rhs_f_t(289:length(rhs_f_t), 1)*100, 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
xlabel('Month');
ylabel('Log points');
xtickangle(45);

% Creating legend
legend('\beta_{t - 1}\Deltaln(s_t) (Left)', '\beta_{t - 1}\Deltaln(f_t) (Right)', 'Location', 'Northeast');

% Creating title
title({'Log change in unemployment inflow and outflow rates during', 'the COVID-19 recession', 'Note: Using the direct-derived inflow rate measure'});

saveas(gcf, 'path\to\graphics\3k_plot2.png');
close(gcf);
%==========================================================================