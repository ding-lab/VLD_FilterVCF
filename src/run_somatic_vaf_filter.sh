#/bin/bash

read -r -d '' USAGE_VAF <<'EOF'
Filter VCF files according to tumor, normal VAF values


Usage:
  bash run_somatic_vaf_filter.sh [options] VCF 

Options:
-h: Print this help message
-d: Dry run - output commands but do not execute them
-o OUT_VCF: Output VCF.  Default writes to STDOUT
-e: filter debug mode
-E: filter bypass
-C CONFIG_FN: optional filter configuration file with `somatic_vaf` section
-R: remove filtered variants.  Default is to retain filtered variants with filter name in VCF FILTER field
-m min_vaf_tumor: Retain sites where tumor VAF > than given value (aka min_vaf_somatic)
-x max_vaf_normal: Retain sites where normal VAF <= than given value (aka max_vaf_germline)
-c caller: specifies tool used for variant call. 'strelka', 'varscan', 'mutect', 'pindel', 'merged'
-T tumor_name: Tumor sample name in VCF
-N normal_name: Normal sample name in VCF

VCF is input VCF file
See python/germline_vaf_filter.py for additional details
...
EOF

FILTER_SCRIPT="somatic_vaf_filter.py"  # filter module
FILTER_NAME="somatic_vaf"
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
while getopts ":hdo:eERC:m:x:c:T:N:" opt; do
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
      FILTER_ARGS="$FILTER_ARGS --min_vaf_tumor $OPTARG"
      ;;
    x)
      FILTER_ARGS="$FILTER_ARGS --max_vaf_normal $OPTARG"
      ;;
    c)
      FILTER_ARGS="$FILTER_ARGS --caller $OPTARG"
      ;;
    T)
      FILTER_ARGS="$FILTER_ARGS --tumor_name $OPTARG"
      ;;
    N)
      FILTER_ARGS="$FILTER_ARGS --normal_name $OPTARG"
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

# `cat VCF | vcf_filter.py` avoids weird errors
FILTER_CMD="cat $VCF |  /usr/local/bin/vcf_filter.py $CMD_ARGS --local-script $FILTER_SCRIPT - $FILTER_NAME" # filter module
CMD="$FILTER_CMD  $FILTER_ARGS "
    
if [ $OUT_VCF != "-" ]; then
    CMD="$CMD > $OUT_VCF"
fi

run_cmd "$CMD" $DRYRUN

if [ $OUT_VCF != "-" ]; then
    >&2 echo Written to $OUT_VCF
fi

