global x y ah counter img_dir lib info outlet
counter=-1;
img_dir=dir('C:\Users\fkalaganis\Desktop\NeuroMkt\Leaflet_Images')

lib = lsl_loadlib();
info = lsl_streaminfo(lib,'MyMarkerStream3','Markers',1,0,'cf_string','myuniquesourceid23443');
outlet = lsl_outlet(info);

for i=1:2
    if strcmp(img_dir(i).name,'.')
        img_dir(i)=[];
    end
    if strcmp(img_dir(i).name,'..')
        img_dir(i)=[];
    end
end
pause(10)
x=figure('WindowState','fullscreen','Menu','none','ToolBar','none');
set(x, 'WindowKeyPressFcn', @KeyPress)
ah = axes('Units','Normalize','Position',[0 0 1 1]);