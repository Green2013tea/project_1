

% Export data to Excel
cd(folder)
exp = uigetdir;
cd(exp);

file = 'IL_22-32.xlsx'; % add your excel file name here
header = rwithOD';



for i = 1:length(rwithOD);
    if i == 1
        ODdata = plotdata.OD600.(rwithOD{i});
        pHdata = plotdata.pH.(rwithOD{i});
        DOdata = plotdata.DO.(rwithOD{i});
    else
        ODdata = horzcat(ODdata,plotdata.OD600.(rwithOD{i})(:,2));
        pHdata = horzcat(pHdata,plotdata.pH.(rwithOD{i})(:,2));
        DOdata = horzcat(DOdata,plotdata.DO.(rwithOD{i})(:,2));
    end
end

sheet = 'OD600';
xlswrite(file,ODdata,sheet,'A2');
xlswrite(file,{'time [h]'},sheet,'A1');
xlswrite(file,header,sheet,'B1');

sheet = 'Dissolved Oxygen';
xlswrite(file,DOdata,sheet,'A2');
xlswrite(file,{'time [h]'},sheet,'A1');
xlswrite(file,header,sheet,'B1');

sheet = 'pH';
xlswrite(file,pHdata,sheet,'A2');
xlswrite(file,{'time [h]'},sheet,'A1');
xlswrite(file,header,sheet,'B1');

cd(mainfolder);
    
    
    