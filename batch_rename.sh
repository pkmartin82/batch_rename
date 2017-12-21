#!/bin/sh

function showUsage {
    echo "Usage:  " `basename ${0}`" -s <suffix> -ext <extension>"
}

if [ $# -eq 0 ]; 
then
    showUsage
    exit 1
fi

while getopts ":s:ext:" o; do
    case "${o}" in
        s)
            echo "got into s case"
	    suffix = ${OPTARG}
            ;;
        ext)
            echo "got into ext case"
	    ext=${OPTARG}
            ;;
        *)
            echo "got into * case"
	    showUsage
            ;;
    esac
done
shift $((OPTIND-1))


# Preview command
for FILE in *.PNG; do echo mv "${FILE}" "${FILE/.PNG/${suffix}.PNG}"; done

# Actual command
#for FILE in *.PNG; do mv "${FILE}" "${FILE/.PNG/_p.PNG}"; done


