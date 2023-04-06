## PROTACTherapy

Here are instructions for using this workflow:
1. This workflow utilizes conda
    1. Download a miniconda from https://docs.conda.io/en/latest/miniconda.html (probably use curl or wget)
    2. ```bash Miniconda3-latest-Linux-x86_64.sh``` (or if it downloads a different file then just replace that file name)
    3. Restart terminal and you should see a (base) in front of your typical bash prompt
    4. Run ```bash InitialSetup.sh``` and it will create the environments you need
2. This workflow utilizes slurm (if you aren't in an environment that uses slurm or if you don't know if you are or not, just use ```bash RunAll.sh``` instead of the lines below)
    1. Submit a job using ```sbatch RunAll.sh``` (or other bash script)
    2. Check on job with ```sacct``` or looking at the automatically generated slurm output file
    3. If you are using ```sbatch```, your system may not allow internet access on compute nodes, so you will want to run ```bash DownloadAll.sh``` before submitting the RunAll job.
    4. If you have a machine with many cores, you can increase the number of cores on the job by editing lines 4 and 20 of RunAll.sh to include more than just one core.
3. This workflow uses snakemake. If you used the step above, you can skip this step. It's mostly for running parts of the workflow instead of the whole thing
    1. Make sure you've followed the conda steps so you have access to snakemake
    2. The ```snakemake -p -r --cores 1``` command will utilize the all rule which should run everything that needs to be updated
    3. If you're trying to just look at a specific file, ```snakemake <target file> -p -r --cores 1``` will just get that file
