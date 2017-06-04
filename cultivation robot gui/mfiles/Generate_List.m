

% Generate list for data plotting

listbox_button =uicontrol('parent',h,'Style','listbox','String',list_MBR,'Units','normalized','Position',[0.02 0.73 0.1 0.1],'min',0,'max',length(list_MBR));
plotbutton=uicontrol('parent',h,'Style','pushbutton','String','Plot Data','Units','normalized','Position',[0.14 0.80 0.2 0.03],'Callback','plotdata_GUI');
clearbutton=uicontrol('parent',h,'Style','pushbutton','String','Clear plots','Units','normalized','Position',[0.14 0.75 0.2 0.03],'Callback','clear_GUI');
listbox_slider =uicontrol('parent',h,'Style','listbox','String',list_MBR,'Units','normalized','Position',[0.86 0.40 0.1 0.1],'min',0,'max',1);
plotbutton_slider =uicontrol('parent',h,'Style','pushbutton','String','Select','Units','normalized','Position',[0.86 0.36 0.1 0.03],'Callback','plotdata_slider');
