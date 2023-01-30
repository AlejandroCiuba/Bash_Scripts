#!/usr/bin/env bash

# Things to download
essentials=("numpy" "pandas" "matplotlib" "seaborn" "jupyter" "PyPDF2" "requests" "pytest" "cython")

machine_learning=("sklearn" "transformers" "datasets" "evaluate" "torchmetrics" "tqdm")

natural_language_processing=("nltk" "bs4" "jiwer" "gensim")

wave_files=("wave" "PyDub" "simpleaudio")

display_package_sets() {
	echo ""
	echo "==============================================================="
	echo "                      Python Package Sets                      "
	echo "==============================================================="
	echo "essentials: ${essentials[@]}"
	echo "machine learning: ${machine_learning[@]}"
	echo "natural-language processing: ${natural_language_processing[@]}"
	echo "wave file: ${wave_files[@]}"
	echo "==============================================================="
	echo ""
}

download() {
	arr=($@) # Gets all variables as array

	for package in ${arr[@]}
	do
		python -m pip install ${package}
	done
}

# Program start
echo "Standard Python Installations"

option="-1"
while [ ${option} == "-1" ]
do
	echo "Please select which libraries to install:"
	echo " all groups:			1"
	echo " essentials:			2"
	echo " machine learning:		3"
	echo " natual-language processing:	4"
	echo " wave files:			5"
	echo "Type \"list\" to view details for each package and \"exit\" to quit."
	
	# Get user input
	read option
	
	if [ ${option} == "list" ]
	then
		display_package_sets
		option="-1"
		
	elif [ ${option} == "exit" ]
	then
		exit
		
	elif (( ${option} >= 1 && ${option} <= 5 ))
	then
		
		if (( ${option} == 1 ))
		then
			echo "Downloading ALL package sets:"
		else
			echo "Downloading option ${option}"
		fi
		
		read -p "Are you sure? [y/n]: " opt
		
		if [ ${opt} == "y" ] || [ ${opt} == "Y" ]
		then
			if (( ${option} == 2 || ${option} == 1 )); then
				download ${essentials[@]}
			fi
			
			if (( ${option} == 3 || ${option} == 1 )); then
				download ${machine_learning[@]}
			fi
			
			if (( ${option} == 4 || ${option} == 1 )); then 
				download ${natural_language_processing[@]}
			fi
			
			if ((${option} == 5 || ${option} == 1)); then
				download ${wave_files[@]}
			fi
			exit

		elif [ ${opt} == "n" ] || [ ${opt} == "N" ]
		then
			echo "TERMINATING..."
			exit
		
		else
			echo "INVALID OPTION, RETURNING TO MAIN MENU"
			option="-1"
		fi
		
	else
		echo "INVALID OPTION, PLEASE TRY AGAIN!"
		option="-1"
	fi
done
