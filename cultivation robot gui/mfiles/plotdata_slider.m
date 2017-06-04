
% clear axes

cla(ax4)

% get value from slider and round to integer

slope_ID = get(listbox_slider,'value');


value_min = get(slider_min,'value');
value_min1 = round(value_min);

if value_min1 == 0
    value_min1 = 1;
end

value_max = get(slider_max,'value');
value_max1 = round(value_max);

if value_max1 == 0
    value_max1 = 1;
end

% plot data in selected range


    
set( gca, 'DataAspectRatioMode', 'auto' )
    hold(ax4,'on')
    kk = slope_ID;
    
    x4_all = MBR.OD600.(list_MBR{kk})(2:end,1);
    y4_all = log(MBR.OD600.(list_MBR{kk})(2:end,2));
    
    x4= x4_all(value_min:value_max1);
    y4= y4_all(value_min:value_max1);
  
    [B, Stats] = robustfit(x4,y4);
    fitplot = B(2)*x4+B(1);
    plot(ax4,x4_all,y4_all,'marker','o','linestyle','none')
    plot(ax4,x4,fitplot)
    slope = round(B(2),4,'significant');
    table = num2str(slope);
    hold(ax4,'off')



regress_table1 =uicontrol('parent',h,'Style','text','string','slope','Units','normalized','Position',[0.86 0.27 0.1 0.05]);
regress_table2 =uicontrol('parent',h,'Style','text','string',table,'Units','normalized','Position',[0.86 0.24 0.1 0.05]);
set(regress_table1,'fontsize',12)
set(regress_table2,'fontsize',12)
