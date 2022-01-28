function [AW_TV,index_sample] = AWindexTV(signal, Fs, left_channel, right_channel window_size, step_size)
%%%%%%%%% INPUT %%%%%%%%%%%%%
% - signal: is an EEG segment in the form of [channels x time samples]
% - Fs: sampling frequency for EEG
% - left_channel: index for the left (pre)frontal channel
% - right_channel: index for the right (pre)frontal channel
% - window_size: The size of window (in samples) where the AW-index will be
% calculated
% - step_size: The step size (in samples) to indicate how often to
% calculate the AW index.
%%%%%%%% OUTPUT %%%%%%%%%%%%%%
% * AW_TV: Timevarying approach-withdrawal index
% * index_sample: The central index that each AW value corresponds to.
%%%%%%% TIP %%%%%%%%%%%%%%%%%
% $1 AW_TV might need normalization (e.g. z-score)
% $2 AW_TV might need scaling (e.g. AW_TV*0.01)
% $3 index_sample can be converted to time by deviding it with Fs

%% Implementation
AW_TV=[];
index_sample=[];
for i_sample=1+window_size:step_size:size(signal,2)-window_size
    AW_TV(end+1) = bandpower(signal(left_channel,i_sample-window_size:i_sample+window_size),Fs,[8 13]) - ...
        bandpower(signal(right_channel,i_sample-window_size:i_sample+window_size),Fs,[8 13]);
    
    index_sample(end+1)=i_sample;
end
end