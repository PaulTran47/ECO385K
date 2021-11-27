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
% ECO385K Problem Set 3, 6
% Paul Le Tran, plt377
% 26 November, 2021
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
% Setting up, importing, and merging data
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
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
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
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
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
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
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
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
avgduru = readtable(append(data_dir, '\avg_dur_u.csv'), opts);
% Clear temporary variables
clear opts

%=========================================
% Importing JOLTS vacancies, total nonfarm
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTSJOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltsvactnf = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_tnf.csv'), opts);
% Clear temporary variables
clear opts

%=====================================
% Importing JOLTS hires, total nonfarm
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTSHIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshirestnf = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_tnf.csv'), opts);
% Clear temporary variables
clear opts

% Extracting variables as vectors
E_t = E_lvl{:, 2};
U_t = U_lvl{:, 2};
L_t = E_t + U_t;
U_l5w_t = Ul5w{:, 2};
avg_dur_u_t = avgduru{:, 2};
jolts_vac_tnf = joltsvactnf{:, 2};
jolts_hires_tnf = joltshirestnf{:, 2};

% Extracting date as a vector
dt = avgduru{:, 1};

% Creating scalar representing total number of months/length of vectors
global N;
N = length(E_t);

clear avgduru E_lvl U_lvl Ul5w joltsvactnf joltshirestnf;
%==========================================================================

%==========================================================================
%% Parts 6a and 6c: Calculate the counterfactual outflow rate f_{t}^{*} assuming \alpha = 0.5. Repeat with the \alpha values you estimated in question 3.
cd(home_dir);

%=====
% NOTE
%=====
% Though part 6a only asks for \alpha = 0.5, we will write code that will
% calculate for all of our \alpha estimates gotten in problem 3. This is
% for part 6c.

% Observe that the counterfactual outflow rate is essentially the outflow
% rate with no mismatch (i.e., M_{t}^{h} = 0). As a result, counterfactual
% outflow rate is simply \phi*(\frac{v_{t}}{u_{t}})^\alpha.
%=========
% END NOTE
%=========

% Initialising counter
counter = 1;
% Initialising matrix that stores \phi calculated for different values of
% \alpha.
Phi_t_alpha_matrix = zeros(N, 5);
% Initialising matrix that stores counterfactual outflow rates calculated
% for different values of \alpha
ft_star_alpha_matrix = zeros(N, 5);
% The \alpha values are as follows: 0.5 assumption, part 3ai, part 3aii,
% part 3bi, part 3bii.
for alpha = [0.5, 0.65504, 0.69307, 0.41297, 0.41212]
  disp(alpha);
  disp(counter);
  % Calculating \phi
  for i = 1:length(U_t)
    syms f(x)
    f(x) = jolts_hires_tnf(i, 1) == x*jolts_vac_tnf(i, 1)^(alpha)*U_t(i, 1)^(1 - alpha);
    soln = double(vpasolve(f(x), x));
    Phi_t(i, 1) = soln;
    clear f x;
  end
  clear i;
  Phi_t_alpha_matrix(:, counter) = Phi_t;
  clear Phi_t;
  
  % Calculating ft_star
  %=====
  % NOTE
  %=====
  % We are using Phi calculated with \alpha = 0.5. This is to keep things
  % consistant with how things were calculated in problems 3 and 5.
  %=========
  % END NOTE
  %=========
  ft_star_alpha_matrix(:, counter) = Phi_t_alpha_matrix(:, 1).*(jolts_vac_tnf.^alpha)./(U_t.^alpha);
  counter = counter + 1;
end
clear alpha counter;

% Plotting counterfactual outflow rate assuming \alpha = 0.5
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt, ft_star_alpha_matrix(:, 1), 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating title
title({'Counterfactual outflow rate', 'Note: Assuming \alpha = 0.5'});

saveas(gcf, 'path\to\graphics\6a_plot.png');
close(gcf);

