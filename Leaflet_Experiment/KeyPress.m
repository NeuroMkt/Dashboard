function KeyPress(Source, EventData)
global x y ah counter img_dir lib info outlet
%disp(EventData)
if strcmp(EventData.Key,'rightarrow')
    counter=1+counter;
elseif strcmp(EventData.Key,'leftarrow')
    counter=counter-1;
elseif strcmp(EventData.Key,'escape')
    outlet.push_sample({'EOE'});
    disp('End of Experiment')
end
i=mod(counter,size(img_dir,1))+1;

category = "IMG";
path_str = convertCharsToStrings(img_dir(i).folder);
path_split = split(path_str,'\');
img_type = path_split(end);

imshow([img_dir(i).folder '\' img_dir(i).name])
mrk = strcat("Category",":",category,"=","ID",":",img_dir(i).name,"=","Type",":",img_type);
drawnow;
outlet.push_sample({convertStringsToChars(mrk)});%, double(tobii.get_system_time_stamp())/1000000);


end