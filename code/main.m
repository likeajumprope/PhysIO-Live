% Script physio_live_main
% Main preproc/analysis script lernit to create PhysIO regressors and
% assess them via a nuisance-only GLM
%
%  physio_live_main
%
%
%   See also
 
% Author:   Lars Kasper, Johanna Bayer
% Created:  2022-12-13
% Copyright (C) 2022
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setup paths - #MOD# Modify to your own environment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataID = 'forest' % resting state does not work

switch dataID
case 'forest' 
    subjectId = 'sub-01'
    nSlices = 36; % nSlicesTotal/MB factor
    TR = 2.0; % seconds
    nVolumes = 153;
case 'resting_state'
    subjectId = 'sub-01/ses-1';
    nSlices = 70; % nSlicesTotal/MB factor
    TR = 3.0; % seconds
    nVolumes = 300;
end



 % if true, only the SPM batch jobs are loaded, but you have to run them manually in the batch editor (play button)
isInteractive = true;
hasStruct = true; % if false, uses (bias-corrected) mean of fmri.nii for visualizations
doSmooth = true;


pathProject     = '/Users/jobayer/Documents/MATLAB/PhysIO-Live';
pathCode        = fullfile(pathProject, 'code');
pathResults     = fullfile(pathProject, 'results');
pathSubject     = fullfile(pathProject,'data', dataID, subjectId);



addpath(genpath(pathCode));
pathNow = pwd;


cd(pathSubject);

% folder structure created with in results folder of subject to hold
% different preprocessed data
mkdir('glm')
mkdir('nifti')
mkdir('glm_s3')
mkdir('physio_out')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setup SPM Batch editor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% spm_jobman('initcfg')
spm fmri

if isInteractive
    jobMode = 'interactive';
else
    jobMode = 'run';
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Spatial Preproc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if hasStruct
    fileJobPreproc = 'preproc_minimal_spm_job.m';
else
    fileJobPreproc = 'preproc_minimal_no_struct_spm_job.m';
end

% loads matlabbatch and adapts subject-specific data
clear matlabbatch
run(fileJobPreproc)
matlabbatch{1}.spm.spatial.realign.estwrite.data{1} = ...
    cellstr(spm_select('ExtFPList', 'nifti', '^fmri.*', 1:nVolumes));

spm_jobman(jobMode, matlabbatch)

if isInteractive, input('Press Enter to continue'); end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Physio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% loads matlabbatch and adapts subject-specific data
clear matlabbatch

%fileJobPhysio = 'physio_spm_job.m';
fileJobPhysio = 'physio_batch_job.m';
clear matlabbatch
run(fileJobPhysio)
matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.Nscans = nVolumes;
matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.Nslices = nSlices;
matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.TR = TR;
matlabbatch{1}.spm.tools.physio.scan_timing.sqpar.onset_slice = nSlices/2;

switch subjectId
    case 'sub-01'
        % defaults OK in file
    case 'sub-02'
        matlabbatch{1}.spm.tools.physio.log_files.align_scan = 'first';
        % only 150 volumes, we don't want to reduce degrees of freedom too much
        matlabbatch{1}.spm.tools.physio.model.movement.yes.censoring_threshold = 2;

        % too noisy cardiac data, has to be bandpass-filtered (default
        % values)
        matlabbatch{1}.spm.tools.physio.preproc.cardiac.filter = rmfield(...
            matlabbatch{1}.spm.tools.physio.preproc.cardiac.filter, 'no');
        matlabbatch{1}.spm.tools.physio.preproc.cardiac.filter.yes.type = 'cheby2';
        matlabbatch{1}.spm.tools.physio.preproc.cardiac.filter.yes.passband = [0.3 9];
        matlabbatch{1}.spm.tools.physio.preproc.cardiac.filter.yes.stopband = [];
end

spm_jobman(jobMode, matlabbatch)

if isInteractive, input('Press Enter to continue'); end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GLM with or w/o smoothing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if doSmooth
    fileJobGlm = 'glm_s3_spm_smooth_job.m';
else
    fileJobGlm = 'glm_spm_job.m'; % does not work yet
end
clear matlabbatch
run(fileJobGlm)

if doSmooth
    matlabbatch{1}.spm.stats.fmri_spec.sess.scans = ...
        cellstr(spm_select('ExtFPList', 'nifti', '^srfmri.*', 1:nVolumes));
else
    matlabbatch{1}.spm.stats.fmri_spec.sess.scans = ...
        cellstr(spm_select('ExtFPList', 'nifti', '^rfmri.*', 1:nVolumes));
end

matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = nSlices;
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = TR;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = nSlices/2;

spm_jobman(jobMode, matlabbatch)

if isInteractive, input('Press Enter to continue'); end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Visualize PhysIO contrasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% automatic contrast creation using PhysIO
visualize_physio