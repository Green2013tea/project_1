
sample_IDs = get(listbox_button,'value');

cla(ax1);
cla(ax2);
cla(ax3);

names = fieldnames(MBR.OD600);
mbrs ={};
for i = 1:length(sample_IDs)
    mbrs{i,1} = names{sample_IDs(i)};
end



% pH
for i = 1:length(sample_IDs)
set( gca, 'DataAspectRatioMode', 'auto' )
    hold(ax1,'on')
    kk = sample_IDs(i);
    x1 = MBR.pH.(list_MBR{kk})(:,1);
    y1 = MBR.pH.(list_MBR{kk})(:,2);
    plot(ax1,x1,y1)
    
end


% DO
for i = 1:length(sample_IDs)
set( gca, 'DataAspectRatioMode', 'auto' )
    hold(ax2,'on')
    kk = sample_IDs(i);
    x2 = MBR.DO.(list_MBR{kk})(:,1);
    y2 = MBR.DO.(list_MBR{kk})(:,2);
    plot(ax2,x2,y2)
    
end


% OD600
for i = 1:length(sample_IDs)
    
hold on
set( gca, 'DataAspectRatioMode', 'auto' )
    hold(ax3,'on')
    kk = sample_IDs(i);
    x3 = MBR.OD600.(list_MBR{kk})(:,1);
    y3 = MBR.OD600.(list_MBR{kk})(:,2);
    plot(ax3,x3,y3,'marker','o','linestyle','--')
    

end




    
leg1 = legend(ax1,mbrs,'location',[0.36, 0.60, 0.03, 0.03])
%legend(ax2,mbrs,'location',[0.36, 0.25, 0.03, 0.03])
leg3 = legend(ax3,mbrs,'location',[0.88, 0.76, 0.03, 0.03])
set(leg1,'fontsize',8)
set(leg3,'fontsize',8)

hold(ax2,'off')
hold(ax3,'off')
hold(ax1,'off')




%% sliders for ln(OD600) plot
max_slide_min = length(MBR.OD600.(list_MBR{1})(:,1))-1;
min_slide_min = 0;

max_slide_max = length(MBR.OD600.(list_MBR{1})(:,1))-1;
min_slide_max = 0;


slider_min =uicontrol('parent',h,'Style','slider','Units','normalized','Position',[0.50 0.08 0.35 0.015],'min',min_slide_min,'max',max_slide_min,'sliderstep',[0.05 0.1],'callback','plotdata_slider');
slider_max =uicontrol('parent',h,'Style','slider','Units','normalized','Position',[0.50 0.06 0.35 0.015],'min',min_slide_max,'max',max_slide_max,'sliderstep',[0.05 0.1],'callback','plotdata_slider');
set(slider_max,'value',max_slide_max);
set(slider_min,'value',1);


slide_table1 =uicontrol('parent',h,'Style','text','string','lowest value','Units','normalized','Position',[0.87 0.05 0.07 0.05]);
slide_table2 =uicontrol('parent',h,'Style','text','string','highest value','Units','normalized','Position',[0.87 0.03 0.07 0.05]);
set(slide_table1,'fontsize',10)
set(slide_table2,'fontsize',10)




