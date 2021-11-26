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
% ECO385K Problem Set 3, 1
% Paul Le Tran, plt377
% 24 November, 2021
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
%% Part 1a: Setting up and importing data
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
% calculation (seen in part 1b), we will set this scalar as such.
global N;
N = length(E_t) - 1;

clear avgduru E_lvl U_lvl Ul5w;
%==========================================================================

%==========================================================================
%% Part 1b: Calculate the unemployment outflow probability using the definition below:
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
for i = 1:N
  F_t(i) = 1 - (U_t(i + 1, 1) - U_l5w_t(i + 1, 1))/U_t(i, 1);
end
clear i;
F_t = F_t';

% Creating zero line
zeroline = zeros(length(dt(1:N, 1)),1);

% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(1:N, 1), F_t, 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(1:N, 1), zeroline, 'LineWidth', 1, 'Color', [0, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('Probability');
xtickangle(45);

% Creating title
title({'Unemployment outflow probability'});

saveas(gcf, 'path\to\graphics\1b_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 1c: Calculate f_t = -ln(1 - F_t), where f_t is the outflow rate.
f_t = -log(1 - F_t);
%==========================================================================

%==========================================================================
%% Part 1d: Plot the outflow rate.
% Creating zero line
zeroline = zeros(length(dt(1:N, 1)),1);

% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(1:N, 1), f_t, 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(1:N, 1), zeroline, 'LineWidth', 1, 'Color', [0, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating title
title({'Unemployment outflow rate'});

saveas(gcf, 'path\to\graphics\1d_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 1e: Calculate the unemployment inflow rate using the actual evolution of the unmployment over time, by solving for s_t directly.
% The evolution of unemployment is as follows:

% U_{t + 1} = (((1 - exp(-s_t - f_t))*s_t)/(s_t + f_t))*L_t + exp(-s_t - f_t)*U_t.
for i = 1:length(E_t(1:N, 1))
  syms f(x);
  f(x) = U_t(i + 1, 1) == (((1 - exp(-x - f_t(i, 1)))*x)/(x + f_t(i, 1)))*L_t(i, 1) + exp(-x - f_t(i, 1))*U_t(i, 1);
  soln = double(vpasolve(f(x), x));
  s_t(i, 1) = soln;
  clear f x;
end
s_t = s_t;

% Plotting the unemployment inflow rates calculated in parts 3e and 3f.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Creating zero line
zeroline = zeros(length(dt(1:N, 1)),1);

% Plotting series
plot(dt(1:N, 1), zeroline, 'LineWidth', 1, 'Color', [0, 0, 0]);
hold on
plot(dt(1:N, 1), s_t*100, 'LineWidth', 1.25, 'Color', [0, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Setting y-axis interval
set(gca, 'ylim', [0, 4]);
set(gca, 'ytick', 0:0.5:4);

% Creating title
title('Unemployment inflow rate');

saveas(gcf, 'path\to\graphics\1e_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 1f: Calculate the steady-state unemployment rate for the 2000-2020 period using u_{t}^{*} = s_t/(s_t + f_t).
u_t_SS = s_t./(s_t + f_t);

% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Creating zero line
zeroline = zeros(length(dt(1:N, 1)),1);

% Plotting series
plot(dt(1:N, 1), zeroline, 'LineWidth', 1, 'Color', [0, 0, 0]);
hold on
plot(dt(1:N, 1), u_t_SS(1:N, 1)*100, 'LineWidth', 1.25, 'Color', [0, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating title
title('Flow-steady-state (SS) Unemployment rate');

saveas(gcf, 'path\to\graphics\1f_plot.png');
close(gcf);
%==========================================================================