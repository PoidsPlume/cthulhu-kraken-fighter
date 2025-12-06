#!/bin/sh

arg0=$(basename "$0" .sh)
blnk=$(echo "$arg0" | sed 's/./ /g')

usage_info()
{
    echo "Usage: $arg0 input_directory  [{-s|--alto}] [{-o|--output} output_directory] \\"
    echo "       $blnk [{-m|--model} model_path]"
}

if [ $# -lt 1 ]; then
	echo "Error: you should give at least the folder to process"
	exit 1
fi

i_dir=$1


alto=""
model=''
o_dir="output"

while test $# -gt 0; do
	case "$1" in
		-h|--help)
			usage_info
			echo "options:"
			echo "-h, --help		show this help message and quit"
			echo "-a, --alto		make outputfile in alto format"
			echo "-o, --output=DIR	set output directory, default is 'output'"
			echo "-m, --model=MODEL_PATH	specify the model to use"
			echo "see kraken --help for further information (especially about model)"
			exit 0
			;;
		-a|--alto)
			export alto="-a"
			shift
			;;
		-o)
			shift
			if test $# -gt 0; then
				export o_dir=$1
			else
				echo "Error: Output dir must be specified"
				exit 1
			fi
			shift
			;;
		--output*)
			export o_dir=${1##*=}
			shift
			;;
		-m)
			shift
			if test $# -gt 0; then
				export model="-m $1"
			else
				echo "Error: Model path must be specified"
				exit 1
			fi
			shift
			;;
		--model*)
			model_tmp=${1##*=}
			export model="-m $model_tmp"
			shift
			;;
		*)
			shift
			;;
	esac
done

echo "$o_dir"
echo "$model"



if ! [ -d $i_dir ]; then
	echo "Error: $1 is not a directory"
	exit 1
fi

if ! [ -d $o_dir ]; then
	mkdir $o_dir
fi

for file in "$i_dir"/*
do
	f_base=${file##*/}
	f_base=${f_base%%.*}

	if [ ${#alto} -gt 0 ]; then
		fname="$f_base.xml"
	else
		fname="$f_base.txt"
	fi

	kraken $alto -i $file $o_dir/$fname segment -bl ocr $model
done

exit 0



