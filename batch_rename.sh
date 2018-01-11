#!/bin/sh

function showUsage {
    echo "Usage:  " `basename ${0}`" -p [-f] -s <suffix> -e <extension>"
}

if [ $# -lt 2 ]; 
then
    showUsage
    exit 1
fi

while getopts "pvfs:e:" o; do
    case "${o}" in
	p)
	    previewOnly=true
	    ;;
        s)
	    suffix=${OPTARG}
            ;;
        e)
	    ext=${OPTARG}
            ;;
	v) 
	    verbose=true
	    ;;
	f)
	    force=true
	    ;;
        *)
	    showUsage
            ;;
    esac
done
shift ${OPTIND-1}

# Print Variables
if [[ "${verbose}" = "true" ]]
then
	echo "VERBOSE = ${verbose}"
	echo "PREVIEW ONLY = ${previewOnly}"
	echo "FORCE = ${force}"
	echo "EXT = ${ext}"
	echo "SUFFIX = ${suffix}"
fi

# Do Stuff!


for FILE in `ls *.${ext}`
do 
	NEWFILE="${FILE/.${ext}/${suffix}.${ext}}"

	if [[ "${previewOnly}" = "true" ]]
	then
		# Preview command
		echo "Preview:    mv ${FILE} ${NEWFILE}" 
	else		
		if [[ "${verbose}" = "true" ]]
		then
			echo "Moving ${FILE} to ${NEWFILE}"
		fi
		if [[ "${force}" = "true" ]]
		then
			mv "${FILE}" "${NEWFILE}"
		else
			echo "Are you sure you want to rename ${FILE} to ${NEWFILE}?"
			select yn in "Yes" "No"; do
    				case $yn in
        				Yes ) mv "${FILE}" "${NEWFILE}"; break;;
        				No ) exit;;
    				esac
			done
		fi
	fi
done

