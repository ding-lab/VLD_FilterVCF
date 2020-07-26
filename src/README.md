Filter code similar to that here: https://github.com/ding-lab/VEP_Filter.git

## Development notes

Initial CWL implementation for TinDaisy, vaf_length_depth_filters.cwl, was based on TinDaisy image: https://github.com/ding-lab/TinDaisy-Core
    with the filter implementation here: TinDaisy-Core/src/vcf_filters

Updated version for TinJasmine: https://github.com/ding-lab/VLD_FilterVCF.git
consists of independent github project / CWL tool

Initial workflows have for both TinDaisy and TinJasmine call all filters with one script, with 
each filter call connected via UNIX pipes (filter1 | filter2) for performance and lack of intermediate files.
Example is ./run_vaf_length_depth_filters.sh

Subsequent work in a sister project, VLD_FilterVCF breaks up the filters into separate CWL calls.  This makes
the indvidual steps simpler at the expense of performance.
    https://github.com/ding-lab/VLD_FilterVCF.git

This approach is being adopted for TinDaisy (20200725, and we provide CWL steps for individual VAF, Length, Depth filters.
Calling ./run_vaf_length_depth_filters.sh and skipping the AF filter will reproduce these results

### VAF Filter
VAF filter code (src/vcf_filters/vaf_filter.py) from TinDaisy is specific to somatic calls, with tumor and normal
samples assumed.  It is being renamed vaf_filter_somatic.py

VAF filter code (python/vaf_filter.py) from VLD_FilterVCF is based on the above
and is currently specific to germline, though could be more readily generalied.  It is being
renamed vaf_filter_germline.py


## pyvcf code
FYI: pyvcf code can be found on image here: /usr/local/lib/python3.8/site-packages/vcf

