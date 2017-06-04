
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This file has been created as GUI for import and visualization of data
% from the Hamilton Vantage Cultivation Robot. 
% Data import is performed by simply loading the data export sheet from the
% Cultivation Robot. Data can be visually evaluated and exported to excel
% for further data analysis.
%
% Last update: 09-12-2015 by ToKle
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% buttons for import data and export to excel

clc, clear, close all

fold = pwd;
mainfolder = strcat(fold,'\Cultivation Robot GUI');
%cd(mainfolder);

h = figure(1);
set(h,'Units','centimeters','Position',[3, 1, 32, 22])



Button1=uicontrol('parent',h,'Style','pushbutton','String','Load data','Units','normalized','Position',[0.02 0.85 0.1 0.1],'Callback','CR_datacollector_for_GUI');
Button2=uicontrol('parent',h,'Style','pushbutton','String','Excel Export','Units','normalized','Position',[0.13 0.85 0.1 0.1],'Callback','Excel_export');
Button3=uicontrol('parent',h,'Style','pushbutton','String','Analyze Data','Units','normalized','Position',[0.24 0.85 0.1 0.1],'Callback','Generate_List');

ax1=axes('parent',h,'position',[0.03, 0.45, 0.30, 0.25]);
ax2=axes('parent',h,'position',[0.03, 0.10, 0.30, 0.25]);
ax3=axes('parent',h,'position',[0.50, 0.60, 0.35, 0.35]);
ax4=axes('parent',h,'position',[0.50, 0.15, 0.35, 0.35]);

title(ax1,'pH')
title(ax2,'dissolved oxygen [%]')
title(ax3,'OD600 [AU]')
title(ax4,'lnOD600 [-]')

xlabel(ax1,'time [h]')
xlabel(ax2,'time [h]')
xlabel(ax3,'time [h]')
xlabel(ax4,'time [h]')