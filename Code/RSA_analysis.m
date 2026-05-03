% RSA_analysis.m
%
% Representational Similarity Analysis (RSA) on fMRI data for the
% Architectural Livingness project. Computes neural representational
% dissimilarity matrices (RDMs) from voxel-pattern responses to
% high- and low-livingness images across the three stimulus categories
% (geometric patterns, architectural details, building facades), and
% tests their relationship to model RDMs.
%
% Requires: SPM12, plus an RSA toolbox (e.g., CoSMoMVPA or rsatoolbox).
%
% Inputs:  subject-level beta maps from the first-level GLM
% Outputs: neural RDMs and group-level statistics
%
% See Methods and Supplementary Material S6 for analytical details.

clc;
clear;


subject_ids={'Sbjxx','Sbjxx'};

nsubjects=numel(subject_ids);
study_path='xxx';


for subject_num=1:nsubjects
    subject_id=subject_ids{subject_num};

    output_path=fullfile('xx');
    mask_fn=fullfile('xx'); 
    
    data_fn=fullfile(study_path,subject_id,'xx\SPM.mat:spm'); 
    ds=cosmo_fmri_dataset(data_fn,'mask',mask_fn,...
                                'targets',[1 2 3 4 5 6 ],'chunks',1); 

    labels = {'AHigh';'ALow';...
              'BHigh';'BLow';...
              'CHigh';'CLow'};
    ds.sa.labels = labels;
    cosmo_check_dataset(ds);
    fprintf('Dataset input:\n');
    cosmo_disp(ds);
    
    %% t
    nsamples=size(ds.samples,1);
    model=zeros(nsamples);
    
    % Prepare the theoretical RDMs
    AHigh_rdm = [0	1	1	1	1	1
               1	0	0	0	0	0
               1	0	0	0	0	0
               1	0	0	0	0	0
               1	0	0	0	0	0
               1	0	0	0	0	0];

    ALow_rdm = [0	 1	0	0	0	0
                1	 0	1	1	1	1
                0	 1	0	0	0	0
                0	 1	0	0	0	0
                0	 1	0	0	0	0
                 0	 1	0	0	0	0];

    BHigh_rdm = [0   0	1	0	0	0
                 0	 0	1	0	0	0
                 1	 1	0	1	1	1
                 0	 0	1	0	0	0
                 0	 0	1	0	0	0
                 0	 0	1	0	0	0];

    BLow_rdm = [0	0	0	1	0	0
                0	0	0	1	0	0
                0	0	0	1	0	0
                1	1	1	0	1	1
                0	0	0	1	0	0
                0	0	0	1	0	0];

    CHigh_rdm = [0	0	0	0	1	0
                 0	0	0	0	1	0
                 0	0	0	0	1	0
                 0	0	0	0	1	0
                 1	1	1	1	0	1
                 0	0	0	0	1	0];

    CLow_rdm = [0	0	0	0	0	1
                0	0	0	0	0	1
                0	0	0	0	0	1
                0	0	0	0	0	1
                0	0	0	0	0	1
                1	1	1	1	1	0];


    num_conditions=length(labels);
    options.metric = 'euclidean'; 
    univariate_rdm = cosmo_dissimilarity_matrix_measure(ds, options); 
    idx = 1;  univariate_rdm_matrix = zeros(6,6);  
    for kk=1:length(univariate_rdm.samples)
        univariate_rdm_matrix(univariate_rdm.sa.targets1(kk),univariate_rdm.sa.targets2(kk))=univariate_rdm.samples(kk);
        univariate_rdm_matrix(univariate_rdm.sa.targets2(kk),univariate_rdm.sa.targets1(kk))=univariate_rdm.samples(kk);
    end

    Mean_6cons=mean(ds.samples,2);
 
    multivariate_rdm = zeros(num_conditions, num_conditions);
    for i = 1:num_conditions
        for j = 1:num_conditions
            if i ~= j
                corr_value = corr(ds.samples(i, :)', ds.samples(j, :)');
                multivariate_rdm(i, j) = 1 - corr_value; 
            end
        end
    end

    rdm_size = size(AHigh_rdm, 1); 
    
    AHigh_vec = AHigh_rdm(triu(true(rdm_size), 1));
    ALow_vec  = ALow_rdm(triu(true(rdm_size), 1));
    BHigh_vec  = BHigh_rdm(triu(true(rdm_size), 1));
    BLow_vec = BLow_rdm(triu(true(rdm_size), 1));
    CHigh_vec  = CHigh_rdm(triu(true(rdm_size), 1));
    CLow_vec  = CLow_rdm(triu(true(rdm_size), 1));

    univariate_vec = univariate_rdm_matrix(triu(true(rdm_size), 1));
    multivariate_vec = multivariate_rdm(triu(true(rdm_size), 1));
    
    AHigh_Univariate_corr(subject_num) = corr(univariate_vec, AHigh_vec, 'Type', 'Spearman');
    ALow_Univariate_corr(subject_num)  = corr(univariate_vec, ALow_vec, 'Type', 'Spearman');
    BHigh_Univariate_corr(subject_num)  = corr(univariate_vec, BHigh_vec, 'Type', 'Spearman');
    BLow_Univariate_corr(subject_num) = corr(univariate_vec, BLow_vec, 'Type', 'Spearman');
    CHigh_Univariate_corr(subject_num)  = corr(univariate_vec, CHigh_vec, 'Type', 'Spearman');
    CLow_Univariate_corr(subject_num)  = corr(univariate_vec, CLow_vec, 'Type', 'Spearman');
    

    AHigh_Multivariate_corr(subject_num) = corr(multivariate_vec, AHigh_vec, 'Type', 'Spearman');
    ALow_Multivariate_corr(subject_num)  = corr(multivariate_vec, ALow_vec, 'Type', 'Spearman');
    BHigh_Multivariate_corr(subject_num)  = corr(multivariate_vec, BHigh_vec, 'Type', 'Spearman');
    BLow_Multivariate_corr(subject_num) = corr(multivariate_vec, BLow_vec, 'Type', 'Spearman');
    CHigh_Multivariate_corr(subject_num)  = corr(multivariate_vec, CHigh_vec, 'Type', 'Spearman');
    CLow_Multivariate_corr(subject_num)  = corr(multivariate_vec, CLow_vec, 'Type', 'Spearman');
    
    univariate_threshold = 0.15; 
    multivariate_threshold = 0.15; 
    
    Univariate_corr=[AHigh_Univariate_corr(subject_num),...
                    ALow_Univariate_corr(subject_num),...
                    BHigh_Univariate_corr(subject_num),...
                    BLow_Univariate_corr(subject_num),...
                    CHigh_Univariate_corr(subject_num),...
                    CLow_Univariate_corr(subject_num)];
    
   Multivariate_corr=[AHigh_Multivariate_corr(subject_num),...
                     ALow_Multivariate_corr(subject_num),...
                     BHigh_Multivariate_corr(subject_num),...
                     BLow_Multivariate_corr(subject_num),...
                     CHigh_Multivariate_corr(subject_num),...
                     CLow_Multivariate_corr(subject_num)];

    rdm={AHigh_rdm,ALow_rdm,BHigh_rdm,...
         BLow_rdm,CHigh_rdm,CLow_rdm};
    
    % Univariate_corr
    single_max_corr=0;

    univariate_union = zeros(num_conditions,num_conditions); 
    for i = 1:num_conditions
        if Univariate_corr(i) >= univariate_threshold
            univariate_union = univariate_union|rdm{i}; 
        end
        if Univariate_corr(i) == max(Univariate_corr)
            univariate_SingleMaxMdoel = rdm{i}; 
        end
    end
    univariate_union_vec = univariate_union(triu(true(rdm_size), 1));
    if ~all(univariate_union(:) == 0)
        univariate_corr_result = corr(univariate_union_vec, univariate_vec, 'Type', 'Spearman'); 
        single_max_corr = max(Univariate_corr); 
    end

    if single_max_corr >= univariate_corr_result
        univariate_model_maxCorr{subject_num} = univariate_SingleMaxMdoel.*single_max_corr;
    elseif single_max_corr < univariate_corr_result
        univariate_model_maxCorr{subject_num} = univariate_union.*univariate_corr_result;
    end

    % Multivariate_corr
    single_max_corr=0;
    multivariate_union = zeros(num_conditions,num_conditions); 
    for i = 1:num_conditions
        if Multivariate_corr(i) >= multivariate_threshold
            multivariate_union = multivariate_union|rdm{i}; 
        end
        if Multivariate_corr(i) == max(Multivariate_corr)
            multivariate_SingleMaxMdoel = rdm{i}; 
        end
    end
    multivariate_union_vec = multivariate_union(triu(true(rdm_size), 1));
    if ~all(multivariate_union(:) == 0)
        multivariate_corr_result = corr(multivariate_union_vec, multivariate_vec, 'Type', 'Spearman');
        single_max_corr = max(Multivariate_corr); 
    end

    if single_max_corr >= multivariate_corr_result
        multivariate_model_maxCorr{subject_num} = multivariate_SingleMaxMdoel.*single_max_corr;
    elseif single_max_corr < multivariate_corr_result
        multivariate_model_maxCorr{subject_num} = multivariate_union.*multivariate_corr_result;
    end

