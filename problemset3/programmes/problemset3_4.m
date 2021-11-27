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
% ECO385K Problem Set 3, 4
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

%==========================
% Importing JOLTS vacancies
%==========================
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

%===========================================================
% Importing JOLTS vacancies, accommodation and food services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS7200JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltsvacacc = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_acc.csv'), opts);
% Clear temporary variables
clear opts

%===============================================================
% Importing JOLTS vacancies, arts, entertainment, and recreation
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS7100JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltsvacart = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_art.csv'), opts);
% Clear temporary variables
clear opts

%========================================
% Importing JOLTS vacancies, construction
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS2300JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltsvaccon = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_con.csv'), opts);
% Clear temporary variables
clear opts

%==============================================
% Importing JOLTS vacancies, education services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS610000000000000JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltsvacedu = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_edu.csv'), opts);
% Clear temporary variables
clear opts

%=================================================
% Importing JOLTS vacancies, finance and insurance
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS520000000000000JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltsvacfin = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_fin.csv'), opts);
% Clear temporary variables
clear opts

%======================================
% Importing JOLTS vacancies, government
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS9000JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltsvacpub = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_pub.csv'), opts);
% Clear temporary variables
clear opts

%=============================================================
% Importing JOLTS vacancies, health care and social assistance
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS6200JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltsvachea = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_hea.csv'), opts);
% Clear temporary variables
clear opts

%=======================================
% Importing JOLTS vacancies, information
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS510000000000000JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltsvacinf = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_inf.csv'), opts);
% Clear temporary variables
clear opts

%=======================================================
% Importing JOLTS vacancies, manufacturing durable goods
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS3200JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltsvacmfgdur = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_mfgdur.csv'), opts);
% Clear temporary variables
clear opts

%==========================================================
% Importing JOLTS vacancies, manufacturing nondurable goods
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS3400JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltsvacmfgnon = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_mfgnon.csv'), opts);
% Clear temporary variables
clear opts

%==================================
% Importing JOLTS vacancies, mining
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS110099000000000JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltsvacmin = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_min.csv'), opts);
% Clear temporary variables
clear opts

%==========================================
% Importing JOLTS vacancies, other services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS810000000000000JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltsvacoth = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_oth.csv'), opts);
% Clear temporary variables
clear opts

%==============================================================
% Importing JOLTS vacancies, professional and business services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS540099JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltsvacbus = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_bus.csv'), opts);
% Clear temporary variables
clear opts

%==============================================================
% Importing JOLTS vacancies, real estate and rental and leasing
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS530000000000000JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltsvacrea = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_rea.csv'), opts);
% Clear temporary variables
clear opts

%========================================
% Importing JOLTS vacancies, retail trade
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS4400JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltsvacret = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_ret.csv'), opts);
% Clear temporary variables
clear opts

%=====================================================================
% Importing JOLTS vacancies, transportation, warehousing and utilities
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS480099000000000JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltsvacutl = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_utl.csv'), opts);
% Clear temporary variables
clear opts

%===========================================
% Importing JOLTS vacancies, wholesale trade
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS420000000000000JOL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltsvacwho = readtable(append(data_dir, '\JOLTS\vac\jolts_vac_who.csv'), opts);
% Clear temporary variables
clear opts

%==================================
% Importing CPS unemployment levels
%==================================
%========================================
% Importing CPS unemployment level, total
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
cpsU = readtable(append(data_dir, '\CPS\cps_U.csv'), opts);
% Clear temporary variables
clear opts

%==================================================================
% Importing CPS unemployment level, accommodation and food services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034256"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUacc = readtable(append(data_dir, '\CPS\cps_U_acc.csv'), opts);
% Clear temporary variables
clear opts

%======================================================================
% Importing CPS unemployment level, arts, entertainment, and recreation
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034253"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUart = readtable(append(data_dir, '\CPS\cps_U_art.csv'), opts);
% Clear temporary variables
clear opts

%===============================================
% Importing CPS unemployment level, construction
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034450"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUcon = readtable(append(data_dir, '\CPS\cps_U_con.csv'), opts);
% Clear temporary variables
clear opts

%=====================================================
% Importing CPS unemployment level, education services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034522"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUedu = readtable(append(data_dir, '\CPS\cps_U_edu.csv'), opts);
% Clear temporary variables
clear opts

%========================================================
% Importing CPS unemployment level, finance and insurance
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034199"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUfin = readtable(append(data_dir, '\CPS\cps_U_fin.csv'), opts);
% Clear temporary variables
clear opts

%=============================================
% Importing CPS unemployment level, government
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03032243"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUpub = readtable(append(data_dir, '\CPS\cps_U_pub.csv'), opts);
% Clear temporary variables
clear opts

