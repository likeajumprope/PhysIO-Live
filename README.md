# PhysIO-Live
Here is where the futire PhysIO Matlab Livescript demo lives.

## How to work with this repository
1. Clone this repository.

2. The .mlx files can be downloaded and run in the MATLAB once the cloned repsitory is added to the Matlab path.

Currently we have:
   - Overview-toobox.mlx: will give information about the toolbox (purpsoe, licnse, acknowledgements etc.)
   - Physio-intro.xml: is the beginning of an introduction to physiological noise correctton. Eventually, all code to run the toolbox on the example data will be converted to live scripts.

## Run amended toolbox files on example data (Beta)
2. Install [PhysIO](https://github.com/translationalneuromodeling/tapas/tree/master/PhysIO). You might have to install [SPM](https://www.fil.ion.ucl.ac.uk/spm/).
   
3. Get the data. 
   For this live demo, we use he [Forrest Gump](https://openneuro.org/datasets/ds000113/versions/1.3.0) data set. Here we use the audio perception sub data set (see also [here](https://www.studyforrest.org/data.html))
   The following files need to be downlaoded into the sub-01 folder:
   - sub-01_ses-auditoryperception_task-auditoryperception_run-01_bold.nii.gz
   - sub-01_ses-forrestgump_T1w.nii.gz
   -sub-01_ses-auditoryperception_func_sub-01_ses-auditoryperception_task-auditoryperception_run-01_physio.tsv
   - recording-cardresp_physio.json
 
4. Adapt the environment variables  in main.m
