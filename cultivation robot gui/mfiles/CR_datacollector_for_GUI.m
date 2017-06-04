%% Open file and folder

[filename,folder]  = uigetfile('*.xls'); % open file ffrom dir
cd(folder);
data = importdata(filename);

cd(mainfolder);

%% write string time to matlab time as double 
tic
for i = 2:length(data)
    time = char(data(i,2));
    date = char(data(i,1));
    timedate = [date ' ' time];
    num_time(i,1) = datenum(timedate);
end


for i =1:length(num_time)
    num_time_0(i,1) = (num_time(i)-num_time(2))*24;
end

toc
%% find sampling data

ID = {'OD600' 'DilutionFactor' 'pH' 'DO'};

% replace ',' by '.' in OD600 data
indOD = find(strcmp(data(1,:),ID(1))==1); 
OD600.string = data(:,find(strcmp(data(1,:),ID(1))==1));
OD600.string_value = strrep(OD600.string,',','.');

OD600.raw = cellfun(@str2double,OD600.string_value);
OD600.dilFac = cellfun(@str2double,data(:,find(strcmp(data(1,:),ID(2))==1)));
pH.raw = cellfun(@str2double,data(:,find(strcmp(data(1,:),ID(3))==1)));
DO.raw = cellfun(@str2double,data(:,find(strcmp(data(1,:),ID(4))==1)));


%% Organize data by reactor for OD600

% find data position for all 48 reactors
ind_r = {'Container'};
ind_r2 = find(strcmp(data(1,:),ind_r)==1); 
reactors = unique(data(:,ind_r2));

for i = 1:length(reactors)
    for k = 1:length(data)
        ind2.logical.(reactors{i})(k,1) = strcmp(reactors{i},data(k,ind_r2));
    end
end

%% find OD600 values and make time-value pairs

for i = 1:length(reactors)
    ind3= find(ind2.logical.(reactors{i})==1);
    for k = 1:length(ind3)
        ind4(k,1) = isnan(OD600.raw(ind3(k)));
    end
    
    for k = 1:length(ind3)
        if ind4(k) == 0
            OD600.data.(reactors{i})(k,2) = OD600.raw(ind3(k));
            OD600.data.(reactors{i})(k,1) = num_time_0(ind3(k));
            OD600.data.(reactors{i})(k,3) = OD600.dilFac(ind3(k));
        else
            OD600.data.(reactors{i})(k,2) = NaN;
            OD600.data.(reactors{i})(k,1) = NaN;
            OD600.data.(reactors{i})(k,3) = NaN; 
        end
    end
end

%% remove NaNs
for i = 1:length(reactors)
    A= OD600.data.(reactors{i});
    B= A(~any(isnan(A),2),:);
    OD600.wo_NaN.(reactors{i}) = B;
end


for i = 1:length(reactors)
    if isempty(OD600.wo_NaN.(reactors{i})) == 0
        %blank = mean(OD600.wo_NaN.H3(1,2));
        %A = (OD600.wo_NaN.(reactors{i})(:,2)-OD600.wo_NaN.(reactors{i})(1,2)).*OD600.wo_NaN.(reactors{i})(:,3);
        %A = (OD600.wo_NaN.(reactors{i})(:,2)-blank).*OD600.wo_NaN.(reactors{i})(:,3);
        %compensate for dilution
        A = (OD600.wo_NaN.(reactors{i})(:,2)).*OD600.wo_NaN.(reactors{i})(:,3);
        %A = (OD600.wo_NaN.(reactors{i})(:,2)).*OD600.wo_NaN.(reactors{i})(:,3);
        OD600.tvpairs.(reactors{i}) = OD600.wo_NaN.(reactors{i})(:,1);
        OD600.tvpairs.(reactors{i})(:,2) = A;
    else
       OD600.tvpairs.(reactors{i}) = OD600.wo_NaN.(reactors{i});
    end
end


%% Organize data by reactor for pH

% find pH values and make time-value pairs
for i = 1:length(reactors)
    ind3= find(ind2.logical.(reactors{i})==1);
    for k = 1:length(ind3)
        ind4(k,1) = isnan(pH.raw(ind3(k)));
    end
    
    for k = 1:length(ind3)
        if ind4(k) == 0
            pH.data.(reactors{i})(k,2) = pH.raw(ind3(k));
            pH.data.(reactors{i})(k,1) = num_time_0(ind3(k));
        else
            pH.data.(reactors{i})(k,2) = NaN;
            pH.data.(reactors{i})(k,1) = NaN; 
        end
    end
end

% remove NaNs
for i = 1:length(reactors)
    A= pH.data.(reactors{i});
    B= A(~any(isnan(A),2),:);
    pH.tvpairs.(reactors{i}) = B;
end

%% Organize data by reactor for DO

% find DO values and make time-value pairs

for i = 1:length(reactors)
    ind3= find(ind2.logical.(reactors{i})==1);
    for k = 1:length(ind3)
        ind4(k,1) = isnan(DO.raw(ind3(k)));
    end
    
    for k = 1:length(ind3)
        if ind4(k) == 0
            DO.data.(reactors{i})(k,2) = DO.raw(ind3(k));
            DO.data.(reactors{i})(k,1) = num_time_0(ind3(k));
        else
            DO.data.(reactors{i})(k,2) = NaN;
            DO.data.(reactors{i})(k,1) = NaN; 
        end
    end
end

% remove NaNs
for i = 1:length(reactors)
    A= DO.data.(reactors{i});
    B= A(~any(isnan(A),2),:);
    DO.tvpairs.(reactors{i}) = B;
end



%% Find reactors with values for OD600

for i = 1:length(reactors)
    ind5(i) = isempty(OD600.tvpairs.(reactors{i}));
end

for i = 1:length(ind5)
    if ind5(i) == 0
        plotdata.OD600.(reactors{i}) = OD600.tvpairs.(reactors{i});
        plotdata.pH.(reactors{i}) = pH.tvpairs.(reactors{i});
        plotdata.DO.(reactors{i}) = DO.tvpairs.(reactors{i});
    end
end

rwithOD = fieldnames(plotdata.OD600);



%% export analyzed data to Matlab workspace

MBR = plotdata;
list_parameters = fieldnames(MBR);
list_MBR = fieldnames(MBR.OD600);


