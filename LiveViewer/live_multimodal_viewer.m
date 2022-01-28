lib = lsl_loadlib;
eeginfo = lsl_resolve_byprop(lib,'type','EEG');
eeginlet = lsl_inlet(eeginfo{1});

etinfo = lsl_resolve_byprop(lib,'name','Tobii');
etinlet = lsl_inlet(etinfo{1});

eeg_fs = 500;
eeg = eeginlet.pull_chunk;
buffer=zeros(8,10*eeg_fs);
[b,a]=butter(5, [1 16]/(eeg_fs/2));
et_fs = 120;

while true
    eeg = eeginlet.pull_chunk;
    buffer=circshift(buffer,size(eeg,2),2);
    buffer(:,end-size(eeg,2)+1:end)=eeg;
    filtered_buffer=filtfilt(b,a,buffer')';
    subplot(1,2,1), plot([1:10*eeg_fs]/eeg_fs,filtered_buffer')
    et_sample = etinlet.pull_chunk;
    if isempty(et_sample)
        continue;
    end
    et_sample=et_sample(:,end);
    %clf;
    leftcolor=[0 1 0];
    rightcolor=[0 1 0];
    if isnan(et_sample(1))
        et_sample(isnan(et_sample))=2;
        leftcolor=[1 1 1];
        %rightcolor=[1 1 1];
        %et_sample=ones(12,1);
    end
    if isnan(et_sample(4))
        et_sample(isnan(et_sample))=2;
        rightcolor=[1 1 1];
        %rightcolor=[1 1 1];
        %et_sample=ones(12,1);
    end
    h2= subplot(1,2,2);cla(h2), scatter(et_sample(1),1-et_sample(2),et_sample(6)*100, 'd','filled', 'MarkerFaceColor', leftcolor), hold on
    text(et_sample(1),1-et_sample(2),'L')
    scatter(et_sample(4),1-et_sample(5),et_sample(end)*100, 'd','filled', 'MarkerFaceColor', rightcolor), xlim([0,1]), ylim([0,1])
    text(et_sample(4),1-et_sample(5),'R')

    drawnow
end
