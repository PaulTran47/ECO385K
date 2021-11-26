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
% ECO385K Problem Set 3, 3
% Paul Le Tran, plt377
% 25 November, 2021
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
%% Setting up and importing data
cd(data_dir);

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

% Extracting date as a vector
dt = U_lvl{:, 1};

% Extracting variables as vectors
U_t = U_lvl{:, 2};
U_l5w_t = Ul5w{:, 2};
jolts_vac_tnf = joltsvactnf{:, 2};
jolts_hires_tnf = joltshirestnf{:, 2};

% Creating scalar representing total number of months/length of vectors
% Because the outflow probability is one month short by Shimer's
% calculation (seen in part 1b), we will set this scalar as such.
global N;
N = length(U_t) - 1;

clear U_lvl Ul5w joltsvactnf;
%==========================================================================

%==========================================================================
%% Part 3ai: Take logs and estimate \alpha using data for 2001-2008 period and report the regression. Using the vacancies and unemployment compute the predicted values for \frac{h_{t}}{u_{t}} for the 2009 - 2020 period. Compare with the actual series.
%============================================================
% Estimating aggregate matching function using 2001-2020 data
%============================================================
y = log(jolts_hires_tnf(2:97, 1)./U_t(2:97, 1));
regressor = log(jolts_vac_tnf(2:97, 1)./U_t(2:97, 1));

mdl_ai = fitlm(regressor, y);

%=======
% ANSWER
%=======
% Linear regression model:
%     y ~ 1 + x1
% 
% Estimated Coefficients:
%                    Estimate       SE       tStat       pValue  
%                    ________    ________    ______    __________
% 
%     (Intercept)    0.01542     0.015223    1.0129       0.31369
%     x1             0.65504     0.020966    31.243    1.9387e-51
% 
% 
% Number of observations: 96, Error degrees of freedom: 94
% Root Mean Squared Error: 0.0521
% R-squared: 0.912,  Adjusted R-Squared: 0.911
% F-statistic vs. constant model: 976, p-value = 1.94e-51

% Using 2001-2008 data, the estimate of \alpha, the vacancy share, is
% roughly 0.65504.
%===========
% END ANSWER
%===========

% Creating predicted values of \frac{h_{t}}{u_{t}} using the estimate for
% the coefficient and \alpha above.
htut_forecast_ai = exp(mdl_ai.Coefficients{1, 1} + mdl_ai.Coefficients{2, 1}.*log(jolts_vac_tnf(98:N, 1)./U_t(98:N, 1)));

% Creating actual job-finding rate
htut_actual = jolts_hires_tnf./U_t;