%=======
% ANSWER
%=======
% With no mismatch and assuming \alpha = 0.5, we see that the
% counterfactual outflow rate has swings of much higher magnitude when
% compared to the actual outflow rate calculated in part 1b. It should be
% noted that the 2020 months seem to result in a counterfactual outflow
% rate of above 1, which doesn't make mathematical sense. This is possibly
% due to the usage of total nonfarm vacancies and hires as our measurements
% of aggregate vacancies and hires when calculating the outflow rate.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Parts 6b and 6c: Calculate the mismatch unemployment rate using the inflow and outflow rates you calculated in question 1.
% Calculating unemployment outflow probability
% F_t = 1 - (U_{t + 1} - U_{t + 1}^{< 5 weeks})/U_t
%=====
% NOTE
%=====
% Observe that the length of the outflow probability will be missing
% February 2020 due to the definition used for calculation.
%=========
% END NOTE
%=========
cd(home_dir);
for i = 1:N - 1
  F_t(i) = 1 - (U_t(i + 1, 1) - U_l5w_t(i + 1, 1))/U_t(i, 1);
end
clear i;
F_t = F_t';

% Calculating outflow rate
f_t = -log(1 - F_t);

% Calculating inflow rate
% U_{t + 1} = (((1 - exp(-s_t - f_t))*s_t)/(s_t + f_t))*L_t + exp(-s_t - f_t)*U_t.
for i = 1:N - 1
  syms f(x);
  f(x) = U_t(i + 1, 1) == (((1 - exp(-x - f_t(i, 1)))*x)/(x + f_t(i, 1)))*L_t(i, 1) + exp(-x - f_t(i, 1))*U_t(i, 1);
  soln = double(vpasolve(f(x), x));
  s_t(i, 1) = soln;
  clear f x;
end
clear i;
s_t = s_t;

% Calculating actual unemployment rate with mismatch using actual outflow
% and inflow rates. For simplicity, we will choose the starting value to be
% the December 2020 actual stock unemployment rate value.
u_t = zeros(N, 1);
u_t(1, 1) = U_t(1, 1)/L_t(1, 1);

% Iterating forward to calculate u_t (2001 - 2020)
for i = 1:N - 1
  u_t(i + 1, 1) = u_t(i, 1) + s_t(i, 1)*(1 - u_t(i, 1)) - f_t(i, 1)*u_t(i, 1);
end
clear i;
u_t([1], :) = [];

% Initialising matrix that will store counterfactual unemployment rate
% calculated using different values of \alpha
ut_star_alpha_matrix = zeros(N, 5);
for counter = 1:5
  disp(counter);
  % In order to calculate counterfactual unemployment rate, we need to
  % start with an initial value, u_{0}^{*}. For simplicity, we will choose
  % the starting value to be the December 2000 actual flow unemployment
  % rate value.
  ut_star_alpha_matrix(1, counter) = u_t(1, 1);

  % Iterating forward to calculate ut_star (2001 - 2020)
  for i = 1:N - 1
    ut_star_alpha_matrix(i + 1, counter) = ut_star_alpha_matrix(i, counter) + s_t(i, 1)*(1 - ut_star_alpha_matrix(i, counter)) - ft_star_alpha_matrix(i, counter)*ut_star_alpha_matrix(i, counter);
  end
  clear i;
end
clear counter;
ut_star_alpha_matrix([1], :) = [];

% Initialising matrix that will store mismatch unemployment rates
% calculated for different values of \alpha (2001 - 2020)
ut_mismatch_alpha_matrix = zeros(N - 1, 5);
for i = 1:5
  ut_mismatch_alpha_matrix(:, i) = u_t - ut_star_alpha_matrix(:, i);
end
clear i;

% Plotting mismatch unemployment rate assuming \alpha = 0.5
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(2:N, 1), ut_mismatch_alpha_matrix(:, 1), 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating title
title({'Mismatch unemployment rate', 'Note: Assuming \alpha = 0.5'});

