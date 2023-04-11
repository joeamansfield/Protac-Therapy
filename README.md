## PROTACTherapy

Here are instructions for using this workflow:  
Disclaimer: This currently only runs on Linux systems. We haven't been able to fix it to work on Mac or Windows yet.  
For a complete list of our tables and figures that will be included in the paper, see Code/RemoveOutputs.sh on every line starting with rm. Our Figure 1 is not included in this because it is just a workflow diagram created using Google draw.  
1. This workflow utilizes conda
    1. Download a miniconda from https://docs.conda.io/en/latest/miniconda.html (probably use curl or wget)
    2. ```bash Miniconda3-latest-Linux-x86_64.sh``` (or if it downloads a different file then just replace that file name)
    3. Restart terminal and you should see a (base) in front of your typical bash prompt
    4. Run ```bash InitialSetup.sh``` and it will create the environments you need (you must be in the Code directory when you run this command). (This step will likely take a really long time)
    5. If you're getting that conda is not found as a command you might have to go into the Snakefile and replace every instance of .bash_profile with .bashrc or vice versa depending on what you have in your system.
2. This workflow utilizes slurm. If your compute nodes don't have internet access, if you aren't in an environment that uses slurm, or if you don't know if you are or not, just use ```bash RunAll.sh``` instead of the lines below. If you don't know whether or not your compute nodes use internet access, try running it, and it should fail during the cptac download or a curl or wget.
    1. Make sure you are in the Code directory (```cd Code```)
    2. Submit a job using ```sbatch RunAll.sh``` (or other bash script. See step three)
    3. Check on job with ```sacct``` or looking at the automatically generated slurm output file
    4. If it simply says nothing to be done, all the output files are already created. If you just want to re-create the final outputs from the intermediate files, you can run ```bash RemoveOutputs.sh``` to get rid of all the figures and final tables. If you want to re-do the whole thing from the beginning, see step three. However, if you clone the repo for the first time, it should just re-create everything because of the timestamps on the files.
    5. If you have a machine with many cores, you can increase the number of cores on the job by editing lines 4 and 20 of RunAll.sh to include more than just one core.
3. This workflow is split into multiple chunks. The command in step two will run all of those chunks, but if you want to run a smaller chunk, there other scripts for this. Because they are intermediary, you will need to run ```bash RemoveAllIntermediates.sh``` to get rid of intermediary files. (There are some removes in this that are commented out. These steps will take collectively hours depending on your system, so you can uncomment them if you want to redo those larger steps as well.)
    1. Make sure you are in the Code directory (```cd Code```)
    2. ```bash DownloadAll.sh``` will re-download the raw data files.
    3. ```bash AllVolcanos.sh``` will re-create all parts of the workflow up to the volcano plots (Figure 2).
    4. ```bash CancerTiers.sh``` will re-create the cancer tiered table (Table 1).
    5. ```bash ProteinModels.sh``` will re-create the protein models (Figures 3 and on) (not sure how many we will end up including yet).
4. This workflow uses snakemake. If you used the step above, you can skip this step. It's mostly for running parts of the workflow instead of the whole thing
    1. Make sure you've followed the conda steps so you have access to snakemake
    2. The ```snakemake -p -r --cores 1``` command will utilize the all rule which should run everything that needs to be updated
    3. If you're trying to just look at a specific file, ```snakemake <target file> -p -r --cores 1``` will just get that file