end


fig_width = 11; fig_height = 4; 
figure; set(gcf, 'Units', 'inches', 'Position', [1, 1, fig_width, fig_height], 'Color', 'w');

result = zeros(6, 6);
for i = 1:numel(univariate_model_maxCorr)
    result = result + univariate_model_maxCorr{i};
end
Final_mean_univariate_model_maxCorr = result / numel(univariate_model_maxCorr);
subplot(1, 2, 1);
imagesc(Final_mean_univariate_model_maxCorr);
title('Final model for univariate rdm');
colormap(gca,jet); colorbar;caxis([0 0.4]);set(gca, 'XTickLabel', [], 'YTickLabel', [], 'FontName', 'Book Antiqua'); 

result = zeros(6, 6);
for i = 1:numel(multivariate_model_maxCorr)
    result = result + multivariate_model_maxCorr{i};
end
Final_mean_multivariate_model_maxCorr = result / numel(multivariate_model_maxCorr);
subplot(1, 2, 2);
imagesc(Final_mean_multivariate_model_maxCorr);
title('Final model for multivariate rdm');
colormap(gca,jet); colorbar;caxis([0 0.4]);set(gca, 'XTickLabel', [], 'YTickLabel', [], 'FontName', 'Book Antiqua'); 
saveas(gcf, fullfile(output_path, sprintf('FinalModel.png')));