% Plotting series
plot(dt(98:N, 1), htut_forecast_ai, 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(98:N, 1), htut_actual(98:N, 1), 'LineWidth', 1.25, 'Color', [0, 0, 1]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating legend
legend('Predicted job-finding rate', 'Actual job-finding rate', 'Location', 'Northwest');

% Creating title
title({'Predicted v. actual job-finding rate', 'for 2009 - 2020 period'});

saveas(gcf, 'path\to\graphics\3ai_plot.png');
close(gcf);

clear left_color right_color htut_forecast_ai mdl_ai regressor y;
%=======
% ANSWER
%=======
% When comparing the predicted job-finding rate with the actual values
% throughout the 2009 - 2020 period, we see a relatively consistent-size
% gap between the two time series, with the actual job-finding rate
% consistently below the predicted values.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 3aii: Take logs and estimate \alpha using data for 2001-2020 period and report the regression. Show the fitted and actual \frac{h_{t}}{u_{t}}.
%============================================================
% Estimating aggregate matching function using 2001-2020 data
%============================================================
y = log(jolts_hires_tnf(2:N, 1)./U_t(2:N, 1));
regressor = log(jolts_vac_tnf(2:N, 1)./U_t(2:N, 1));

mdl_aii = fitlm(regressor, y);

%=======
% ANSWER
%=======
% Linear regression model:
%     y ~ 1 + x1
% 
% Estimated Coefficients:
%                    Estimate        SE       tStat       pValue   
%                    _________    ________    ______    ___________
% 
%     (Intercept)    -0.082811    0.012889    -6.425     7.6578e-10
%     x1               0.69307    0.014493     47.82    1.6443e-120
% 
% 
% Number of observations: 229, Error degrees of freedom: 227
% Root Mean Squared Error: 0.117
% R-squared: 0.91,  Adjusted R-Squared: 0.909
% F-statistic vs. constant model: 2.29e+03, p-value = 1.64e-120

% Using 2001-2020 data, the estimate of \alpha, the vacancy share, is
% roughly 0.69307.
%===========
% END ANSWER
%===========

% Creating fitted job-finding rate
htut_fitted_aii = exp(mdl_aii.Fitted);

% Plotting htut_fitted with actual \frac{h_{t}}{u_{t}} for 2001-2020 period.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(2:N, 1), htut_fitted_aii, 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(2:N, 1), htut_actual(2:N, 1), 'LineWidth', 1.25, 'Color', [0, 0, 1]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating legend
legend('Fitted job-finding rate', 'Actual job-finding rate', 'Location', 'Northwest');

% Creating title
title({'Fitted v. actual job-finding rate', 'for 2001 - 2020 period', 'Note: Regressand uses job-finding rate'});

saveas(gcf, 'path\to\graphics\3aii_plot.png');
close(gcf);

clear left_color right_color htut_fitted_aii mdl_aii regressor y;
%=======
% ANSWER
%=======
% When comparing fitted v. actual job-finding rates for the 2001 - 2020
% period, we first observe that the size of the gap between the two series
% is smaller in terms of absolute magnitude compared to the gap between the
% predicted v. actual job-finding rate done in part 3ai. Furthermore, we
% see that there actual exists no gap between 2008 and the beginning of
% 2010.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 3bi: Take logs and estimate \alpha using data for 2001-2008 period and report the regression. Using the vacancies and unemployment compute the predicted values for \frac{h_{t}}{u_{t}} for the 2009 - 2020 period. Compare with the actual series.
% Calculating job-finding rate (f_{t} = \frac{h_{t}}{u_{t}}
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
f_t = -log(1 - F_t);

clear F_t;
%============================================================
% Estimating aggregate matching function using 2001-2008 data
%============================================================
y = log(f_t(2:97, 1));
regressor = log(jolts_vac_tnf(2:97, 1)./U_t(2:97, 1));

mdl_bi = fitlm(regressor, y);

%=======
% ANSWER
%=======
% Estimated Coefficients:
%                    Estimate       SE        tStat       pValue  
%                    ________    ________    _______    __________
% 
%     (Intercept)    -0.57573    0.027033    -21.297    9.6551e-38
%     x1              0.41297    0.037233     11.092    9.0234e-19
% 
% 
% Number of observations: 96, Error degrees of freedom: 94
% Root Mean Squared Error: 0.0925
% R-squared: 0.567,  Adjusted R-Squared: 0.562
% F-statistic vs. constant model: 123, p-value = 9.02e-19

% Using 2001-2008 data, the estimate of \alpha, the vacancy share, is
% roughly 0.4130.
%===========
% END ANSWER
%===========

% Creating predicted values of \frac{h_{t}}{u_{t}} using the estimate for
% the coefficient and \alpha above.
htut_forecast_bi = exp(mdl_bi.Coefficients{1, 1} + mdl_bi.Coefficients{2, 1}.*log(jolts_vac_tnf(98:N, 1)./U_t(98:N, 1)));

% Plotting htut_forecast_bi with outflow rate for 2009-2020 period.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(98:N, 1), htut_forecast_bi, 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(98:N, 1), f_t(98:N, 1), 'LineWidth', 1.25, 'Color', [0, 0, 1]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating legend
legend('Predicted job-finding rate', 'Outflow rate', 'Location', 'Northwest');

% Creating title
title({'Predicted job-finding rate with outflow rate', 'for 2009 - 2020 period'});

saveas(gcf, 'path\to\graphics\3bi_plot_f_t.png');
close(gcf);

clear left_color right_color;

% Plotting htut_forecast_bi with actual \frac{h_{t}}{u_{t}} for 2009-2020 period.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(98:N, 1), htut_forecast_bi, 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(98:N, 1), htut_actual(98:N, 1), 'LineWidth', 1.25, 'Color', [0, 0, 1]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating legend
legend('Predicted job-finding rate', 'Actual job-finding rate', 'Location', 'Northwest');

% Creating title
title({'Predicted v. actual job-finding rate', 'for 2009 - 2020 period'});

saveas(gcf, 'path\to\graphics\3bi_plot_htut_actual.png');
close(gcf);

clear left_color right_color htut_forecast_bi mdl_bi regressor y;

%=======
% ANSWER
%=======
% When plotting predicted job-finding rate against the outflow rate, we see
% that the gap between the two grow over time, with the outflow rate
% consistently being below the predicted job-finding rate values.

% When plotting predicted job-finding rate against the actual rate, the gap
% between the two series dramatically increases as time passes.
% Furthermore, the predicted job-finding rate is consistently below the
% actual rate. However, it's notable that no such gap existed between the
% 2009 - 2013 period.

% In both cases, we see that a simple OLS regression with a constant
% between ln(\frac{h_{t}}{u_{t}}) and ln(\frac{v_{t}}{u_{t}}) does not
% capture the true relationship between vacancies and unemployment level
% and hires. This is of course obvious, because a simple OLS regression
% doesn't capture the matching efficiency paramater, which seems to be
% a time-varying scaling parameter.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 3bii: Take logs and estimate \alpha using data for 2001-2020 period and report the regression. Show the fitted and actual \frac{h_{t}}{u_{t}}.
%============================================================
% Estimating aggregate matching function using 2001-2020 data
%============================================================
y = log(f_t(2:N, 1));
regressor = log(jolts_vac_tnf(2:N, 1)./U_t(2:N, 1));

mdl_bii = fitlm(regressor, y);

%=======
% ANSWER
%=======
% Linear regression model:
%     y ~ 1 + x1
% 
% Estimated Coefficients:
%                    Estimate       SE        tStat       pValue   
%                    ________    ________    _______    ___________
% 
%     (Intercept)    -0.75291    0.019499    -38.613    9.7467e-102
%     x1              0.41212    0.021926     18.796     3.6782e-48
% 
% 
% Number of observations: 229, Error degrees of freedom: 227
% Root Mean Squared Error: 0.177
% R-squared: 0.609,  Adjusted R-Squared: 0.607
% F-statistic vs. constant model: 353, p-value = 3.68e-48

% Using 2001-2020 data, the estimate of \alpha, the vacancy share, is
% roughly 0.41212.
%===========
% END ANSWER
%===========

% Creating fitted job-finding rate
htut_fitted_bii = exp(mdl_bii.Fitted);

% Plotting htut_fitted with actual \frac{h_{t}}{u_{t}} for 2001-2020 period.
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(2:N, 1), htut_fitted_bii, 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(2:N, 1), htut_actual(2:N, 1), 'LineWidth', 1.25, 'Color', [0, 0, 1]);

% Creating axes labels
xlabel('Year');
ylabel('%');
xtickangle(45);

% Creating legend
legend('Fitted job-finding rate', 'Actual job-finding rate', 'Location', 'Northwest');

% Creating title
title({'Fitted v. actual job-finding rate', 'for 2001 - 2020 period', 'Note: Regressand uses outflow rate'});

saveas(gcf, 'path\to\graphics\3bii_plot.png');
close(gcf);

clear left_color right_color htut_fitted_bii mdl_bii htut_actual regressor y;

%=======
% ANSWER
%=======
% When comparing fitted v. actual job-finding rates for the 2001 - 2020
% period, we immediately see that the gap between the two varies
% significantly throughout the time period, with the fitted values
% consistently below the actual values. Specifically, the gap is quite
% substantial for the 2001 - 2009 and 2014 - 2020 sub-periods.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 3c: Now assume that \alpha = 0.5 and assume that \Phi varies over time. Use the actual value of hires, vacancies, and unemployment and compute the value of \Phi_{t} that satisfies the matching function with equality. What happened to \Phi_{t} over time?
% h_{t} = \Phi_{t}*v_{t}^{\alpha}*u_{t}^{1 - \alpha}
for i = 1:length(U_t)
  syms f(x)
  f(x) = jolts_hires_tnf(i, 1) == x*jolts_vac_tnf(i, 1)^(0.5)*U_t(i, 1)^(0.5);
  soln = double(vpasolve(f(x), x));
  Phi_t(i, 1) = soln;
  clear f x;
end
clear i;

% Plotting \Phi
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt, Phi_t, 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on

% Creating axes labels
xlabel('Year');
ylabel('Value');
xtickangle(45);

% Creating title
title({'Estimate of matching efficiency parameter \Phi_{t}', 'Note: Assumed \alpha = 0.5'});

saveas(gcf, 'path\to\graphics\3c_plot.png');
close(gcf);

%=======
% ANSWER
%=======
% If we assume \alpha = 0.5, matching efficiency parameter \Phi varies over
% time, and the given form of aggregate matching function, we see that \Phi
% fluctuates around 0.95 until the Great recession, where it dramatically
% decreases to the minimum value of 0.5975. Matching efficiency stays
% around this value until around 2014, where it slowly increases back to
% almost 0.95 in February 2020.
%===========
% END ANSWER
%===========