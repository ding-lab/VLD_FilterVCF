#/bin/bash

read -r -d '' USAGE_VAF <<'EOF'
Filter VCF files according to VAF values
Include only variants with min_vaf < VAF <= max_vaf and 
For multi-sample VCFs this criterion is applied to all samples

Usage:
  bash run_vaf_filter.sh [options] VCF CONFIG_FN

Options:
-h: Print this help message
-d: Dry run - output commands but do not execute them
-o OUT_VCF: Output VCF.  Default writes to STDOUT
-e: filter debug mode
-E: filter bypass
-C config: optional configuration file
-R: remove filtered variants.  Default is to retain filtered variants with filter name in VCF FILTER field
-m min_vaf: Retain sites where VAF > min_vaf
-x max_vaf: Retain sites where VAF <= max_vaf
-c caller: specifies tool used for variant call. 'strelka', 'varscan', 'pindel', 'merged', 'mutect', 'GATK'

VCF is input VCF file
CONFIG_FN is configuration file with `vaf` section
See python/vaf_filter.py for additional details
...
EOF

FILTER_SCRIPT="vaf_filter.py"  # filter module
FILTER_NAME="vaf"
USAGE="$USAGE_VAF"

### have all filter-specific details above, except for some filter-specific argument parsing below

# No provision is made for executing multiple consequtive filters using UNIX pipes
# (e.g., cmd1 | cmd2).  See https://github.com/ding-lab/VLD_FilterVCF run_vaf_length_depth_filters.sh for example of pipes

# call format
# cat VCF | vcf_filter.py CMD_ARGS --local-script FILTER_SCRIPT - $FILTER_NAME $FILTER_ARGS $CONFIG
# filter description: https://pyvcf.readthedocs.io/en/latest/FILTERS.html#adding-a-filter

source /opt/VLD_FilterVCF/src/utils.sh
SCRIPT=$(basename $0)

PYTHON_BIN="/usr/local/bin/python"

export PYTHONPATH="/opt/VLD_FilterVCF/src/python:$PYTHONPATH"
OUT_VCF="-"

# http://wiki.bash-hackers.org/howto/getopts_tutorial
while getopts ":hdo:eERC:m:x:c:" opt; do
  case $opt in
    h)
      echo "$USAGE"
      exit 0
      ;;
    d)  # binary argument
      DRYRUN=1
      ;;
    o)
      OUT_VCF="$OPTARG"
      ;;
    e)
      FILTER_ARGS="$FILTER_ARGS --debug"
      ;;
    E)
      FILTER_ARGS="$FILTER_ARGS --bypass"
      ;;
    R)
      CMD_ARGS="--no-filtered"
      ;;
    C)
      FILTER_ARGS="$FILTER_ARGS --config $OPTARG"
      ;;
    m)
      FILTER_ARGS="$FILTER_ARGS --min_vaf $OPTARG"
      ;;
    x)
      FILTER_ARGS="$FILTER_ARGS --max_vaf $OPTARG"
      ;;
    c)
      FILTER_ARGS="$FILTER_ARGS --caller $OPTARG"
      ;;
    \?)
      >&2 echo "Invalid option: -$OPTARG"
      >&2 echo "$USAGE"
      exit 1
      ;;
    :)
      >&2 echo "Option -$OPTARG requires an argument."
      >&2 echo "$USAGE"
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

if [ "$#" -ne 1 ]; then
    >&2 echo Error: Wrong number of arguments
    >&2 echo "$USAGE"
    exit 1
fi

VCF=$1 ; confirm $VCF

# Create output paths if necessary
if [ $OUT_VCF != "-" ]; then
    OUTD=$(dirname $OUT_VCF)
    run_cmd "mkdir -p $OUTD" $DRYRUN
fi

# Common configuration file is used for all filters
CONFIG="--config $CONFIG_FN"

# `cat VCF | vcf_filter.py` avoids weird errors
FILTER_CMD="cat $VCF |  /usr/local/bin/vcf_filter.py $CMD_ARGS --local-script $FILTER_SCRIPT - $FILTER_NAME" # filter module
CMD="$FILTER_CMD  $FILTER_ARGS $CONFIG --input_vcf $VCF"
    
if [ $OUT_VCF != "-" ]; then
    CMD="$CMD > $OUT_VCF"
fi

run_cmd "$CMD" $DRYRUN

if [ $OUT_VCF != "-" ]; then
    >&2 echo Written to $OUT_VCF
fi

