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
% ECO385K Problem Set 3, 2
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
%% Part 1a - 1e: Setting up, importing, and merging data
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

%======================
% Importing JOLTS hires
%======================
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

%=======================================================
% Importing JOLTS hires, accommodation and food services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS7200HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshiresacc = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_acc.csv'), opts);
% Clear temporary variables
clear opts

%===========================================================
% Importing JOLTS hires, arts, entertainment, and recreation
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS7100HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshiresart = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_art.csv'), opts);
% Clear temporary variables
clear opts

%====================================
% Importing JOLTS hires, construction
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS2300HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshirescon = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_con.csv'), opts);
% Clear temporary variables
clear opts

%==========================================
% Importing JOLTS hires, education services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS610000000000000HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltshiresedu = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_edu.csv'), opts);
% Clear temporary variables
clear opts

%=============================================
% Importing JOLTS hires, finance and insurance
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS520000000000000HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltshiresfin = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_fin.csv'), opts);
% Clear temporary variables
clear opts

%==================================
% Importing JOLTS hires, government
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS9000HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshirespub = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_pub.csv'), opts);
% Clear temporary variables
clear opts

%=========================================================
% Importing JOLTS hires, health care and social assistance
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS6200HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshireshea = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_hea.csv'), opts);
% Clear temporary variables
clear opts

%===================================
% Importing JOLTS hires, information
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS510000000000000HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltshiresinf = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_inf.csv'), opts);
% Clear temporary variables
clear opts

%===================================================
% Importing JOLTS hires, manufacturing durable goods
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS3200HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshiresmfgdur = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_mfgdur.csv'), opts);
% Clear temporary variables
clear opts

%======================================================
% Importing JOLTS hires, manufacturing nondurable goods
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS3400HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshiresmfgnon = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_mfgnon.csv'), opts);
% Clear temporary variables
clear opts

%==============================
% Importing JOLTS hires, mining
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS110099000000000HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltshiresmin = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_min.csv'), opts);
% Clear temporary variables
clear opts

%======================================
% Importing JOLTS hires, other services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS810000000000000HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltshiresoth = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_oth.csv'), opts);
% Clear temporary variables
clear opts

%==========================================================
% Importing JOLTS hires, professional and business services
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS540099HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshiresbus = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_bus.csv'), opts);
% Clear temporary variables
clear opts

%==========================================================
% Importing JOLTS hires, real estate and rental and leasing
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS530000000000000HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltshiresrea = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_rea.csv'), opts);
% Clear temporary variables
clear opts

%====================================
% Importing JOLTS hires, retail trade
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS4400HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
% Import the data
joltshiresret = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_ret.csv'), opts);
% Clear temporary variables
clear opts

%=================================================================
% Importing JOLTS hires, transportation, warehousing and utilities
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS480099000000000HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltshiresutl = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_utl.csv'), opts);
% Clear temporary variables
clear opts

%=======================================
% Importing JOLTS hires, wholesale trade
opts = delimitedTextImportOptions("NumVariables", 2);
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
% Specify column names and types
opts.VariableNames = ["DATE", "JTS420000000000000HIL"];
opts.VariableTypes = ["datetime", "double"];
% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
% Specify variable properties
opts = setvaropts(opts, "DATE", "InputFormat", "dd/MM/yyyy");
% Import the data
joltshireswho = readtable(append(data_dir, '\JOLTS\hires\jolts_hires_who.csv'), opts);
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
%============
% JOLTS hires
%============
jolts_hires_tnf = joltshirestnf{:, 2};
jolts_hires_acc = joltshiresacc{:, 2};
jolts_hires_art = joltshiresart{:, 2};
jolts_hires_bus = joltshiresbus{:, 2};
jolts_hires_con = joltshirescon{:, 2};
jolts_hires_edu = joltshiresedu{:, 2};
jolts_hires_fin = joltshiresfin{:, 2};
jolts_hires_hea = joltshireshea{:, 2};
jolts_hires_inf = joltshiresinf{:, 2};
jolts_hires_mfgdur = joltshiresmfgdur{:, 2};
jolts_hires_mfgnon = joltshiresmfgnon{:, 2};
jolts_hires_min = joltshiresmin{:, 2};
jolts_hires_oth = joltshiresoth{:, 2};
jolts_hires_pub = joltshirespub{:, 2};
jolts_hires_rea = joltshiresrea{:, 2};
jolts_hires_ret = joltshiresret{:, 2};
jolts_hires_utl = joltshiresutl{:, 2};
jolts_hires_who = joltshireswho{:, 2};

% Creating scalar representing total number of months/length of vectors
global N;
N = length(cps_U);

clear cpsU cpsUacc cpsUart cpsUbus cpsUcon cpsUedu cpsUfin cpsUhea cpsUinf cpsUmfgdur cpsUmfgnon cpsUmin cpsUoth cpsUpub cpsUrea cpsUret cpsUutl cpsUwho;
clear joltsvactnf joltsvacacc joltsvacart joltsvacbus joltsvaccon joltsvacedu joltsvacfin joltsvachea joltsvacinf joltsvacmfgdur joltsvacmfgnon joltsvacmin joltsvacoth joltsvacpub joltsvacrea joltsvacret joltsvacutl joltsvacwho;
clear joltshirestnf joltshiresacc joltshiresart joltshiresbus joltshirescon joltshiresedu joltshiresfin joltshireshea joltshiresinf joltshiresmfgdur joltshiresmfgnon joltshiresmin joltshiresoth joltshirespub joltshiresrea joltshiresret joltshiresutl joltshireswho;
%==========================================================================

