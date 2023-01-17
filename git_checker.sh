### Program to check which git repos in a list are pushed
### Alejandro Ciuba, 01/16/2022
#!/usr/bin/env bash

# Repositories to check, can be set here manually or given as command line argument
repo_list="NA"

# Flags: dnc = display non-committed, rp = push, bp = pull, moc = message on commit
dnc=0
rp=0
bp=0
moc="default"

# Phrase to detect if git repo is up-to-date
re="nothing to commit, working tree clean"

# Help function
helpFunction() {
    echo ""
    echo "Usage: $0 -hnbpm \"<message>\" -l \"<repository list>\""
    echo -e "\t-h Help, displays this text"
    echo -e "\t-n Only show non-committed repositories' messages\n"

    echo -e "\t-b Pull repositories, will not pull if branch not committed"
    echo -e "\t   Equivalent to 'git pull'\n"

    echo -e "\t-p Push all non-committed repositories to GitHub, usage: -pm \"<message>\""
    echo -e "\t   Equivalent to 'git commit -am \"<message>\"' then 'git push'\n"

    echo -e "\t-m Automatically commit all non-committed repositories"
    echo -e "\t   Equivalent to 'git commit -am \"<message>\"'"

    exit 1

}

while getopts ":hnbpm:l:" opt
do
    case ${opt} in
        h ) helpFunction ;;
        n ) dnc=1 ;;
        b ) bp=1 ;;
        p ) rp=1 ;;
        m ) moc="${OPTARG}" ;;
        l ) # Check that filepath was correctly given
            repo_list=${OPTARG}

            if [[ ! -e ${repo_list} ]]
            then
                echo "Repository list ${repo_list} does not exist, exiting with error code: -1"
                exit -1
            fi ;;

        ? ) echo "No command given. Please use -h for help."
            exit ;;

    esac
done

# Check that user provided repository list
if [[ ${repo_list} = "NA" ]]
then
    echo "No repository list given, exiting..."
    exit 1

fi

echo "================================================="
echo "              Checking Repositories"

# Check each repositories status
while read repo
do
    # This is genuinely the stupidest, most convoluted solution 
    # to what should be a VERY simple problem. What the hell.
    [[ "${repo}" =~ ([^/]+$) ]] && repo_name="${BASH_REMATCH[1]}"

    echo "================================================="
    echo "Checking ${repo_name}"
    echo ""

    cd ~
    cd ${repo}

    status=`git status`
    
    if [ ${dnc} -eq 0 ]
    then
        echo "${status}"
    else
        if [[ ! ${status} =~ ${re} ]]
        then
            echo "${status}"
        fi
    fi

    if [ ${bp} -eq 1 ]
    then
        if [[ ! ${status} =~ ${re} ]]
        then
            echo "NOT PULLING FOR ${repo_name}"
        else
            git pull
        fi
    fi

    # REMINDER: Spaces mess up strings, surround string vars with ""
    if [[ ${moc} != "default" ]] && [[ ! ${status} =~ ${re} ]]
    then
        git add .
        git commit -am "${moc}"

        if [ ${rp} -eq 1 ] 
        then
            git push
        fi
    fi

done < ${repo_list}
