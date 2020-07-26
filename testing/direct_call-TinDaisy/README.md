Testing of individual filters for TinDaisy on katmai.

Using test CCRCC case C3L-00908.
See MGI:/gscuser/mwyczalk/projects/TinDaisy/testing/dbSnP-filter-dev/VEP_annotate.testing.C3L-00908/testing/README.data.md
for details on this dataset.  It is based on CromwellRunner run: 06_CCRCC.HotSpot.20200511

Results of this run are copied to katmai here:
/home/mwyczalk_test/Projects/TinDaisy/testing/C3L-00908-data/dat

## Comparison to past results

The above run used Hotspot Filter, with two passes through vaf_length_depth filter for every VCF file prior to merge.
Each pass is with two parameter sets, A and B, which differ in `vaf` filter as,

A: min_vaf_somatic = 0.0
B: min_vaf_somatic = 0.05

To pick one call set, consider Varscan SNV variants processed with B parameter set.  Root directory of this on katmai:

/home/mwyczalk_test/Projects/TinDaisy/testing/C3L-00908-data/dat/call-hotspot_vld_varscan_snv/hotspot_vld.cwl/27ac9be3-7575-4477-8f85-5d3652992ee9/call-vaf_length_depth_filters_B

Relative to above,
* input config file:  inputs/-1343547268/vcf_filter_config-varscan.ini
* input VCF:          inputs/-246599121/varscan-remapped.vcf
* filter output:      execution/results/vaf_length_depth_filters/filtered.vcf

### Config file B

[vaf]
min_vaf_somatic = 0.05      -> renamed to min_vaf_tumor
max_vaf_germline = 0.02     -> renamed to max_vaf_normal
tumor_name = TUMOR
normal_name = NORMAL
caller = varscan

[length]
max_length = 100
min_length = 0 

[read_depth]
min_depth_tumor = 14
min_depth_normal = 8
tumor_name = TUMOR
normal_name = NORMAL
caller = varscan

## Testing strategy

Testing based on that done for Merge Filter here:
    /home/mwyczalk_test/Projects/TinDaisy/TinDaisy/submodules/MergeFilterVCF/testing/direct_call




