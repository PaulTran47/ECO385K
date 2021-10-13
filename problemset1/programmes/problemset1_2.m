%==========================================================================
%% 2 percentage signs represent sections of code;
% 1 percentage sign represents comments for code or commented out code;

% ECO385K Problem Set 1, 2
% Paul Le Tran, plt377
% 11 October, 2021
%==========================================================================

%==========================================================================
%% Problem info
% Figure, table, and model references can be found in the paper "Why did
% the average duration of unemployment become so much longer?" by Toshihiko
% Mukoyama and Aysegul Sahin. As of the present time, the pape can be found
% at: https://www.dropbox.com/s/r3jrbjolhlgw8vc/duration.pdf?dl=0
%==========================================================================

%==========================================================================
%% Setting up workspace
clear all;
close all;
clc;

home_dir = 'path\to\programmes';
data_dir = 'path\to\data';

cd(home_dir);
%==========================================================================

%==========================================================================
%% Setting up and importing data
cd(data_dir);

%=================================================
% Importing average unemployment duration as table
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "AVG_DUR_U"];
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
%=================================================

%=====================================
% Importing unemployment rate as table
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "UNRATE"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
urate = readtable(append(data_dir, '\u_rate.csv'), opts);
% Clear temporary variables
clear opts
%=====================================

% Extracting avg_dur_u and u_rate as vectors
avg_dur_u = avgduru{:, 2};
u_rate = urate{:, 2};

% Extracting date as a vector (commonly shared between avg_dur_u and
% u_rate)
dt = avgduru{:, 1};

clear avgduru urate;
%==========================================================================

%==========================================================================
%% Part 2a: Plot the unemployment rate and the average duration of
% unemployment (update Figure 1)
cd(home_dir);

% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
yyaxis left
plot(dt, u_rate, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
yyaxis right
plot(dt, avg_dur_u, 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
yyaxis left
xlabel('Year');
ylabel('%');
yyaxis right
ylabel('Weeks')
xtickangle(45);

% Creating legend
legend('Unemployment Rate (Left)', 'Average Duration (Right)', 'Location', 'Northwest');

% Creating title
title('Unemployment rate and average duration of unemployment');

saveas(gcf, 'path\to\graphics\2a_plot.png');
close(gcf);

clear left_color right_color;
%==========================================================================

%==========================================================================
%% Part 2b: HP filter both series
% We will be using smoothing parameter of 6.25 (for annual data) as done in
% the paper. This translates to a parameter of 129,600 for monthly data.

% Applying HP filter on u_rate to extract trend and cycle.
[u_rate_trend, u_rate_cycle] = hpfilter(u_rate, 129600);

% Applying HP filter on avg_dur_u to extract trend and cycle.
[avg_dur_u_trend, avg_dur_u_cycle] = hpfilter(avg_dur_u, 129600);
%==========================================================================

%==========================================================================
%% Part 2c: Plot the trend components of both series (update Figure 2)
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
yyaxis left
plot(dt, u_rate_trend, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
yyaxis right
plot(dt, avg_dur_u_trend, 'LineWidth', 1.25, 'Color', [1, 0, 0]);

% Creating axes labels
yyaxis left
xlabel('Year');
ylabel('%');
yyaxis right
ylabel('Weeks')
xtickangle(45);

% Creating legend
legend('Unemployment Rate (Left)', 'Average Duration (Right)', 'Location', 'Southeast');

% Creating title
title({'Trend components of unemployment rate', 'and average duration of unemployment'});

saveas(gcf, 'path\to\graphics\2c_plot.png');
close(gcf);

clear left_color right_color;
%==========================================================================

%==========================================================================
%% Part 2d: Plot the cyclical components of both series (update Figure 9)
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
yyaxis left
plot(dt, u_rate_cycle, 'LineWidth', 1.25, 'Color', [0, 0, 1]);
% Setting u_rate_cycle axis interval
set(gca, 'ylim', [-12, 12]);
set(gca, 'ytick', -12:3:12);
yyaxis right
plot(dt, avg_dur_u_cycle, 'LineWidth', 1.25, 'Color', [1, 0, 0]);
% Setting avg_dur_u_cycle axis interval
set(gca, 'ylim', [-20, 20]);
set(gca, 'ytick', -20:5:20);

% Creating axes labels
yyaxis left
xlabel('Year');
ylabel('%');
yyaxis right
ylabel('Weeks')
xtickangle(45);

% Creating legend
legend('Unemployment Rate (Left)', 'Average Duration (Right)', 'Location', 'Southwest');

% Creating title
title({'Cyclical components of unemployment rate', 'and average duration of unemployment'});

saveas(gcf, 'path\to\graphics\2d_plot.png');
close(gcf);

clear left_color right_color;
%==========================================================================

%==========================================================================
%% Part 2e: Tabulate the average duration of unemployment for men and women
% by age in 1970, 2003, and 2019 (update Table 1)
% The following 2019 annual average values are found in BLS CPS Table 31:
% https://www.bls.gov/cps/aa2019/cpsaat31.htm
% The following vectors of avg_dur_u by sex has components for the
% following age groups:
%[16-19; 20-24; 25-34; 35-44; 45-54; 55-64; 65+]

% Creating vector for men and women 2019 annual avg_dur_u
avg_dur_u_m = [12.7; 20.2; 23.0; 22.6; 26.5; 28.0; 29.3];
avg_dur_u_f = [11.3; 14.4; 20.7; 22.8; 25.8; 25.8; 24.4];
%==========================================================================

%==========================================================================
%% Part 2f: Apply demographic adjustment in Equation 4 and plot the actual
% and adjusted series.
%==========================================================================
% WE ARE CHOOSING TO UPDATE EXPERIMENT C.1 IN THE PAPER, WHICH IS EXAMINING
% THE DEMOGRAPHIC CHANGE IN UNEMPLOYMENT DURATION. THIS MEANS HOLDING
% AVG_DUR_U FOR SEX AND AGE GROUP CONSTANT, AND CHANGING FRACTION OF
% UNEMPLOYED WORKERS WHO ARE IN A PARTICULAR SEX- AND AGE-GROUP.
% Setting up data exclusive to 2f
%==========================================================================
cd(data_dir);

%==================================================
% Importing unemployment level by men and age group
opts = delimitedTextImportOptions("NumVariables", 8);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["Var1", "m", "m1", "m2", "m3", "m4", "m5", "plusm"];
opts.SelectedVariableNames = ["m", "m1", "m2", "m3", "m4", "m5", "plusm"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");
% Import the data
um = readtable(append(data_dir, '\u_m.csv'), opts);
% Clear temporary variables
clear opts
%==================================================

%====================================================
% Importing unemployment level by women and age group
opts = delimitedTextImportOptions("NumVariables", 8);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["Var1", "f", "f1", "f2", "f3", "f4", "f5", "plusf"];
opts.SelectedVariableNames = ["f", "f1", "f2", "f3", "f4", "f5", "plusf"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");
% Import the data
uf = readtable(append(data_dir, '\u_f.csv'), opts);
% Clear temporary variables
clear opts
%====================================================

%===================================
% Importing total unemployment level
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["Var1", "UNEMPLOY"];
opts.SelectedVariableNames = "UNEMPLOY";
opts.VariableTypes = ["string", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");
% Import the data
utable = readtable(append(data_dir, '\u.csv'), opts);
% Clear temporary variables
clear opts
%===================================

% Extracting total unemployment level as a vector
u_lvl = utable{:, 1};

% Extracting unemployment levels for each sex and age group as vectors.
% Putting vectors into matrices by sex.
u_m1 = um{:, 1};
u_m2 = um{:, 2};
u_m3 = um{:, 3};
u_m4 = um{:, 4};
u_m5 = um{:, 5};
u_m6 = um{:, 6};
u_m7 = um{:, 7};
u_m = [u_m1 u_m2 u_m3 u_m4 u_m5 u_m6 u_m7];

u_f1 = uf{:, 1};
u_f2 = uf{:, 2};
u_f3 = uf{:, 3};
u_f4 = uf{:, 4};
u_f5 = uf{:, 5};
u_f6 = uf{:, 6};
u_f7 = uf{:, 7};
u_f = [u_f1 u_f2 u_f3 u_f4 u_f5 u_f6 u_f7];

clear u uf um;
clear u_m1 u_m2 u_m3 u_m4 u_m5 u_m6 u_m7 u_f1 u_f2 u_f3 u_f4 u_f5 u_f6 u_f7

% Multiplying everything by 1000 to make it in proper level scaling.
u_lvl = u_lvl*1000;
u_m = u_m*1000;
u_f = u_f*1000;

% Converting matrices of unemployment levels to fractions of unemployed
% workers who are a particular sex and age group.
f_m = zeros(length(u_lvl), 7);
f_f = zeros(length(u_lvl), 7);
for i = 1:7
  f_m(:, i) = u_m(:, i)./u_lvl;
  f_f(:, i) = u_f(:, i)./u_lvl;
end
clear i

% Multiplying 2019 annual avg_dur_u of each sex and age group with
% respective fraction vector created above.
fd_m = zeros(length(u_lvl), 7);
fd_f = zeros(length(u_lvl), 7);
for  j = 1:7
  fd_m(:, j) = f_m(:, j)*avg_dur_u_m(j, 1);
  fd_f(:, j) = f_f(:, j)*avg_dur_u_f(j, 1);
end
clear j

% Combining fd_m and fd_f
fd = [fd_m fd_f];

% Creating average duration of unemployment vector when focusing on
% demographic change, avg_dur_u_d
avg_dur_u_d = sum(fd, 2);

%% Plotting avg_dur_u_d (adjusted series) and avg_dur_u (actual series)
% together
plot(dt, avg_dur_u, 'LineWidth', 1.25, 'Color', [0,0,1]);
hold on
plot(dt, avg_dur_u_d, 'LineWidth', 1.25, 'Color', [1,0,0]);
hold off
grid on
xlabel('Year');
ylabel('Weeks');
hold on

% Creating legend
legend('Average duration (Blue)', 'Adjusted average duration (Red)', 'Location', 'Northwest');

% Creating title
title({'Average duration of unemployment', 'and adjusted average duration of unemployment', 'base year = 2019'});

saveas(gcf, 'path\to\graphics\2fi_plot.png');
close(gcf);

%% Following the paper to see the effect of the adjustment more clearly, we
% will subtract avg_dur_u_d from avg_dur_u_trend.
plot(dt, avg_dur_u_trend, 'LineWidth', 1.25, 'Color', [0,0,1]);
hold on
plot(dt, avg_dur_u_trend - avg_dur_u_d, 'LineWidth', 1.25, 'Color', [1,0,0]);
hold off
grid on
xlabel('Year');
ylabel('Weeks');
hold on

% Creating legend
legend('Trend of average duration (Blue)', 'Trend of average duration net adjustment (Red)', 'Location', 'Northwest');

% Creating title
title({'Deviation of actual average duration of unemployment (HP trend)', 'from adjusted average duration of unemployment,', 'base year = 2019'});

saveas(gcf, 'path\to\graphics\2fii_plot.png');
close(gcf);
%==========================================================================