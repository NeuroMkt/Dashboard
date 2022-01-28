function EEG_clean=wICA_denoise(multichannel_trial, no_ICs, plot_on)
% - multichannel_trial: is an EEG segment in the form of [channels x time samples]
% - no_ICs: Number of components for the ICA, should be less than channles
%  (a rule of thumb is 2/3 of channels)
% - plot_on: A binary var to whether show plots or not
%
% * EEG_clean: Clean EEG segmnet by the wavelet ICA method
%
% $1 Requires the jader method for ICA calculation.
% $2 Tip: Bad sensors should have been removed first.

% Created by F. Kalaganis and N. Laskaris

B=jader(multichannel_trial,no_ICs); % deriving the unmixing-matrix
ICA_activations=B*multichannel_trial; % estimating the ICs (source-signal)
kurt_vector=kurtosis(ICA_activations'); %outlist1=isoutlier(kurt_vector)
skew_vector=skewness(ICA_activations');%outlist2=isoutlier(skew_vector)
[~,~,mah,outliers] =robustcov(sum(squareform(pdist((zscore([skew_vector',kurt_vector']))))));kept_list_A=not(outliers);outlier_list=find(outliers);

if plot_on
    figure(10),clf,subplot(2,2,2),stem(kurt_vector),hold,plot(outlier_list,kurt_vector(outlier_list),'r*'),
    subplot(2,2,4),stem(skew_vector),hold,plot(outlier_list,skew_vector(outlier_list),'r*'),
    subplot(1,2,1),strips(ICA_activations'),
end

%% wavelet-ICA
for i_out=1:numel(outlier_list)
    %ICA_activations(outlier_list(i_out),:)=0;
    xnoisy=ICA_activations(outlier_list(i_out),:);
    contamination = wdenoise(xnoisy,floor(log2(length(xnoisy))), 'Wavelet', 'bior1.1','DenoisingMethod', {'FDR',0.01}, 'ThresholdRule', 'Hard', 'NoiseEstimate', 'LevelDependent');
    ICA_activations(outlier_list(i_out),:)=xnoisy-contamination;
end

%clean_DATA=inv(unmixing_MATRIX)*ICA_activations;
Clean_DATA_MATRIX=pinv(B)*ICA_activations;

EEG_clean=Clean_DATA_MATRIX;

end
