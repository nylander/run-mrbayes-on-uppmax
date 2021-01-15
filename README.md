# Run Parallel MrBayes on UPPMAX

- Last modified: fre jan 15, 2021  02:24
- Sign: JN

## Description

Notes on how to run MrBayes
([https://github.com/NBISweden/MrBayes](https://github.com/NBISweden/MrBayes))
on the compute cluster available on UPPMAX
([https://www.uppmax.uu.se/](https://www.uppmax.uu.se/)).

To access UPPMAX compute resources, see this web page:
[https://www.uppmax.uu.se/support/getting-started/](https://www.uppmax.uu.se/support/getting-started/)

## Steps

1. [Prepare data file on local computer](#1-prepare-data-file-on-local-computer)
2. [Prepare command file on local computer](#2-prepare-command-file-on-local-computer)
3. [Prepare SLURM script on local computer](#3-prepare-slurm-script-on-local-computer)
4. [Transfer files to UPPMAX](#4-transfer-files-to-uppmax)
5. [Connect to UPPMAX](#5-connect-to-uppmax)
6. [Submit job](#6-submit-job)
7. [Check progress](#7-check-progress)
8. [Logout](#8-logout)
9. [Login later and check progress](#9-login-later-and-check-progress)
10. [Transfer files to local computer](#10-transfer-files-to-local-computer)

## Details

### 1. Prepare data file on local computer

This file will contain the data (multiple sequence alignment).
Simple text and written in the nexus format.

Example file: [data.nex](data.nex)

### 2. Prepare command file on local computer

This file will contain the commands for MrBayes. It will also instruct
MrBayes to read the file `data.nex`.

Example file: [mb.nex](mb.nex)

### 3. Prepare SLURM script on local computer

This file will be submitted to the queue system (slurm) at UPPMAX.
The file will start MrBayes, with instructions from file `mb.nex`.
Important is to specify

- Compute account number
- Maximum time for run
- Number of nodes to use (need to match the number of chains in `mb.nex`)

Example file: [mb.slurm.sh](mb.slurm.sh)

### 4. Transfer files to UPPMAX

- Prepare (compress) files for transfer

        [username@mycomputer]$ tar cvfz files.tgz data.nex mb.nex mb.slurm.sh

- Transfer

        [username@mycomputer]$ scp files.tgz rackham.uppmax.uu.se:/path/to/folder/.

### 5. Connect to UPPMAX

- Connect

        [username@mycomputer]$ ssh username@rackham.uppmax.uu.se
        [username@rackham]$ cd /path/to/folder/

- Uncompress

        [username@rackham]$ tar xvzf files.tgz

### 6. Submit job

    [username@rackham]$ sbatch mb.slurm.sh

### 7. Check progress

Here we can both check the status of our job in the queue:

    [username@rackham]$ jobinfo -u $USER

We can also stop the job if necessary

    [username@rackham]$ scancel -i -u $USER

And if the job is running, we can monitor progress by inspecting log files:

(see e.g., <https://github.com/nylander/plotMCMCoutput>)

### 8. Logout

    [username@rackham]$ exit

### 9. Login later and check progress

(see e.g., <https://github.com/nylander/plotMCMCoutput>)

### 10. Transfer files to local computer

Gather files with `tar` and transfer with `scp`.