%====================================================================
% Importing CPS unemployment level, health care and social assistance
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034239"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUhea = readtable(append(data_dir, '\CPS\cps_U_hea.csv'), opts);
% Clear temporary variables
clear opts

%==============================================
% Importing CPS unemployment level, information
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034498"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUinf = readtable(append(data_dir, '\CPS\cps_U_inf.csv'), opts);
% Clear temporary variables
clear opts

%==============================================================
% Importing CPS unemployment level, manufacturing durable goods
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034466"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUmfgdur = readtable(append(data_dir, '\CPS\cps_U_mfgdur.csv'), opts);
% Clear temporary variables
clear opts

%=================================================================
% Importing CPS unemployment level, manufacturing nondurable goods
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034474"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUmfgnon = readtable(append(data_dir, '\CPS\cps_U_mfgnon.csv'), opts);
% Clear temporary variables
clear opts

%=========================================
% Importing CPS unemployment level, mining
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034442"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUmin = readtable(append(data_dir, '\CPS\cps_U_min.csv'), opts);
% Clear temporary variables
clear opts

%=================================================
% Importing CPS unemployment level, other services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034538"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUoth = readtable(append(data_dir, '\CPS\cps_U_oth.csv'), opts);
% Clear temporary variables
clear opts

%======================================================================
% Importing CPS unemployment levels, professional and business services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034514"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUbus = readtable(append(data_dir, '\CPS\cps_U_bus.csv'), opts);
% Clear temporary variables
clear opts

%======================================================================
% Importing CPS unemployment levels, real estate and rental and leasing
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034208"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUrea = readtable(append(data_dir, '\CPS\cps_U_rea.csv'), opts);
% Clear temporary variables
clear opts

%===============================================
% Importing CPS unemployment level, retail trade
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034163"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUret = readtable(append(data_dir, '\CPS\cps_U_ret.csv'), opts);
% Clear temporary variables
clear opts

%==========================================================================
% Importing CPS unemployment level, transportation, warehousing and utilities
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "Value"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUutl = readtable(append(data_dir, '\CPS\cps_U_utl.csv'), opts);
% Clear temporary variables
clear opts

%==================================================
% Importing CPS unemployment level, wholesale trade
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "LNU03034154"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
cpsUwho = readtable(append(data_dir, '\CPS\cps_U_who.csv'), opts);
% Clear temporary variables
clear opts

% Extracting date as a vector
dt = cpsU{:, 1};

% Extracting variables as vectors
%=======================
% CPS unemployment level
%=======================
cps_U = cpsU{:, 2};
cps_U_acc = cpsUacc{:, 2};
cps_U_art = cpsUart{:, 2};
cps_U_bus = cpsUbus{:, 2};
cps_U_con = cpsUcon{:, 2};
cps_U_edu = cpsUedu{:, 2};
cps_U_fin = cpsUfin{:, 2};
cps_U_hea = cpsUhea{:, 2};
cps_U_inf = cpsUinf{:, 2};
cps_U_mfgdur = cpsUmfgdur{:, 2};
cps_U_mfgnon = cpsUmfgnon{:, 2};
cps_U_min = cpsUmin{:, 2};
cps_U_oth = cpsUoth{:, 2};
cps_U_pub = cpsUpub{:, 2};
cps_U_rea = cpsUrea{:, 2};
cps_U_ret = cpsUret{:, 2};
cps_U_utl = cpsUutl{:, 2};
cps_U_who = cpsUwho{:, 2};
%================
% JOLTS vacancies
%================
jolts_vac_tnf = joltsvactnf{:, 2};
jolts_vac_acc = joltsvacacc{:, 2};
jolts_vac_art = joltsvacart{:, 2};
jolts_vac_bus = joltsvacbus{:, 2};
jolts_vac_con = joltsvaccon{:, 2};
jolts_vac_edu = joltsvacedu{:, 2};
jolts_vac_fin = joltsvacfin{:, 2};
jolts_vac_hea = joltsvachea{:, 2};
jolts_vac_inf = joltsvacinf{:, 2};
jolts_vac_mfgdur = joltsvacmfgdur{:, 2};
jolts_vac_mfgnon = joltsvacmfgnon{:, 2};
jolts_vac_min = joltsvacmin{:, 2};
jolts_vac_oth = joltsvacoth{:, 2};
jolts_vac_pub = joltsvacpub{:, 2};
jolts_vac_rea = joltsvacrea{:, 2};
jolts_vac_ret = joltsvacret{:, 2};
jolts_vac_utl = joltsvacutl{:, 2};
jolts_vac_who = joltsvacwho{:, 2};