saveas(gcf, 'path\to\graphics\6b_plot.png');
close(gcf);

%=======
% ANSWER
%=======
% An interesting characteristic we see from the mismatch unemployment rate
% (calculated with \alpha = 0.5) is that the rate decreased a decent amount
% between 2009 and 2010. However, between 2010 and 2011, the mismatch
% unemployment rate increased by more than 1%. After 2011, the series seems
% to have shifted upwards, and is still above pre-Great-recession rates at
% February 2020.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 6c: Repeat with the \alpha values you estimated in question 3. How is mismatch unemployment affected by your choice of \alpha?
% Plotting counterfactual outflow rate for each value of \alpha.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(1:N, 1), ft_star_alpha_matrix(:, 1), 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(1:N, 1), ft_star_alpha_matrix(:, 2), 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(1:N, 1), ft_star_alpha_matrix(:, 3), 'LineWidth', 1.25, 'Color', [1, 0, 0]);
hold on
plot(dt(1:N, 1), ft_star_alpha_matrix(:, 4), 'LineWidth', 1.25, 'Color', [0.25, 0, 0]);
hold on
plot(dt(1:N, 1), ft_star_alpha_matrix(:, 5), 'LineWidth', 1.25, 'Color', [0.5, 0, 0.5]);
hold on

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating legend
legend('\alpha = 0.5', '\alpha = 0.65504', '\alpha = 0.69307', '\alpha = 0.41297', '\alpha = 0.41212', 'Location', 'Southwest');

% Creating title
title({'Counterfactual outflow rate calculated with', 'different values of \alpha'});

saveas(gcf, 'path\to\graphics\6c_plot_ft_star.png');
close(gcf);

% Plotting mismatch unemployment rate for each value of \alpha.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(2:N, 1), ut_mismatch_alpha_matrix(:, 1), 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(2:N, 1), ut_mismatch_alpha_matrix(:, 2), 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(2:N, 1), ut_mismatch_alpha_matrix(:, 3), 'LineWidth', 1.25, 'Color', [1, 0, 0]);
hold on
plot(dt(2:N, 1), ut_mismatch_alpha_matrix(:, 4), 'LineWidth', 1.25, 'Color', [0.25, 0, 0]);
hold on
plot(dt(2:N, 1), ut_mismatch_alpha_matrix(:, 5), 'LineWidth', 1.25, 'Color', [0.5, 0, 0.5]);
hold on

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating legend
legend('\alpha = 0.5', '\alpha = 0.65504', '\alpha = 0.69307', '\alpha = 0.41297', '\alpha = 0.41212', 'Location', 'Southwest');

% Creating title
title({'Mismatch unemployment rate calculated', 'with different values of \alpha'});

saveas(gcf, 'path\to\graphics\6c_plot_ut_mismatch.png');
close(gcf);

%=======
% ANSWER
%=======
% When increasing (decreasing) \alpha, we observe that the aggregate
% counterfactual outflow rate decreases (increases). When increasing
% (decreasing) \alpha, we observe that the mismatch unemployment rate
% decreases (increases). There are two lines of thought to understand this
% relationship.

% If we think in terms of the counterfactual outflow rate, we see that
% increases (decreases) in \alpha result in the rate to decrease
% (increase). This causes the counterfactual unemployment rate to be higher
% (lower) through its dynamics equation. By not being as low (high), this
% causes the counterfactual unemployment rate to be closer (farther) to the
% actual rate. Thus, the mismatch unemployment rate decreases (increases).

% If we think in terms of the actual outflow rate and mismatch index,
% recall we found in problem 5 that increases (decreases) in \alpha result
% in the index to shift downward (upward). This in turn causes the actual
% job-finding rate to be closer (father) with the counterfactual
% job-finding rate. As a result, the mismatch unemployment rate will
% decrease (increase).
%===========
% END ANSWER
%===========
%==========================================================================