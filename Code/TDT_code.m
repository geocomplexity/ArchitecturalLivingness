clc;
clear;


PicLivingnessScore = score_data.PicLivingnessScore;

sbjID = {'Sbjxx'};

all_subjects_data = struct();

for sub_idx = 1:length(sbjID)
    current_subject = sbjID{sub_idx};
    fprintf('Sbj: %s\n', current_subject);
    
    mapping_file = sprintf('.\%s_Task_999_TDT01_mapping.mat', current_subject);
    if ~exist(mapping_file, 'file')
        fprintf('Warm: %s  mapping file missing\n', current_subject);
        continue;
    end
    load(mapping_file, 'trial_info');
    
    beta_dir = sprintf('.\Results_TDT_1stlevel01_NoSmooth', current_subject);
    
    file_names = cell(height(trial_info), 1);
    for i = 1:height(trial_info)
        file_names{i} = fullfile(beta_dir, sprintf('beta_%04d.nii', i));
    end
    
    %%
    labels = zeros(height(trial_info), 1);
    image_names = cell(height(trial_info), 1);
    
    for i = 1:height(trial_info)
        current_image = trial_info.image_name{i};
        image_names{i} = current_image;
        
        score_idx = find(strcmp(PicLivingnessScore.ImageName, current_image));
        if ~isempty(score_idx)
            labels(i) = PicLivingnessScore.ComprehensiveScore(score_idx);
        else
            labels(i) = NaN;
        end
    end
    
    valid_indices = ~isnan(labels);
    file_names = file_names(valid_indices);
    labels = labels(valid_indices);
    image_names = image_names(valid_indices);
    
    all_subjects_data(sub_idx).subject_id = current_subject;
    all_subjects_data(sub_idx).file_names = file_names;
    all_subjects_data(sub_idx).labels = labels;
    all_subjects_data(sub_idx).image_names = image_names;
    all_subjects_data(sub_idx).beta_dir = beta_dir;
    all_subjects_data(sub_idx).is_valid = true;
    
end

valid_subjects = [all_subjects_data.is_valid];
all_subjects_data = all_subjects_data(valid_subjects);
sbjID = sbjID(valid_subjects);

Results_All = cell(length(sbjID), 3);

for test_sub_idx = 1:length(sbjID)
    
    clear cfg
    cfg = decoding_defaults;
    cfg.analysis = 'searchlight';

    cfg.results.dir = fullfile('.\Results_TDT_1stlevel01_SbjLevel08', ...
        sprintf('TestSubject_%s', sbjID{test_sub_idx}));
    
    if ~exist(cfg.results.dir, 'dir')
        mkdir(cfg.results.dir);
    end
    
    train_files = [];
    train_labels = [];
    test_files = all_subjects_data(test_sub_idx).file_names;
    test_labels = all_subjects_data(test_sub_idx).labels;
    
    for train_sub_idx = 1:length(sbjID)
        if train_sub_idx == test_sub_idx
            continue;
        end
        subject_data = all_subjects_data(train_sub_idx);
        train_files = [train_files; subject_data.file_names];
        train_labels = [train_labels; subject_data.labels];
    end
    
    cfg.files.name = [train_files; test_files];
    cfg.files.label = [train_labels; test_labels];
    
    cfg.files.chunk = [ones(length(train_files), 1); 2*ones(length(test_files), 1)];
    
    n_train = length(train_files);
    n_test = length(test_files);
    n_total = n_train + n_test;
    
    cfg.design.train = zeros(n_total, 1);
    cfg.design.test = zeros(n_total, 1);
    
    cfg.design.train(1:n_train, 1) = 1; 
    cfg.design.test(n_train+1:end, 1) = 1;
    
    cfg.design.function = @decoding_describe_data;
    cfg.design.label = cfg.files.label;
    cfg.design.fold = 1;
    cfg.design.n_fold = 1;
    
    cfg.design_make = 0;
    
    mask_file = fullfile('.\Results_TDT_1stlevel01_SbjLevel05', 'group_common_mask.nii');
    cfg.files.mask = mask_file;
    
    cfg.design = make_design_cv(cfg);
    
    n_train = length(train_files);
    n_test = length(test_files);
    n_total = n_train + n_test;
    
    cfg.design.train = zeros(n_total, 1);
    cfg.design.test = zeros(n_total, 1);
    cfg.design.label = cfg.files.label;
    
    cfg.design.train(1:n_train, 1) = 1;  
    cfg.design.test(n_train+1:end, 1) = 1;  
    
    cfg.design.function = @decoding_describe_data;
    
    cfg.searchlight.unit = 'mm';
    cfg.searchlight.radius = 12;
    cfg.searchlight.spherical = 1;
    cfg.searchlight.spacing = 1;
    
    cfg.decoding.method = 'regression';
    cfg.decoding.software = 'liblinear';
    cfg.decoding.train.regression.model_parameters = '-s 11 -c 1 -q';
    
    cfg.results.output = {'corr', 'zcorr'};
    cfg.results.overwrite = 1;
    cfg.scale.check_datatrans_ok = true;  

    cfg.scale.method = 'min0max1';
    cfg.scale.estimation = 'across';
    
    cfg.verbose = 1;
    cfg.plot_selected_voxels = 0;
    cfg.plot_design = 0;
    
    try
        results = decoding(cfg);
        
        if isfield(results, 'corr') && ~isempty(results.corr)
            test_correlation = results.corr.output;
        else
            test_correlation = NaN;
        end
        
        if isfield(results, 'zcorr') && ~isempty(results.zcorr)
            test_zcorrelation = results.zcorr.output;
        else
            test_zcorrelation = NaN;
        end
        
        Results_All(test_sub_idx, :) = {sbjID{test_sub_idx}, mean(test_correlation), mean(test_zcorrelation)};
        
    catch ME
        Results_All(test_sub_idx, :) = {sbjID{test_sub_idx}, NaN, NaN};
        continue;
    end
end