% Calculating unemployment shares of each industry
Ushare_acc = cps_U_acc./cps_U;
Ushare_art = cps_U_art./cps_U;
Ushare_bus = cps_U_bus./cps_U;
Ushare_con = cps_U_con./cps_U;
Ushare_edu = cps_U_edu./cps_U;
Ushare_fin = cps_U_fin./cps_U;
Ushare_hea = cps_U_hea./cps_U;
Ushare_inf = cps_U_inf./cps_U;
Ushare_mfgdur = cps_U_mfgdur./cps_U;
Ushare_mfgnon = cps_U_mfgnon./cps_U;
Ushare_min = cps_U_min./cps_U;
Ushare_oth = cps_U_oth./cps_U;
Ushare_pub = cps_U_pub./cps_U;
Ushare_rea = cps_U_rea./cps_U;
Ushare_ret = cps_U_ret./cps_U;
Ushare_utl = cps_U_utl./cps_U;
Ushare_who = cps_U_who./cps_U;

% Calculating vacancy shares of each industry
vacshare_acc = jolts_vac_acc./jolts_vac_tnf;
vacshare_art = jolts_vac_art./jolts_vac_tnf;
vacshare_bus = jolts_vac_bus./jolts_vac_tnf;
vacshare_con = jolts_vac_con./jolts_vac_tnf;
vacshare_edu = jolts_vac_edu./jolts_vac_tnf;
vacshare_fin = jolts_vac_fin./jolts_vac_tnf;
vacshare_hea = jolts_vac_hea./jolts_vac_tnf;
vacshare_inf = jolts_vac_inf./jolts_vac_tnf;
vacshare_mfgdur = jolts_vac_mfgdur./jolts_vac_tnf;
vacshare_mfgnon = jolts_vac_mfgnon./jolts_vac_tnf;
vacshare_min = jolts_vac_min./jolts_vac_tnf;
vacshare_oth = jolts_vac_oth./jolts_vac_tnf;
vacshare_pub = jolts_vac_pub./jolts_vac_tnf;
vacshare_rea = jolts_vac_rea./jolts_vac_tnf;
vacshare_ret = jolts_vac_ret./jolts_vac_tnf;
vacshare_utl = jolts_vac_utl./jolts_vac_tnf;
vacshare_who = jolts_vac_who./jolts_vac_tnf;

clear cpsU cpsUacc cpsUart cpsUbus cpsUcon cpsUedu cpsUfin cpsUhea cpsUinf cpsUmfgdur cpsUmfgnon cpsUmin cpsUoth cpsUpub cpsUrea cpsUret cpsUutl cpsUwho;
clear joltsvactnf joltsvacacc joltsvacart joltsvacbus joltsvaccon joltsvacedu joltsvacfin joltsvachea joltsvacinf joltsvacmfgdur joltsvacmfgnon joltsvacmin joltsvacoth joltsvacpub joltsvacrea joltsvacret joltsvacutl joltsvacwho;
%==========================================================================

%==========================================================================
% Part 4: Compute M_{t}^{u} = sum(abs(\frac{u_{i, t}}{u_{t}} - \frac{v_{i, t}}{v_{t}}))/2
% Creating Ushare and vacshare matricies
Ushare_matrix = [Ushare_acc Ushare_art Ushare_bus Ushare_con Ushare_edu Ushare_fin Ushare_hea Ushare_inf Ushare_mfgdur Ushare_mfgnon Ushare_min Ushare_oth Ushare_pub Ushare_rea Ushare_ret Ushare_utl Ushare_who];
vacshare_matrix = [vacshare_acc vacshare_art vacshare_bus vacshare_con vacshare_edu vacshare_fin vacshare_hea vacshare_inf vacshare_mfgdur vacshare_mfgnon vacshare_min vacshare_oth vacshare_pub vacshare_rea vacshare_ret vacshare_utl vacshare_who];

% Initialising vector that will hold RHS sum component
cd(home_dir);
rhs_sum_component = zeros(length(cps_U), 1);
for i = 1:min(size(Ushare_matrix))
  abs_diff = abs(Ushare_matrix(:, i) - vacshare_matrix(:, i));
  rhs_sum_component = rhs_sum_component + abs_diff;
end
clear i abs_diff;
Mt_u = rhs_sum_component/2;

% Plotting M_{t}^{u}
% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt, Mt_u, 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on

% Creating axes labels
xlabel('Year');
ylabel('Value');
xtickangle(45);

% Creating title
title({'Simple mismatch index'});

saveas(gcf, 'path\to\graphics\4_plot.png');
close(gcf);

%=======
% ANSWER
%=======
% Our plot of the calculated simple mismatch index shows that whilst some
% elevated spikes occurred in the early 2000s and around 2008, the index
% dramatically increased and reached its maximum between 2009 - 2010.It
% would only return to pre-Great-recession levels around 2011, where it
% would continue to decrease around 2014.
%===========
% END ANSWER
%===========