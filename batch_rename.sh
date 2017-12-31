#!/bin/sh

function showUsage {
    echo "Usage:  " `basename ${0}`" -s <suffix> -e <extension>"
}

if [ $# -eq 0 ]; 
then
    showUsage
    exit 1
fi

while getopts ":s:e:" o; do
    case "${o}" in
        s)
            echo "got into s case"
	    suffix=${OPTARG}
            ;;
        e)
            echo "got into e case"
	    ext=${OPTARG}
            ;;
        *)
            echo "got into * case"
	    showUsage
            ;;
    esac
done
shift ${OPTIND-1}

echo "EXT = ${ext}"
echo "SUFFIX = ${suffix}"

# Preview command
for FILE in *.${ext} 
do 
    echo mv "${FILE}" "${FILE/.${ext}/${suffix}.${ext}}"
done

# Actual command
#for FILE in *.PNG; do mv "${FILE}" "${FILE/.PNG/_p.PNG}"; done


