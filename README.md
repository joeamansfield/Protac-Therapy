## PROTACTherapy

Here are instructions for using this workflow:
1. This workflow utilizes conda
    1. Download a miniconda from https://docs.conda.io/en/latest/miniconda.html (probably use curl)
    2. ```bash Miniconda3-latest-Linux-x86_64.sh``` (or if it downloads a different file then just replace that file name)
    3. Restart terminal and you should see a (base) in front of your typical bash prompt
    4. Proceed to ProcessedData/packageManaging/instructions.txt to get current environment
2. This workflow utilizes slurm (if you aren't in an environment that uses slurm or if you don't know if you are or not, just use ```./RunAll.bash``` instead of the lines below)
    1. Submit a job using ```sbatch RunAll.bash``` (or other bash script)
    2. Check on job with ```sacct``` or looking and automatically generated slurm output file
3. This workflow uses snakemake. If you used the step above, you can skip this step. It's mostly for running parts of the workflow instead of the whole thing
    1. Make sure you've followed the conda steps so you have access to snakemake
    2. The ```snakemake -p -r --cores 1``` command will utilize the all rule which should run everything that needs to be updated
    3. If you're trying to just look at a specific file, ```snakemake <target file> -p -r --cores 1``` will just get that file
