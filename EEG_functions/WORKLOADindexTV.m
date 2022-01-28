function [WORK_TV,index_sample] = WORKLOADindexTV(signal, Fs, left_channel, window_size, step_size)
%%%%%%%%% INPUT %%%%%%%%%%%%%
% - signal: is an EEG segment in the form of [channels x time samples]
% - Fs: sampling frequency for EEG
% - left_channel: index for the left (pre)frontal channel
% - right_channel: index for the right (pre)frontal channel
% - window_size: The size of window (in samples) where the workload 
% index will be calculated
% - step_size: The step size (in samples) to indicate how often to
% calculate the workload index.
%%%%%%%% OUTPUT %%%%%%%%%%%%%%
% * WORK_TV: Timevarying workload index
% * index_sample: The central index that each workload value corresponds to.
%%%%%%% TIP %%%%%%%%%%%%%%%%%
% $1 WORK_TV might need normalization (e.g. z-score)
% $2 index_sample can be converted to time by deviding it with Fs

%% Implementation
WORK_TV=[];
index_sample=[];
for i_sample=1+window_size:step_size:size(signal,2)-window_size
    WORK_TV(end+1) = bandpower(signal(left_channel,i_sample-window_size:i_sample+window_size),Fs,[8 13]) - ...
        bandpower(signal(left_channel,i_sample-window_size:i_sample+window_size),Fs,[8 13]);
    
    index_sample(end+1)=i_sample;
end
end