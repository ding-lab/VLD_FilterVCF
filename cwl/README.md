Summary of CWL files
* Tools
  * TinDaisy
    * somatic_vaf_filter.cwl
    * length_filter.cwl
    * somatic_depth_filter.cwl
  * TinJasmine
    * v1.1
      * VLD_FilterVCF.cwl
    * v1.2
      * germline_vaf_filter.cwl
      * length_filter.cwl
      * germline_depth_filter.cwl - 20220530
      * allele_depth_filter.cwl - 20220530
* Workflows
  * VLDA_Filter-germline.cwl
    * calls TinJasmine v1.2 tools in order listed


VLD_FilterVCF.cwl - this is older version being used for TinJasmine which has one script for all filters
    docker image: 'mwyczalkowski/vld_filter_vcf:20200614'

Individual filters:
    allele_depth_filter.cwl
    germline_depth_filter.cwl
    somatic_depth_filter.cwl
    germline_vaf_filter.cwl
    somatic_vaf_filter.cwl
    length_filter.cwl

The first two filters (all germline-related) had bugs in mwyczalkowski/vld_filter_vcf:20201009 which was
fixed in 'mwyczalkowski/vld_filter_vcf:20220530'.  The remaining 4 filters were unchanged between the two
versions.  Will update germline-only tools to the latter.

TinDaisy 2.6 has the somatic depth, somatic vaf, and length filters implemented as separate CWL
tools and parameters defined in CWL tool

VLD_FilterVCF.cwl is used for TinJasmine v1.1.  Filter parameters are read from configuration files
and interenally uses a series of filters chained with unix pipes

VLDA_Filter-germline.cwl is a CWL workflow for TinJasmine v1.2 consisting of 
calls germline vaf, length, germline depth, and allele depth
filters independently.  It is designed to replace VLD_FilterVCF.cwl

 src/run_allele_depth_filter.sh   |  2 +-
 src/run_germline_depth_filter.sh | 13 +++++++++----

