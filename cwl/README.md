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
      * germline_depth_filter.cwl
      * allele_depth_filter.cwl
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
All of these are based on image 'mwyczalkowski/vld_filter_vcf:20201009'

TinDaisy 2.6 has the somatic depth, somatic vaf, and length filters implemented as separate CWL
tools and parameters defined in CWL tool

VLD_FilterVCF.cwl is used for TinJasmine v1.1.  Filter parameters are read from configuration files
and interenally uses a series of filters chained with unix pipes

VLDA_Filter-germline.cwl is a CWL workflow for TinJasmine v1.2 consisting of 
calls germline vaf, length, germline depth, and allele depth
filters independently.  It is designed to replace VLD_FilterVCF.cwl
