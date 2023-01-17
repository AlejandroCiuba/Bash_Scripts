# Bash_Scripts
***
[Alejandro Ciuba](https://alejandrociuba.github.io), alc307@pitt.edu
***
## Summary
This repository contains a collection of various `bash` and `shell` scripts I've written that i think could be useful to other people. There will be general instructions on how to use them below.
***
## `python-installs.sh`
This script is for mass-installing useful Python packages (ideally in an Anaconda/Miniconda environment). To do this, download the file and follow these instructions:

1. type `sudo bash <FILEPATH>/python-installs.sh`
2. Select which groups of packages you wish to install

To change or add package groups, go into the `python-installs.sh` file itself and change the following:

```bash
# Things to download
essentials=("numpy" "pandas" "matplotlib" "seaborn" "jupyter" "PyPDF2" "requests")

machine_learning=("sklearn" "transformers" "datasets" "evaluate" "torchmetrics")

natural_language_processing=("nltk" "bs4" "jiwer")

wave_files=("wave" "PyDub")
```

To contain more packages, if you wish to add more groups:

1. Copy one of the previously shown lines
2. Update `display_package_set()` accordingly
3. Change add the following line just before `exit` at approximately line 89:
```bash
### NEW LINE FOR ADDITIONAL PACKAGE GROUPS
if ((${option} == <NEW_NUMBER> || ${option} == 1)); then
    download ${<PACKAGE_NAME>[@]}
fi
```
***
## `git_checker.sh`
This script is to make mass-checking git repositories easier. With the alias command (I usually use `check`), you can:
- See which repositories need to be committed
- Automatically commit all non-committed repositories with the same message (`check -m "<message"`)
- Automatically push all non-committed repositories to their upstreams (`check -pm "<message>"`)
- Automatically pull from all committed repositories' upstreams to update them (`check -b`)

The script takes a given list of repositories to check with `check -l "<repository_list>"` as a `.txt` file.

To use, please download the script and follow these instructions:

1. Create a `repository_list.txt` file to store all the repositories you want to check:
```
repo1 
repo2
...

```
**NOTE:** Leave a blank space at the end of the file so the script can correctly parse it. Otherwise, the last repository will not be read into the check loop. Also **DO NOT** include `home/<USERNAME>/`, start immediately after that.

2. Create a `.bash_aliases` file in your home directory with the following:
```text
alias check="<FILEPATH>/git_checker.sh -l '<FILEPATH>/repository_list.txt'"
```
