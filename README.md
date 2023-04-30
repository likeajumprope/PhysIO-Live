# PhysIO-Live

 This repository contains a Live-Script demo of the [TAPAS PhysIO toolbox](https://www.fil.ion.ucl.ac.uk/spm/) for physiological (cardiac and respiratory) noise modelling and correction of fmri data. 

![Physiological noise](https://github.com/likeajumprope/PhysIO-Live/blob/main/img/Physio_example.png)

## How to work with this repository

### There are three ways to work with this repository:


- Run online [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=likeajumprope/PhysIO-Live&file=main.mlx)

- Run locally on your machine

- View on [![View PhysIO-Live on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://au.mathworks.com/matlabcentral/fileexchange/128779-physio-live)

### To clone this repository and run it locally on your machine:

#### 1. Clone this repository *recursively*. This way, all dependent libraries, e.g., [SPM](https://www.fil.ion.ucl.ac.uk/spm/) and [TAPAS PhysIO](https://www.tnu.ethz.ch/en/software/tapas/documentations/physio-toolbox) are automatically installed as well.
    
 ```
 git clone --recursive https://github.com/likeajumprope/PhysIO-Live
 ```
   - *Note:* Check that the `libs` subfolder is not empty, and e.g,. `libs/tapas` contains files.


#### 2. Get the data. 
   For this live demo, we use the [Forrest Gump](https://openneuro.org/datasets/ds000113/versions/1.3.0) data set. Here we use the audio perception sub data set (see also [here](https://www.studyforrest.org/data.html))
   The following files need to be downloaded into the sub-01 folder:
   - sub-01/ses-audiotoryperception/func/sub-01_ses-auditoryperception_task-auditoryperception_run-01_bold.nii.gz (unpack)
   - sub-01/ses-forestgump/anat/sub-01_ses-forrestgump_T1w.nii.gz (unpack)
   - sub-01_ses-auditoryperception_func_sub-01_ses-auditoryperception_task-auditoryperception_run-01_physio.tsv
   - recording-cardresp_physio.json


#### 3. Adapt the environment variables in main.mlx (matlab version > 2019a) or in main.m
The two files main.mlx and main.m are identical and ensure the usability of this tutorial for matlab versions that do not support .mlx files.

## Debugging - common issues

- Make sure every step is run out of the results/>subjectID<  folder!
- Make sure tapas, spm/matlabbatch are on the path. Any "cannot find/open file" error is usually due to the relevant folder not being  on the path.
- Some operations take some time. A wheel of doom when hovering over the batch editor indicates that the process is still running!

(C) 2023 Johanna Bayer, supervised by Lars Kasper
