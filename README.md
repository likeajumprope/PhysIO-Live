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
   For this live demo, we are trialling two data sets:
   - [A high resolution 7-Tesla resting-state fMRI test-retest dataset with cognitive and physiological measures](https://openneuro.org/datasets/ds001168/versions/1.0.1):  This data set looks nice from the outside, but the BIDS format that they offer is not really BIDS, thus needs some adjustments (more to follow)
   - The [Forrest Gump](https://openneuro.org/datasets/ds000113/versions/1.3.0) data set. Here we use the audio perception sub data set (see also [here](https://www.studyforrest.org/data.html))
4. adapt the file paths in code/main.m, functions/preproc_minimal_no_struct_spm_job.m, functions/physio_batch_job.m and functions/glm_s3_spm_smooth_job.m
5 run main (beta)


   
