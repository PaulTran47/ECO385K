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
% ECO385K Problem Set 2, 2
% Paul Le Tran, plt377
% 03 November, 2021
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
%% Setting up starting variables used in parts 2a - .
% Declaring levels
U_dec82 = 11500000;
U_dec85 = 8100000;
E_dec82 = 99000000;
E_dec85 = 108200000;
L_dec82 = U_dec82 + E_dec82;
L_dec85 = U_dec85 + E_dec85;
N_dec82 = 62100000;
N_dec85 = 62800000;
P_dec82 = L_dec82 + N_dec82;
P_dec85 = L_dec85 + N_dec85;
%==========================================================================

%==========================================================================
%% Part 2a: Calculate the unemployment rate in December 1982 and December 1985.
% u = U/L
% Calculating unemployment rates
u_dec82 = U_dec82/L_dec82;
u_dec85 = U_dec85/L_dec85;
%==========================================================================

%==========================================================================
%% Part 2b: Calculate the labour force participation rate in December 1982 and December 1985.
% lfpr = L/P
% Calculating labour force participation rates
lfpr_dec82 = L_dec82/P_dec82;
lfpr_dec85 = L_dec85/P_dec85;
%==========================================================================

%==========================================================================
%% Part 2c: Calculate the employment-to-population ratio in December 1982 and December 1985.
% epop = E/P
% Calculating employment-to-population ratios
epop_dec82 = E_dec82/P_dec82;
epop_dec85 = E_dec85/P_dec85;
%==========================================================================

%==========================================================================
%% Part 2d: How much did the unemployment rate change from December 1982 to December 1985?
% Calculating difference and change in unemployment rate
u_diff = u_dec85 - u_dec82;
u_chg = u_diff/u_dec82;

%=======
% ANSWER
%=======
% Regarding per cent changes, the unemployment rate decreased by about
% 33.08% from December 1982 to December 1985. The difference in the
% unemployment rate between these times is roughly -3.44%.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 2e: How much did the labour force participation rate change from December 1982 to December 1985?
% Calculating difference and change in labour force participation rate
lfpr_diff = lfpr_dec85 - lfpr_dec82;
lfpr_chg =  lfpr_diff/lfpr_dec82;

%=======
% ANSWER
%=======
% Regarding per cent changes, the labour force participation rate increased
% by roughly 1.43% from December 1982 to December 1985. The difference in
% the labour force participation rate between these times is roughly 0.91%.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 2f: How much did the employment-to-population ratio change from December 1982 to December 1985?
% Calculating difference and change in employment-to-population ratio
epop_diff = epop_dec85 - epop_dec82;
epop_chg = epop_diff/epop_dec82;

%=======
% ANSWER
%=======
% Regarding per cent changes, the employment-to-population ratio increased
% by roughly 5.33% from December 1982 to December 1985. The difference in
% the employment-to-population ratio between these times is roughly 3.06%.
%===========
% END ANSWER
%===========
%==========================================================================

%==========================================================================
%% Part 2g: What was the role of labour force participation and employment-to-population ratio in the change in the unemployment rate? Derive a decomposition to decompose the effects of these two margins.
% Recall the identity u = 1 - (E/L). This means we obtain the
% following change in unemployment rate, decomposed into logarithmic
% variation in the lfpr and epop:

% du = (1 - u)[dln(L/P) - dln(E/P)].
% $\implies \Delta u \approx \Delta ln(lfpr) - \Delta ln(epop)$

% Calculating natural logarithms of lfpr and epop for both December 1982
% and December 1985.
lfpr_dec82_ln = log(lfpr_dec82);
lfpr_dec85_ln = log(lfpr_dec85);
epop_dec82_ln = log(epop_dec82);
epop_dec85_ln = log(epop_dec85);

% Calculating difference in the above natural logarithms
lfpr_ln_diff = log(lfpr_dec85) - log(lfpr_dec82);
epop_ln_diff = log(epop_dec85) - log(epop_dec82);

u_diff_approx = lfpr_ln_diff - epop_ln_diff;
%=======
% ANSWER
%=======
% By the approximate identity regarding the difference in the unemployment
% rate, we see that the vast majority of the difference is due to the
% difference in the natural logarithm of the employment-to-population
% ratio. This is why the difference in the unemployment rate is negative
% from December 1982 to December 1985.

% For an exercise, we consider the relative contribution/weight of lfpr and
% epop to the difference in the unemployment rate. This requires using the
% sum lfpr_ln_diff + epop_ln_diff instead of the difference. With this sum,
% we see that the contribution of epop_ln_diff is 78.53% and the
% contribution of lfpr_ln_diff is 21.47%.
%===========
% END ANSWER
%===========