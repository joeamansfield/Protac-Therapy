## PROTACTherapy

Here are instructions for using this workflow:
1. This workflow utilizes conda
    1. Download a miniconda from https://docs.conda.io/en/latest/miniconda.html (probably use curl)
    2. ```bash Miniconda3-latest-Linux-x86_64.sh```
    3. Restart terminal and you should see a (base) in front of your typical bash prompt
    4. Proceed to ProcessedData/packageManaging/instructions.txt to get current environment
2. This workflow utilizes slurm (if you aren't in a linux environment, just copy commands from inside bash script and run them in your terminal)
    1. Submit a job using ```sbatch RunAll.bash``` (or other bash script)
    2. Check on job with ```sacct``` or looking and automatically generated slurm output file
3. This workflow uses snakemake
    1. Make sure you've followed the conda steps so you have access to snakemake
    2. The ```snakemake -p -r --cores 1``` command will utilize the all rule which should run everything that needs to be updated
    3. If you're trying to just look at a specific file, ```snakemake <target file> -p -r --cores 1``` will just get that file
4. The raw data files are too large to include in this repo, so I will include links where to download them and what they were named (some of them need to be unzipped with gunzip if they're .gz or tar if they're .tar.gz):
    1. [E3 Substrate List](http://ubibrowser.bio-it.cn/ubibrowser_v3/Public/download/E3/H.sapiens.result.txt) > OriginalE3Substrate.txt
    2. [Protac List](http://cadd.zju.edu.cn/protacdb/statics/binaryDownload/csv/protac/protac.csv) > Protac.csv
    3. [Uniprot to HGNC Mapping](https://ftp.uniprot.org/pub/databases/uniprot/knowledgebase/idmapping/by_organism/HUMAN_9606_idmapping.dat.gz) > UniprotMapping.txt
