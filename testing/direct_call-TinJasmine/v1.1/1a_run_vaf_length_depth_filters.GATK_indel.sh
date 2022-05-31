
OUTD="/data/VLD_FilterVCF.out"
mkdir -p $OUTD


  - /bin/bash
  - /opt/VLD_FilterVCF/src/run_germline_vaf_filter.sh


bash ../../src/run_vaf_length_depth_filters.sh $@ $ARG -o $OUT $VCF $CONFIG

