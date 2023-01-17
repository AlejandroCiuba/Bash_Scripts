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
```
# Things to download
essentials=("numpy" "pandas" "matplotlib" "seaborn" "jupyter" "PyPDF2" "requests")

machine_learning=("sklearn" "transformers" "datasets" "evaluate" "torchmetrics")

natural_language_processing=("nltk" "bs4" "jiwer")

wave_files=("wave" "PyDub")
```