%==========================================================================
%% Part 2f: Calculate vacancy and unemployment shares of each industry and plot them
% Calculating unemployment shares of each industry
cd(home_dir);
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

%=====
% NOTE
%=====
% Because of the non-seasonally adjusted volatility of the shares, we are
% electing to plot only the trend of the shares from HP filter.
%=========
% END NOTE
%=========
%=====================================================================
% Plotting unemployment shares (selected industries as in Sahin et al.
% (2014)
%=====================================================================
% Creating zero line
zeroline = zeros(length(dt(1:N, 1)),1);

% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(1:N, 1), hpfilter(Ushare_con, 100), 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(1:N, 1), hpfilter(Ushare_mfgdur, 100), 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(1:N, 1), hpfilter(Ushare_fin, 100), 'LineWidth', 1.25, 'Color', [0, 1, 0]);
hold on
plot(dt(1:N, 1), hpfilter(Ushare_ret, 100), 'LineWidth', 1.25, 'Color', [1, 0, 0]);
hold on
plot(dt(1:N, 1), hpfilter(Ushare_hea, 100), 'LineWidth', 1.25, 'Color', [0, 0, 0.5]);
hold on
plot(dt(1:N, 1), zeroline, 'LineWidth', 1, 'Color', [0, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('Unemployment share');
xtickangle(45);

% Setting y-axis interval
set(gca, 'ylim', [0, 0.2]);
set(gca, 'ytick', 0:0.05:0.2);

% Creating legend
legend('Construction', 'Manufacturing - Durables', 'Finance', 'Retail', 'Health', '', 'Location', 'Northwest');

% Creating title
title({'Unemployment shares by selected industry', 'as in Sahin et al. (2014)'});

saveas(gcf, 'path\to\graphics\2f_plot_Ushare.png');
close(gcf);

%================================================================
% Plotting vacancy shares (selected industries as in Sahin et al.
% (2014)
%================================================================
% Creating zero line
zeroline = zeros(length(dt(1:N, 1)),1);

% Changing axes colours
left_color = [0 0 0];
right_color = [0 0 0];
set(figure,'defaultAxesColorOrder',[left_color; right_color]);

% Plotting series
plot(dt(1:N, 1), hpfilter(vacshare_con, 100), 'LineWidth', 1.25, 'Color', [0, 0, 0]);
hold on
plot(dt(1:N, 1), hpfilter(vacshare_mfgdur, 100), 'LineWidth', 1.25, 'Color', [0, 0, 1]);
hold on
plot(dt(1:N, 1), hpfilter(vacshare_fin, 100), 'LineWidth', 1.25, 'Color', [0, 1, 0]);
hold on
plot(dt(1:N, 1), hpfilter(vacshare_ret, 100), 'LineWidth', 1.25, 'Color', [1, 0, 0]);
hold on
plot(dt(1:N, 1), hpfilter(vacshare_hea, 100), 'LineWidth', 1.25, 'Color', [0, 0, 0.5]);
hold on
plot(dt(1:N, 1), zeroline, 'LineWidth', 1, 'Color', [0, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('Vacancy share');
xtickangle(45);

% Setting y-axis interval
set(gca, 'ylim', [0, 0.3]);
set(gca, 'ytick', 0:0.05:0.3);

% Creating legend
legend('Construction', 'Manufacturing - Durables', 'Finance', 'Retail', 'Health', '', 'Location', 'Northwest');

% Creating title
title({'Vacancy shares by selected industry', 'as in Sahin et al. (2014)'});

saveas(gcf, 'path\to\graphics\2f_plot_vacshare.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 2g: Calculate the correlation between unemployment and vacancy shares of indsutries and plot the time series. What happened to the correlation during the Great recession?
% Creating matrix of Ushares
Ushare_matrix = [Ushare_acc Ushare_art Ushare_bus Ushare_con Ushare_edu Ushare_fin Ushare_hea Ushare_inf Ushare_mfgdur Ushare_mfgnon Ushare_min Ushare_oth Ushare_pub Ushare_rea Ushare_ret Ushare_utl Ushare_who];
% Creating matrix of vacshares
vacshare_matrix = [vacshare_acc vacshare_art vacshare_bus vacshare_con vacshare_edu vacshare_fin vacshare_hea vacshare_inf vacshare_mfgdur vacshare_mfgnon vacshare_min vacshare_oth vacshare_pub vacshare_rea vacshare_ret vacshare_utl vacshare_who];

% Calculating correlation between unemployment and vacancy shares across
% time
% Initialising correlation coefficient vector
corr_Ushare_vacshare = zeros(N, 1);
for i = 1:N
  rho_Ushare_vacshare(i, 1) = corr(Ushare_matrix(i, :)', vacshare_matrix(i, :)');
end

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
plot(dt(1:N, 1), rho_Ushare_vacshare, 'LineWidth', 1.25, 'Color', [0, 0, 0]);

% Creating axes labels
xlabel('Year');
ylabel('Correlation coefficient');
xtickangle(45);

% Creating title
title({'Correlation coefficient between unemployment', 'and vacancy shares across industries'});

saveas(gcf, 'path\to\graphics\2g_plot.png');
close(gcf);
%=======
% ANSWER
%=======
% We see that the correlation coefficient between unemployment and vacancy
% shares across industries became weaker during the Great recession.
% Specifically, the coefficient dropped from about 0.6 to almost 0.3 during
% the recession.
%===========
% END ANSWER
%===========
%==========================================================================