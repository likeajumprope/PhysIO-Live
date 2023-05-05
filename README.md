# PhysIO-Live

 This repository contains a Live-Script demo of the [TAPAS PhysIO toolbox](https://www.tnu.ethz.ch/en/software/tapas/documentations/physio-toolbox) for physiological (cardiac and respiratory) noise modelling and correction of fmri data. 

![Physiological noise](/misc/Physio_example.png)

</br>

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
</br>

#### 2. Get the data. 
   For this live demo, we use the [Forrest Gump](https://openneuro.org/datasets/ds000113/versions/1.3.0) data set. Here we use the audio perception sub data set (see also [here](https://www.studyforrest.org/data.html))
   The following files need to be downloaded into the results/sub-01 folder:
   - sub-01/ses-audiotoryperception/func/sub-01_ses-auditoryperception_task-auditoryperception_run-01_bold.nii.gz (unpack)
   - sub-01/ses-forestgump/anat/sub-01_ses-forrestgump_T1w.nii.gz (unpack)
   - sub-01_ses-auditoryperception_func_sub-01_ses-auditoryperception_task-auditoryperception_run-01_physio.tsv
   - recording-cardresp_physio.json
   
To make the download easier, you can also just run the file `get_files.sh` in the `misc` folder in the terminal:

```
misc my-username$ ./get_files.sh
```

Your folder structure should look like the following:

<p align="center">
  <img width="500"  src="/misc/Folder_structure.png">
</p>
</br>


#### 3. Adapt the environment variables in main.mlx (matlab version > 2019a) or in main.m
The two files main.mlx and main.m are identical and ensure the usability of this tutorial for matlab versions that do not support .mlx files.

</br>

## Debugging - common issues

- Make sure every step is run out of the results/>subjectID<  folder!
- Make sure tapas, spm/matlabbatch are on the path. Any "cannot find/open file" error is usually due to the relevant folder not being  on the path.
- Some operations take some time. A wheel of doom when hovering over the batch editor indicates that the process is still running!
- When cloning the repository, pulling the wikidocs of TAPAS Physio might fail. Don't worry about that, the demo is fully functional!

</br>

## Literature

Please cite this software (PhysIO) as follows:

Kasper, L., Bollmann, S., Diaconescu, A.O., Hutton, C., Heinzle, J., 
Iglesias, S., Hauser, T.U., Sebold, M., Manjaly, Z.-M., Pruessmann, K.P., 
Stephan, K.E., 2017. [The PhysIO Toolbox for Modeling Physiological Noise 
in fMRI Data.](https://pubmed.ncbi.nlm.nih.gov/27832957/)
Journal of Neuroscience Methods 276, 56-72. 
doi:10.1016/j.jneumeth.2016.10.019


Please also cite the parent software collection TAPAS:

Fraessle, S., Aponte, E.A., Bollmann, S., Brodersen, K.H., Do, C.T., Harrison, O.K., 
Harrison, S.J., Heinzle, J., Iglesias, S., Kasper, L., Lomakina, E.I., Mathys, C., 
Mueller-Schrader, M., Pereira, I., Petzschner, F.H., Raman, S., Schoebi, D., 
Toussaint, B., Weber, L.A., Yao, Y., Stephan, K.E., 2021. 
[TAPAS: an open-source software package for Translational Neuromodeling and Computational Psychiatry.](https://doi.org/10.3389/fpsyt.2021.680811) 
Frontiers in Psychiatry 12, 857. 
https://doi.org/10.3389/fpsyt.2021.680811


If you use respiratory volume per time (RVT) regressors or preprocessing of respiratory traces, please also cite:

Harrison, S.J., Bianchi, S., Heinzle, J., Stephan, K.E., Iglesias, S., Kasper L., 2021.
[A Hilbert-based method for processing respiratory timeseries.](https://doi.org/10.1016/j.neuroimage.2021.117787)
NeuroImage, 117787. https://doi.org/10.1016/j.neuroimage.2021.117787




(C) 2023 Johanna Bayer, supervised by Lars Kasper, supported by Mathworks Inc.
